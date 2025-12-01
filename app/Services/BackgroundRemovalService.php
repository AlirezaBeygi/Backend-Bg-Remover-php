<?php

namespace App\Services;

use Illuminate\Support\Facades\Storage;
use GuzzleHttp\Client;

class BackgroundRemovalService
{
    public function removeBackground($imagePath, $jobId)
    {
        try {
            $fullPath = Storage::disk('public')->path($imagePath);

            // Ensure directory exists
            Storage::disk('public')->makeDirectory('processed');

            // Create processed path
            $processedPath = 'processed/' . time() . '_' . basename($imagePath);
            $processedFullPath = Storage::disk('public')->path($processedPath);

            // Use remove.bg API via Guzzle
            $client = new \GuzzleHttp\Client([
                'verify' => 'C:\php\extras\ssl\cacert.pem', // path to cacert.pem
            ]);

            $response = $client->post('https://api.remove.bg/v1.0/removebg', [
                'multipart' => [
                    [
                        'name'     => 'image_file',
                        'contents' => fopen($fullPath, 'r'),
                    ],
                    [
                        'name'     => 'size',
                        'contents' => 'auto',
                    ],
                ],
                'headers' => [
                    'X-Api-Key' => env('REMOVE_BG_API_KEY'),
                ],
            ]);

            // Save processed image
            file_put_contents($processedFullPath, $response->getBody());

            return [
                'success' => true,
                'result_path' => $processedPath,
            ];
        } catch (\Exception $e) {
            return [
                'success' => false,
                'error' => $e->getMessage(),
            ];
        }
    }
}

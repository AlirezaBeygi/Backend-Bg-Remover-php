<?php

namespace App\Http\Controllers;

use App\Models\Job;
use App\Services\BackgroundRemovalService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;

class BackgroundRemovalController extends Controller
{
    protected $bgRemovalService;

    public function __construct(BackgroundRemovalService $bgRemovalService)
    {
        $this->bgRemovalService = $bgRemovalService;
    }

    /**
     * Remove background from uploaded image
     */
    public function removeBackground(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'image' => 'required|image|mimes:jpeg,jpg,png|max:10240', // Max 10MB
        ]);

        if ($validator->fails()) {
            return response()->json([
                'error' => 'Validation failed',
                'messages' => $validator->errors()
            ], 422);
        }

        try {
            $user = auth()->user();
            $image = $request->file('image');

            // Store original image
            $originalPath = $image->store('images', 'public');
            $originalUrl = Storage::disk('public')->url($originalPath);

            // Create job record
            $job = Job::create([
                'user_id' => $user->id,
                'original_image_path' => $originalPath,
                'status' => 'processing',
                'progress' => 0,
            ]);

            // Process image (synchronous for now, can be made async with queues)
            $result = $this->bgRemovalService->removeBackground($originalPath, $job->id);

            if ($result['success']) {
                $job->update([
                    'status' => 'completed',
                    'progress' => 100,
                    'result_image_path' => $result['result_path'],
                ]);

                $resultUrl = Storage::disk('public')->url($result['result_path']);

                return response()->json([
                    'result_url' => $resultUrl,
                    'job_id' => $job->id,
                    'status' => 'completed'
                ], 200);
            } else {
                $job->update([
                    'status' => 'failed',
                ]);

                return response()->json([
                    'error' => $result['error'] ?? 'Failed to process image'
                ], 500);
            }
        } catch (\Exception $e) {
            return response()->json([
                'error' => 'Server error: ' . $e->getMessage()
            ], 500);
        }
    }

    /**
     * Get job status
     */
    public function getJobStatus(Request $request, $jobId)
    {
        try {
            $user = auth()->user();
            $job = Job::where('id', $jobId)
                ->where('user_id', $user->id)
                ->firstOrFail();

            $response = [
                'status' => $job->status,
                'progress' => $job->progress,
            ];

            if ($job->status === 'completed' && $job->result_image_path) {
                $response['result_url'] = Storage::disk('public')->url($job->result_image_path);
            }

            return response()->json($response, 200);
        } catch (\Exception $e) {
            return response()->json([
                'error' => 'Job not found'
            ], 404);
        }
    }
}


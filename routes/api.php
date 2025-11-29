<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\BackgroundRemovalController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
*/

// Public routes
Route::post('/auth/login', [AuthController::class, 'login']);

// Protected routes
Route::middleware('auth:api')->group(function () {
    Route::post('/remove-background', [BackgroundRemovalController::class, 'removeBackground']);
    Route::get('/job/{jobId}/status', [BackgroundRemovalController::class, 'getJobStatus']);
});


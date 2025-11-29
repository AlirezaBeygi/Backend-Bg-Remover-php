<?php

use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return response()->json([
        'message' => 'Background Remover API',
        'version' => '1.0.0'
    ]);
});


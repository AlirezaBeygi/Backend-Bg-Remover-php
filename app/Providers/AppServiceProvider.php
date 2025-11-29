<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        // Ensure view paths are set
        if (is_null(config('view.paths'))) {
            config(['view.paths' => [resource_path('views')]]);
        }
    }
}


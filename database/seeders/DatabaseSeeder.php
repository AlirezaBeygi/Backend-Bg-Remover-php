<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // Create a test user if it doesn't exist
        $user = User::where('username', 'testuser')->first();
        
        if (!$user) {
            User::create([
                'username' => 'testuser',
                'email' => 'test@example.com',
                'password' => Hash::make('password123'),
            ]);
            $this->command->info('Test user created:');
        } else {
            $this->command->info('Test user already exists:');
        }
        
        $this->command->info('Username: testuser');
        $this->command->info('Password: password123');
    }
}


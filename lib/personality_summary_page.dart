
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PersonalitySummaryPage extends StatelessWidget {
  final String personality;

  const PersonalitySummaryPage({super.key, this.personality = "The Social Savorer"});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Welcome to the Club!',
                textAlign: TextAlign.center,
                style: textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildPersonalityCard(context),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                icon: const Icon(Icons.celebration),
                label: const Text('Discover Events'),
                onPressed: () {
                  context.go('/home'); // Navigate to the main app
                },
              ),
              const SizedBox(height: 16),
              TextButton.icon(
                icon: const Icon(Icons.person_add_alt_1),
                label: const Text('Invite Friends'),
                onPressed: () {
                  // TODO: Implement friend invite functionality
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalityCard(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: Colors.black.withAlpha(26), // ~10% opacity
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 40,
              // Placeholder for a user profile picture or a fun icon
              child: Icon(Icons.restaurant, size: 40),
            ),
            const SizedBox(height: 16),
            Text(
              'You are...',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Text(
              personality,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Get ready to explore amazing food and meet awesome people who share your tastes!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:fleegram/core/utils/date_formatter.dart';
import 'package:fleegram/data/models/story_model.dart';
import 'package:flutter/material.dart';

class DetailStoryPage extends StatelessWidget {
  final Story story;

  const DetailStoryPage({super.key, required this.story});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Story Detail')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              story.photoUrl,
              fit: BoxFit.contain,
              width: double.infinity,
              errorBuilder: (_, _, _) {
                return const Center(child: Icon(Icons.broken_image, size: 64));
              },
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return const Center(child: CircularProgressIndicator());
              },
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    story.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Text(
                    DateFormatter.formatIndo(story.createdAt),
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  ),
                  const SizedBox(height: 16),

                  Text(story.description, style: const TextStyle(fontSize: 14)),

                  if (story.lat != null && story.lon != null) ...[
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 18),
                        const SizedBox(width: 8),
                        Text(
                          'Lat: ${story.lat}, Lon: ${story.lon}',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

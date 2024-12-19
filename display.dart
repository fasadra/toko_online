import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PostScreen(),
    );
  }
}

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Building layouts'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section
            Container(
              width: double.infinity,
              height: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://images.unsplash.com/photo-1502790671504-542ad42d5189?auto=format&fit=crop&w=800&q=60'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Content section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Malam',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.red),
                          const SizedBox(width: 4),
                          Text(
                            '41',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Bintang dan Bulan dua keindahan malam',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),

                  // Action buttons
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildActionButton(
                        icon: Icons.call,
                        label: 'CALL',
                        color: Colors.blue,
                      ),
                      _buildActionButton(
                        icon: Icons.near_me,
                        label: 'ROUTE',
                        color: Colors.blue,
                      ),
                      _buildActionButton(
                        icon: Icons.share,
                        label: 'SHARE',
                        color: Colors.blue,
                      ),
                    ],
                  ),

                  // Description
                  const SizedBox(height: 16),
                  const Text(
                    'kamu tidak berhenti memberikan keindahan yang sering aku harapkan, '
                    'kamu, ciptaan yang diam dan bersinar, sinar indah yang menyinari bumu di gelapnya langit malam '
                    'membuat dirimu terlihat sempurna, setiap malam aku selalu memandang mu'
                    'mengharapkan keindahan mu terus bertahan hingga selamanya'
                    'bulan dan bintang, dua keindahan yang hanya dapat ku lihat',
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

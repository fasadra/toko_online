import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 56, 196, 63),
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Aplikasi 1'),
    );
  }
}
class FloatingActionButtonExampleApp extends StatelessWidget {
  const FloatingActionButtonExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const FloatingActionButtonExample(),
    );
  }
}

class FloatingActionButtonExample extends StatefulWidget {
  const FloatingActionButtonExample({super.key});

  @override
  State<FloatingActionButtonExample> createState() =>
      _FloatingActionButtonExampleState();
}

class _FloatingActionButtonExampleState
    extends State<FloatingActionButtonExample> {
  // The FAB's foregroundColor, backgroundColor, and shape
  static const List<(Color?, Color? background, ShapeBorder?)> customizations =
      <(Color?, Color?, ShapeBorder?)>[
    (null, null, null), // The FAB uses its default for null parameters.
    (null, Colors.green, null),
    (Colors.white, Colors.green, null),
    (Colors.white, Colors.green, CircleBorder()),
  ];
  int index = 0; // Selects the customization.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FloatingActionButton Sample'),
      ),
      body: const Center(child: Text('Press the button below!')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            index = (index + 1) % customizations.length;
          });
        },
        foregroundColor: customizations[index].$1,
        backgroundColor: customizations[index].$2,
        shape: customizations[index].$3,
        child: const Icon(Icons.navigation),
      ),
    );
  }
}


class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings), // Tambah icon di AppBar
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Settings icon pressed')),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'HAII GUYSS,I MISS U',
              style: TextStyle(color: Color.fromARGB(255, 189, 22, 10)),
            ),
            const SizedBox(height: 20), // Spacing between text and image
            Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2JVdjuhfUhU6vU2f0vZQX9oy5UgGuOFU5Og&s', 
              width: 200, // Set desired width
              height: 200, // Set desired height
              fit: BoxFit.cover, // Optional: scale image to fit
            ),
            const SizedBox(height: 20), // Spacing between image and icons
            // Tambahkan 3 icon di bawah gambar
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.home, size: 40, color: Color.fromARGB(255, 73, 101, 129)),
                SizedBox(width: 20), // Spacing between icons
                Icon(Icons.favorite, size: 40, color: Color.fromARGB(255, 137, 144, 231)),
                SizedBox(width: 20), // Spacing between icons
                Icon(Icons.person, size: 40, color: Color.fromARGB(255, 79, 70, 204)),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Floating Action Button pressed')),
          );
        },
        child: const Icon(Icons.add), // Tambah icon di FloatingActionButton
      ),
    );
  }
}
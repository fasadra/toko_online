import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginScreen(), // Halaman pertama adalah LoginScreen
    );
  }
}

class UserStatus {
  static bool isRegistered = false;
  static String username = '';
}

class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(
              'https://tse1.mm.bing.net/th?id=OIP.PVdf9IWslZXQ5Azna6q8dAHaFE&pid=Api&P=0&h=180',
              height: 180,
            ),
            SizedBox(height: 20),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (UserStatus.isRegistered) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    } else {
                      _showErrorDialog(
                          context, 'Anda harus registrasi terlebih dahulu.');
                    }
                  },
                  child: Text('Submit'),
                ),
                ElevatedButton(
                  onPressed: () {
                    usernameController.clear();
                    passwordController.clear();
                  },
                  child: Text('Cancel'),
                ),
              ],
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              },
              child: Text('Belum punya akun? Registrasi'),
            ),
          ],
        ),
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class RegisterScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registrasi')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nama'),
            ),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    UserStatus.isRegistered = true;
                    UserStatus.username = usernameController.text;
                    Navigator.pop(context); // Kembali ke LoginScreen
                  },
                  child: Text('Submit'),
                ),
                ElevatedButton(
                  onPressed: () {
                    nameController.clear();
                    usernameController.clear();
                    emailController.clear();
                    passwordController.clear();
                  },
                  child: Text('Cancel'),
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Kembali ke LoginScreen
              },
              child: Text('Sudah punya akun? Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Utama'),
        leading: IconButton(
          icon: Icon(Icons.logout),
          onPressed: () {
            UserStatus.isRegistered = false;
            UserStatus.username = '';
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
              (route) => false,
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildIconCard(context, 'Artikel', Icons.phone_android),
                  SizedBox(width: 15),
                  _buildIconCard(context, 'Icon 2', Icons.access_alarm),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildIconCard(context, 'Icon 3', Icons.accessibility),
                  SizedBox(width: 15),
                  _buildIconCard(context, 'Icon 4', Icons.account_circle),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconCard(BuildContext context, String title, IconData icon) {
    return SizedBox(
      width: 100,
      height: 120,
      child: InkWell(
        onTap: () {
          if (title == 'Artikel') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ArticleScreen()),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    IconDetailScreen(icon: icon, title: title),
              ),
            );
          }
        },
        child: Card(
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 30),
                SizedBox(height: 8),
                Flexible(
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 12),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ArticleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pemograman Mobile'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              UserStatus.isRegistered = false;
              UserStatus.username = '';
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pengantar pemograman mobile',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                '''Pemrograman Mobile adalah proses pembuatan aplikasi untuk perangkat seperti smartphone dan tablet, yang kini sangat dibutuhkan di berbagai bidang seperti bisnis, pendidikan, dan hiburan. Sejarahnya berkembang pesat sejak tahun 2007 dengan peluncuran *iPhone* dan *App Store* dari Apple, yang memungkinkan pengembang mempublikasikan aplikasi secara luas.

Aplikasi mobile dibedakan menjadi beberapa jenis:

1. Aplikasi Native: Dikembangkan khusus untuk platform tertentu (seperti Android atau iOS) dengan bahasa pemrograman asli seperti Java atau Swift, sehingga memiliki performa tinggi.
  
2. Aplikasi Web: Berbasis web dan diakses melalui browser. Fleksibel namun dengan keterbatasan integrasi perangkat.

3. Aplikasi Hybrid: Menggabungkan elemen native dan web, sehingga bisa berjalan di berbagai platform dengan satu kode dasar, namun mungkin sedikit mengorbankan performa.

Pemrograman mobile memungkinkan integrasi fitur perangkat seperti GPS, kamera, dan sensor, sehingga aplikasi mobile menjadi semakin canggih dan memenuhi kebutuhan pengguna yang beragam.''',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Update the IconDetailScreen to handle the roof article
class IconDetailScreen extends StatelessWidget {
  final IconData icon;
  final String title;

  IconDetailScreen({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    // If this is Icon 2, show the roof article
    if (title == 'Icon 2') {
      return Scaffold(
        appBar: AppBar(title: Text('Atap Rumah')),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image section
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1502957291543-d85480254bf8',
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Title and rating section
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Atap Rumah',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Aku Berlindung dari sinar dan air',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                          ],
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
                  ),

                  // Action buttons
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildActionButton(
                          icon: Icons.call,
                          label: 'CALL',
                          color: Colors.blue,
                        ),
                        _buildActionButton(
                          icon: Icons.navigation,
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
                  ),

                  // Text content
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'kamu tidak berhenti memberikan keindahan yang sering aku lewatkan, '
                      'kamu, ciptaan yang diam tapi aku faham maksudmu, kesibukan dan '
                      'cimpak ku membuat dirimu terlihat biasa,, hari ini aku menatap '
                      'mu dengan hati yang luasss, diam mu membuat aku bersyukur, '
                      'SEMESTA. Aku menyerah, bawa aku dalam senjamu...-tenang',
                      style: TextStyle(
                        color: Colors.grey[700],
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    // Default view for other icons
    return Scaffold(
      appBar: AppBar(title: Text('Detail $title')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 100, color: Colors.blue),
              SizedBox(height: 20),
              Text(
                'This is the detail page for $title',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
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
        IconButton(
          icon: Icon(icon),
          color: color,
          onPressed: () {},
        ),
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

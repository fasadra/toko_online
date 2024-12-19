import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class Contact {
  String id;
  String name;
  String email;
  String phone;
  String company;

  Contact({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.company,
  });
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.forward();

    // Changed navigation to LoginScreen instead of HomeScreen
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade300, Colors.blue.shade600],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeTransition(
                opacity: _animation,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(20),
                  child: Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/c/c3/Logo_PMII.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: 30),
              FadeTransition(
                opacity: _animation,
                child: Text(
                  'Welcome to Mercu Buana App',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SplashScreen(),
    );
  }
}

class AuthFrame extends StatelessWidget {
  final Widget child;
  final String title;

  const AuthFrame({Key? key, required this.child, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade100, Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: child,
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

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
        leading: IconButton(
          icon: Icon(Icons.login),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _handleLogout(context),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade100, Colors.white],
          ),
        ),
        // Menggunakan Center untuk memastikan konten berada di tengah
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  // Memberikan lebar maksimum untuk card
                  constraints: BoxConstraints(maxWidth: 300),
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildIconCard(
                              context, 'Kalkulator', Icons.calculate),
                          SizedBox(width: 20),
                          _buildIconCard(context, 'Dzikir', Icons.mosque),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildIconCard(
                              context, 'Galeri', Icons.photo_library),
                          SizedBox(width: 20),
                          _buildIconCard(
                              context, 'Kontak', Icons.contact_phone),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconCard(BuildContext context, String title, IconData icon) {
    return SizedBox(
      width: 100,
      height: 100,
      child: InkWell(
        onTap: () {
          if (title == 'Kalkulator') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CalculatorScreen()),
            );
          } else if (title == 'Dzikir') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DhikirScreen()),
            );
          } else if (title == 'Galeri') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GalleryPage()),
            );
          } else if (title == 'Kontak') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ContactScreen()),
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
                Icon(icon, size: 40),
                SizedBox(height: 8),
                Text(
                  title,
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _handleLogout(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Konfirmasi Logout'),
        content: Text('Apakah Anda yakin ingin keluar?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              UserStatus.isRegistered = false;
              UserStatus.username = '';
              UserStatus.email = '';
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Berhasil logout'),
                  backgroundColor: Colors.green,
                ),
              );

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            child: Text('Ya, Logout'),
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
          ),
        ],
      );
    },
  );
}

class IconDetailScreen extends StatelessWidget {
  final IconData icon;
  final String title;

  const IconDetailScreen({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 100,
              color: Colors.blue,
            ),
            SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Halaman ini masih dalam pengembangan',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserStatus {
  static bool isRegistered = false;
  static String username = '';
  static String email = '';
}

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AuthFrame(
      title: 'Login',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(
            'https://d22gwcrfo2de51.cloudfront.net/wp-content/uploads/2021/07/logo-universitas-mercu-buana_thumb.png',
            height: 180,
          ),
          SizedBox(height: 20),
          TextField(
            controller: usernameController,
            decoration: InputDecoration(
              labelText: 'Username',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.lock),
            ),
            obscureText: true,
          ),
          SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (usernameController.text.isEmpty ||
                        passwordController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Username dan password harus diisi'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    if (UserStatus.isRegistered) {
                      if (usernameController.text == UserStatus.username) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      } else {
                        _showErrorDialog(
                            context, 'Username atau password salah');
                      }
                    } else {
                      _showErrorDialog(
                          context, 'Anda harus registrasi terlebih dahulu.');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
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
  RegisterScreen({Key? key}) : super(key: key);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AuthFrame(
      title: 'Registrasi',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(
            'https://d22gwcrfo2de51.cloudfront.net/wp-content/uploads/2021/07/logo-universitas-mercu-buana_thumb.png',
            height: 180,
          ),
          SizedBox(height: 20),
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Nama',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.email),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 16),
          TextField(
            controller: usernameController,
            decoration: InputDecoration(
              labelText: 'Username',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.account_circle),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.lock),
            ),
            obscureText: true,
          ),
          SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (nameController.text.isEmpty ||
                        emailController.text.isEmpty ||
                        usernameController.text.isEmpty ||
                        passwordController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Semua field harus diisi'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    UserStatus.isRegistered = true;
                    UserStatus.username = usernameController.text;
                    UserStatus.email = emailController.text;

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Registrasi berhasil!'),
                        backgroundColor: Colors.green,
                      ),
                    );

                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Sudah punya akun? Login'),
          ),
        ],
      ),
    );
  }
}

class PageFrame extends StatelessWidget {
  final Widget child;
  final String title;
  final Widget? floatingActionButton;

  const PageFrame({
    Key? key,
    required this.child,
    required this.title,
    this.floatingActionButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blue,
        elevation: 2,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade50, Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: child,
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";
  String _currentInput = "";
  double _num1 = 0;
  String _operation = "";

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _output = "0";
        _currentInput = "";
        _num1 = 0;
        _operation = "";
      } else if (buttonText == "+" ||
          buttonText == "-" ||
          buttonText == "x" ||
          buttonText == "/") {
        _num1 = double.parse(_output);
        _operation = buttonText;
        _currentInput = "";
      } else if (buttonText == "=") {
        double num2 = double.parse(_currentInput);

        if (_operation == "+") {
          _output = (_num1 + num2).toString();
        }
        if (_operation == "-") {
          _output = (_num1 - num2).toString();
        }
        if (_operation == "x") {
          _output = (_num1 * num2).toString();
        }
        if (_operation == "/") {
          _output = (_num1 / num2).toString();
        }

        _num1 = 0;
        _operation = "";
        _currentInput = _output;
      } else {
        if (_currentInput == "") {
          _currentInput = buttonText;
          _output = buttonText;
        } else {
          _currentInput += buttonText;
          _output = _currentInput;
        }
      }
    });
  }

  Widget _buildButton(String buttonText, {Color color = Colors.blue}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: EdgeInsets.symmetric(vertical: 20),
          ),
          onPressed: () => _buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kalkulator'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade50, Colors.white],
          ),
        ),
        child: Column(
          children: [
            // Output Display
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.bottomRight,
                padding: EdgeInsets.all(20),
                child: Text(
                  _output,
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            // Buttons
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  // First Row
                  Row(
                    children: [
                      _buildButton("C", color: Colors.red),
                      _buildButton("/", color: Colors.orange),
                      _buildButton("x", color: Colors.orange),
                    ],
                  ),
                  // Second Row
                  Row(
                    children: [
                      _buildButton("7"),
                      _buildButton("8"),
                      _buildButton("9"),
                    ],
                  ),
                  // Third Row
                  Row(
                    children: [
                      _buildButton("4"),
                      _buildButton("5"),
                      _buildButton("6"),
                    ],
                  ),
                  // Fourth Row
                  Row(
                    children: [
                      _buildButton("1"),
                      _buildButton("2"),
                      _buildButton("3"),
                    ],
                  ),
                  // Last Row
                  Row(
                    children: [
                      _buildButton("-",
                          color: const Color.fromARGB(255, 38, 109, 190)),
                      _buildButton("0"),
                      _buildButton("+",
                          color: const Color.fromARGB(255, 28, 64, 161)),
                    ],
                  ),
                  // Equals Row
                  Row(
                    children: [
                      _buildButton("=",
                          color: const Color.fromARGB(255, 31, 73, 121)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DhikirScreen extends StatefulWidget {
  @override
  _DhikirScreenState createState() => _DhikirScreenState();
}

class _DhikirScreenState extends State<DhikirScreen> {
  int _subhanAllahCount = 0;
  int _alhamdulillahCount = 0;
  int _allahuAkbarCount = 0;
  int _totalCount = 0;

  // List untuk counter kustom
  List<CustomDzikir> _customDzikirs = [];

  void _incrementSubhanAllah() {
    setState(() {
      _subhanAllahCount++;
      _totalCount++;
    });
  }

  void _incrementAlhamdulillah() {
    setState(() {
      _alhamdulillahCount++;
      _totalCount++;
    });
  }

  void _incrementAllahuAkbar() {
    setState(() {
      _allahuAkbarCount++;
      _totalCount++;
    });
  }

  void _showResetConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Reset Hitungan Dzikir'),
          content:
              Text('Apakah Anda yakin ingin mereset semua hitungan dzikir?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Batal'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                setState(() {
                  _subhanAllahCount = 0;
                  _alhamdulillahCount = 0;
                  _allahuAkbarCount = 0;
                  _totalCount = 0;
                  _customDzikirs.clear();
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Hitungan dzikir berhasil direset'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: Text('Reset'),
            ),
          ],
        );
      },
    );
  }

  void _addCustomDzikir() {
    final _customNameController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tambah Dzikir Baru'),
          content: TextField(
            controller: _customNameController,
            decoration: InputDecoration(
              hintText: 'Masukkan nama dzikir',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_customNameController.text.isNotEmpty) {
                  setState(() {
                    _customDzikirs.add(CustomDzikir(
                        name: _customNameController.text, count: 0));
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text('Tambah'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Penghitung Dzikir'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _showResetConfirmation,
            tooltip: 'Reset Semua Hitungan',
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green[50]!, Colors.white],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Total Dzikir: $_totalCount',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green[800]!,
              ),
            ),
            SizedBox(height: 30),
            _buildDhikirCounter('Subhan Allah', _subhanAllahCount,
                _incrementSubhanAllah, Colors.blue),
            _buildDhikirCounter('Alhamdulillah', _alhamdulillahCount,
                _incrementAlhamdulillah, Colors.green),
            _buildDhikirCounter('Allahu Akbar', _allahuAkbarCount,
                _incrementAllahuAkbar, Colors.red),

            // Bagian untuk dzikir kustom
            ..._customDzikirs
                .map((customDzikir) => _buildCustomDhikirCounter(customDzikir))
                .toList(),

            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Tekan tombol untuk menambah hitungan dzikir',
                  style: TextStyle(
                    color: Colors.grey[600]!,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(width: 10),
                FloatingActionButton(
                  mini: true,
                  onPressed: _addCustomDzikir,
                  child: Icon(Icons.add),
                  backgroundColor: Colors.purple,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDhikirCounter(
      String title, int count, VoidCallback onPressed, Color color) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
          color: color == Colors.blue
              ? Colors.blue[50]!
              : color == Colors.green
                  ? Colors.green[50]!
                  : color == Colors.red
                      ? Colors.red[50]!
                      : Colors.grey[50]!,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: Colors.grey[300]!, blurRadius: 5, offset: Offset(0, 3))
          ]),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color == Colors.blue
                ? Colors.blue[800]!
                : color == Colors.green
                    ? Colors.green[800]!
                    : color == Colors.red
                        ? Colors.red[800]!
                        : Colors.grey[800]!,
          ),
        ),
        trailing: Text(
          '$count',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color == Colors.blue
                ? Colors.blue[900]!
                : color == Colors.green
                    ? Colors.green[900]!
                    : color == Colors.red
                        ? Colors.red[900]!
                        : Colors.grey[900]!,
          ),
        ),
        onTap: onPressed,
      ),
    );
  }

  Widget _buildCustomDhikirCounter(CustomDzikir customDzikir) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.purple[50]!,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: Colors.grey[300]!, blurRadius: 5, offset: Offset(0, 3))
          ]),
      child: ListTile(
        title: Text(
          customDzikir.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.purple[800]!,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${customDzikir.count}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.purple[900]!,
              ),
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                setState(() {
                  _customDzikirs.remove(customDzikir);
                });
              },
            ),
          ],
        ),
        onTap: () {
          setState(() {
            customDzikir.count++;
            _totalCount++;
          });
        },
      ),
    );
  }
}

class CustomDzikir {
  String name;
  int count;

  CustomDzikir({required this.name, this.count = 0});
}

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  Future<List<dynamic>> fetchImages() async {
    final response = await http.get(Uri.parse(
        'https://api.slingacademy.com/v1/sample-data/photos?offset=0&limit=60'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['photos'];
    } else {
      throw Exception('Failed to load images');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Galeri'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchImages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading images'));
          } else {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Image.network(snapshot.data![index]['url']);
              },
            );
          }
        },
      ),
    );
  }
}

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  List<Contact> _contacts = [];
  bool _isLoading = true;
  String _errorMessage = '';

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _companyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future<void> _fetchContacts() async {
    try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/users'),
      );

      if (response.statusCode == 200) {
        setState(() {
          _contacts = (jsonDecode(response.body) as List).map((contactData) {
            return Contact(
              id: contactData['id'].toString(),
              name: contactData['name'],
              email: contactData['email'],
              phone: contactData['phone'],
              company: contactData['company']['name'],
            );
          }).toList();
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to load contacts';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  void _deleteContact(Contact contact) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hapus Kontak'),
          content:
              Text('Apakah Anda yakin ingin menghapus kontak ${contact.name}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Batal'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                setState(() {
                  _contacts.removeWhere((c) => c.id == contact.id);
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Kontak ${contact.name} berhasil dihapus'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  void _addContact() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tambah Kontak Baru'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Nama',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: 'Nomor Telepon',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _companyController,
                  decoration: InputDecoration(
                    labelText: 'Perusahaan',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _clearControllers();
              },
              child: Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_validateInput()) {
                  setState(() {
                    _contacts.add(Contact(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      name: _nameController.text,
                      email: _emailController.text,
                      phone: _phoneController.text,
                      company: _companyController.text,
                    ));
                  });
                  Navigator.of(context).pop();
                  _clearControllers();
                }
              },
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  bool _validateInput() {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _companyController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Semua field harus diisi'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
    return true;
  }

  void _clearControllers() {
    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _companyController.clear();
  }

  void _openChatRoom(Contact contact) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatRoomScreen(contact: contact),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kontak'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade50, Colors.white],
          ),
        ),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : _errorMessage.isNotEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, color: Colors.red, size: 50),
                        SizedBox(height: 16),
                        Text(
                          _errorMessage,
                          style: TextStyle(color: Colors.red, fontSize: 16),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _fetchContacts,
                          child: Text('Coba Lagi'),
                        )
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: _contacts.length,
                    itemBuilder: (context, index) {
                      final contact = _contacts[index];
                      return Card(
                        margin: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(16),
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue.shade100,
                            child: Icon(
                              Icons.person,
                              color: Colors.blue.shade800,
                            ),
                          ),
                          title: Text(
                            contact.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 8),
                              Text('Email: ${contact.email}'),
                              SizedBox(height: 4),
                              Text('Phone: ${contact.phone}'),
                              SizedBox(height: 4),
                              Text('Company: ${contact.company}'),
                            ],
                          ),
                          onTap: () => _openChatRoom(contact),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteContact(contact),
                          ),
                        ),
                      );
                    },
                  ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _addContact,
            child: Icon(Icons.add),
            backgroundColor: Colors.green,
            heroTag: 'addContact',
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: _fetchContacts,
            child: Icon(Icons.refresh),
            backgroundColor: Colors.blue,
            heroTag: 'refreshContacts',
          ),
        ],
      ),
    );
  }
}

class ChatRoomScreen extends StatefulWidget {
  final Contact contact;

  const ChatRoomScreen({Key? key, required this.contact}) : super(key: key);

  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _messageController = TextEditingController();

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        _messages.add(ChatMessage(
          text: _messageController.text,
          isMe: true,
          timestamp: DateTime.now(),
        ));
        _messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.contact.name),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[_messages.length - 1 - index];
                return _buildMessageBubble(message);
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Align(
      alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: message.isMe ? Colors.blue[100] : Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.text,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            SizedBox(height: 4),
            Text(
              '${message.timestamp.hour}:${message.timestamp.minute}',
              style: TextStyle(
                color: Colors.black45,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.all(8),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Ketik pesan...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          CircleAvatar(
            backgroundColor: Colors.blue,
            child: IconButton(
              icon: Icon(Icons.send, color: Colors.white),
              onPressed: _sendMessage,
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isMe;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isMe,
    required this.timestamp,
  });
}

Widget _buildActionButton(IconData icon, String label, Color color) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, color: color),
      SizedBox(height: 4),
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

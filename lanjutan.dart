import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple, // Warna latar belakang
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo lingkaran
            Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.green,
                ),
                Positioned(
                  top: 20,
                  left: 30,
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.white,
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 20,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.blue,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Teks logo
            Text(
              "(LOGO)",
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
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

class UserStatus {
  static bool isRegistered = false;
  static String username = '';
  static String password = ''; // Menambahkan variabel untuk menyimpan password
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
                      // Validasi login
                      if (usernameController.text == UserStatus.username &&
                          passwordController.text == UserStatus.password) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      } else {
                        _showErrorDialog(
                            context, 'Username atau password salah.');
                      }
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
                    // Cek jika username, email dan password diisi
                    if (usernameController.text.isNotEmpty &&
                        emailController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty) {
                      // Validasi format email
                      if (_isEmailValid(emailController.text)) {
                        UserStatus.isRegistered = true;
                        UserStatus.username = usernameController.text;
                        UserStatus.password =
                            passwordController.text; // Menyimpan password
                        Navigator.pop(context);
                      } else {
                        _showErrorDialog(context, 'Format email tidak valid.');
                      }
                    } else {
                      // Tampilkan dialog error jika ada field yang kosong
                      _showErrorDialog(context, 'Semua field harus diisi.');
                    }
                  },
                  child: Text('Submit'),
                ),
                ElevatedButton(
                  onPressed: () {
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
                Navigator.pop(context);
              },
              child: Text('Sudah punya akun? Login'),
            ),
          ],
        ),
      ),
    );
  }

  bool _isEmailValid(String email) {
    // Regex untuk memvalidasi format email
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
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

class HomeScreen extends StatelessWidget {
  Widget _buildIconCard(BuildContext context, String title, IconData icon) {
    return SizedBox(
      width: 100,
      height: 120,
      child: InkWell(
        onTap: () {
          switch (title) {
            case 'Calculator':
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CalculatorScreen()),
              );
              break;
            case 'Dzikir':
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DzikirScreen()),
              );
              break;
            case 'Gallery':
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GalleryScreen()),
              );
              break;
            case 'Contact':
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactList()),
              );
              break;
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
                  _buildIconCard(context, 'Calculator', Icons.calculate),
                  SizedBox(width: 15),
                  _buildIconCard(context, 'Dzikir', Icons.mosque),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildIconCard(context, 'Gallery', Icons.photo_library),
                  SizedBox(width: 15),
                  _buildIconCard(context, 'Contact', Icons.contact_page),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";
  String _currentOperation = "";
  double _num1 = 0;
  double _num2 = 0;

  void _buttonPressed(String value) {
    setState(() {
      if (value == "CLR") {
        _output = "0";
        _num1 = 0;
        _num2 = 0;
        _currentOperation = "";
      } else if (value == "+" || value == "-" || value == "*" || value == "/") {
        _num1 = double.parse(_output);
        _currentOperation = value;
        _output = "0";
      } else if (value == "=") {
        _num2 = double.parse(_output);
        if (_currentOperation == "+") _output = (_num1 + _num2).toString();
        if (_currentOperation == "-") _output = (_num1 - _num2).toString();
        if (_currentOperation == "*") _output = (_num1 * _num2).toString();
        if (_currentOperation == "/") _output = (_num1 / _num2).toString();
        _num1 = 0;
        _num2 = 0;
        _currentOperation = "";
      } else {
        _output = _output == "0" ? value : _output + value;
      }
    });
  }

  Widget _buildButton(String value) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(20),
        shape: CircleBorder(),
        backgroundColor: Colors.blue,
      ),
      onPressed: () => _buttonPressed(value),
      child: Text(
        value,
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Kalkulator')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerRight,
            child: Text(
              _output,
              style: TextStyle(fontSize: 48),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: ["7", "8", "9", "/"].map(_buildButton).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: ["4", "5", "6", "*"].map(_buildButton).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: ["1", "2", "3", "-"].map(_buildButton).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: ["0", ".", "CLR", "+"].map(_buildButton).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [_buildButton("=")],
          ),
        ],
      ),
    );
  }
}

class DzikirScreen extends StatefulWidget {
  @override
  _DzikirScreenState createState() => _DzikirScreenState();
}

class _DzikirScreenState extends State<DzikirScreen> {
  int _counter = 0;
  List<String> _dzikirPhrases = [
    'Subhanallah',
    'Alhamdulillah',
    'Allahu Akbar',
  ];
  int _currentPhraseIndex = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
      _currentPhraseIndex = (_currentPhraseIndex + 1) % _dzikirPhrases.length;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
      _currentPhraseIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dzikir')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Dzikir Harian',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              _dzikirPhrases[_currentPhraseIndex],
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 30),
            Text(
              "Sudah berapa kali Dzikir: ",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "$_counter",
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _incrementCounter,
                  child: Text("Tambah"),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _resetCounter,
                  child: Text("Reset"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

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

class ContactList extends StatefulWidget {
  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  List<dynamic> contacts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchContacts();
  }

  Future<void> fetchContacts() async {
    final response =
        await http.get(Uri.parse('https://reqres.in/api/users?page=1'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        contacts = data['data'];
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load contacts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(contact['avatar']),
                  ),
                  title:
                      Text('${contact['first_name']} ${contact['last_name']}'),
                  subtitle: Text(contact['email']), // Menampilkan email
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatPage(contact: contact),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

class ChatPage extends StatefulWidget {
  final Map<String, dynamic> contact;

  ChatPage({required this.contact});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  List<Map<String, String>> messages = [
    {"sender": "me", "text": "Hi, how are you?"},
    {
      "sender": "other",
      "text": "Hi! I'm doing great, thank you! How about you?"
    },
  ];

  void sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      String userMessage = _messageController.text.trim();
      setState(() {
        messages.add({"sender": "me", "text": userMessage});
      });

      // Membersihkan teks setelah dikirim
      _messageController.clear();

      // Memberikan respons otomatis setelah sedikit penundaan
      Future.delayed(Duration(seconds: 1), () {
        String response = generateAutoResponse(userMessage);
        setState(() {
          messages.add({"sender": "other", "text": response});
        });
      });
    }
  }

  String generateAutoResponse(String userMessage) {
    // Logika sederhana untuk membalas berdasarkan isi pesan
    if (userMessage.toLowerCase().contains("hallo")) {
      return "Halo juga! Ada yang bisa saya bantu?";
    } else if (userMessage.toLowerCase().contains("kabar")) {
      return "Saya baik, bagaimana denganmu?";
    } else if (userMessage.toLowerCase().contains("nama")) {
      return "Nama saya Lizaa, senang bertemu denganmu!";
    } else if (userMessage.toLowerCase().contains("terima kasih")) {
      return "ur welcome! 😊";
    } else if (userMessage.toLowerCase().contains("apa")) {
      return "Apa yang ingin kamu tahu?";
    } else if (userMessage.toLowerCase().contains("bantu")) {
      return "Tentu, bagaimana saya bisa membantumu?";
    } else {
      // Balasan default jika tidak ada kata kunci cocok
      return "Maaf, saya belum memahami maksudmu. Bisa dijelaskan lebih lanjut?";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${widget.contact['first_name']}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16.0),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return Align(
                  alignment: message['sender'] == "me"
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.all(12.0),
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    decoration: BoxDecoration(
                      color: message['sender'] == "me"
                          ? Colors.blue[100]
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Text(
                      message['text']!,
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            color: Colors.grey[200],
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.emoji_emotions_outlined),
                  onPressed: () {
                    // Tambahkan logika untuk emoji
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Ketik pesan",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.attach_file),
                  onPressed: () {
                    // Tambahkan logika untuk lampiran
                  },
                ),
                IconButton(
                  icon: Icon(Icons.camera_alt),
                  onPressed: () {
                    // Tambahkan logika untuk kamera
                  },
                ),
                IconButton(
                  icon: Icon(Icons.send,
                      color: const Color.fromARGB(255, 175, 87, 76)),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

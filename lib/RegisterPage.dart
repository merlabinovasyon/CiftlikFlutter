import 'package:flutter/material.dart';
import 'package:merlabciftlikyonetim/services/AuthService.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final AuthService authService = AuthService(); // Instantiate AuthService

  bool _obscure2Text = true;
  bool _loading = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final email = emailController.text;
    final password = passwordController.text;
    final username = usernameController.text;

    try {
      setState(() {
        _loading = true;
      });
      await authService.registerUser(email, password, username);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kayıt başarılı')),
      );
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kayıt başarısız: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double yukseklik = MediaQuery.of(context).size.height;
    final double genislik = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
        backgroundColor: Colors.white,
        elevation: 4,
        shadowColor: Colors.black38,
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 60.0),
            child: Container(
              height: 40,
              width: 130,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('resimler/logo_v2.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(yukseklik / 54),
          padding: EdgeInsets.all(yukseklik / 54),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(yukseklik / 54),
            gradient: const LinearGradient(
              colors: [Colors.white, Colors.white],
            ),
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Image.asset('resimler/login_screen_2.png', height: yukseklik / 4),
                  SizedBox(height: yukseklik / 50),
                  TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      labelText: 'Kullanıcı Adı',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(yukseklik / 50),
                      ),
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Kullanıcı Adı boş olamaz';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: yukseklik / 50),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'E-posta',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(yukseklik / 50),
                      ),
                      prefixIcon: Icon(Icons.email),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'E-posta boş olamaz';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: yukseklik / 50),
                  TextFormField(
                    controller: passwordController,
                    obscureText: _obscure2Text,
                    decoration: InputDecoration(
                      labelText: 'Şifre',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(_obscure2Text ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _obscure2Text = !_obscure2Text;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Şifre boş olamaz';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: yukseklik / 50),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF0277BD),
                    ),
                    onPressed: _loading ? null : _register,
                    child: _loading
                        ? CircularProgressIndicator(
                      color: Colors.blueAccent,
                    )
                        : Text(
                      'Kayıt Ol',
                      style: TextStyle(color: Colors.white, fontSize: genislik / 30),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

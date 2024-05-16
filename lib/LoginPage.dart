import 'package:flutter/material.dart';
import 'package:merlabciftlikyonetim/RegisterPage.dart';
import 'package:merlabciftlikyonetim/services/AuthService.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'degiskenler.dart';
import 'models/BottomNavigation.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool _obscure2Text = true;
  bool _rememberMe = false;
  bool _loading = false;

  String? _selectedCountryCode = '+90';
  final _countryCodes = ['+90', '+1', '+44', '+49', '+61']; // Add more as needed

  @override
  void initState() {
    super.initState();
    _loadSavedLoginInfo();
  }
  _saveLoginInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_rememberMe) {
      prefs.setString('email', _emailController.text);
      prefs.setString('password', _passwordController.text);
      prefs.setBool('rememberMe', true);
    } else {
      prefs.remove('email');
      prefs.remove('password');
      prefs.setBool('rememberMe', false);
    }
  }
  _loadSavedLoginInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _rememberMe = prefs.getBool('rememberMe') ?? false;
      if (_rememberMe) {
        _emailController.text = prefs.getString('email') ?? '';
        _passwordController.text = prefs.getString('password') ?? '';
        _phoneController.text = prefs.getString('phone') ?? '';
        _selectedCountryCode = prefs.getString('countryCode') ?? '+90';
      } else {
        _emailController.clear();
        _passwordController.clear();
      }
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    genislik = MediaQuery.of(context).size.width;
    yukseklik= MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 4,
          shadowColor: Colors.black38,
          title: Center(
            child: Container(
              height: 40,
              width: 130,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('resimler/logo_v2.png'),
                    fit: BoxFit.fill
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
                    Image.asset('resimler/login_screen_2.png', height: yukseklik/4),
                    SizedBox(height: yukseklik / 50),
                    TextFormField(
                      controller: _emailController,
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
                    Row(
                      children: [
                        Flexible(
                          flex: 2,
                          child: DropdownButtonFormField<String>(
                            value: _selectedCountryCode,
                            items: _countryCodes
                                .map((code) => DropdownMenuItem(
                              value: code,
                              child: Text(code),
                            ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedCountryCode = value;
                              });
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(yukseklik / 50),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: yukseklik / 50),
                        Flexible(
                          flex: 5,
                          child: TextFormField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              labelText: 'Telefon',
                              border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(yukseklik / 50),
                              ),
                              prefixIcon: Icon(Icons.phone_android),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Telefon boş olamaz';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: yukseklik / 50),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscure2Text,
                      decoration: InputDecoration(
                        labelText: 'Şifre',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(_obscure2Text
                              ? Icons.visibility
                              : Icons.visibility_off),
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
                    SizedBox(height: yukseklik / 100),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Checkbox(
                          activeColor: Colors.black,
                          value: _rememberMe,
                          onChanged: (bool? value) {
                            setState(() {
                              _rememberMe = value!;
                            });
                          },
                        ),
                        Text(
                          'Beni Hatırla',
                          style: TextStyle(fontSize: genislik / 27),
                        ),
                        SizedBox(width: 50,),
                      ],
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF0277BD),
                      ),
                      onPressed: _loading ? null : _signIn,
                      child: _loading
                          ? CircularProgressIndicator(
                        color: Colors.blueAccent,
                      )
                          : Text(
                        'Giriş Yap',
                        style: TextStyle(
                            color: Colors.white, fontSize: genislik / 30),
                      ),
                    ),
                    SizedBox(height: yukseklik / 40),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: yukseklik / 1000,
                            width: genislik / 5,
                            color: Colors.black,
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => RegisterPage()),
                              );
                            },
                            child: Text(
                              "Kayıt ol",
                              style: TextStyle(
                                  color: Colors.black, fontSize: genislik / 20),
                            ),
                          ),
                          Container(
                            height: yukseklik / 1000,
                            width: genislik / 5,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    Center(
                      child: Text(
                        'Şifremi unuttum',
                        style: TextStyle(fontSize: genislik / 27,color: Colors.black45),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),

      ),
    );
  }

  Future<bool> _onBackPressed() async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Merlab uygulamasından çıkmak istiyor musunuz?',style: TextStyle(fontSize: 16),),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Hayır',style: TextStyle(color: Colors.black),),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Evet',style: TextStyle(color: Colors.black),),
          ),
        ],
      ),
    ) ?? false;
  }
  void _signIn() async {
    _saveLoginInfo();
    if (_formKey.currentState!.validate()) {
      setState(() {
        _loading = true;
      });
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

      try {
        await AuthService().signIn(email, password);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BottomNavigation()),
        );
      } catch (e) {
        print('Hata: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Kullanıcı adı veya şifre hatalı'),
            backgroundColor: Colors.red,
          ),
        );
      }
      setState(() {
        _loading = false;
      });
    }
  }
}

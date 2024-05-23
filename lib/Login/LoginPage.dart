import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth_controller.dart';
import 'login_controller.dart';

class LoginPage extends StatelessWidget {
  // FormState'in yeniden oluşturulmasını önlemek için global anahtarı burada tanımlayın
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    final LoginController loginController = Get.find<LoginController>();

    return Scaffold(
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
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(MediaQuery.of(context).size.height / 54),
          padding: EdgeInsets.all(MediaQuery.of(context).size.height / 54),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height / 54),
            gradient: LinearGradient(
              colors: [Colors.white, Colors.white],
            ),
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey, // Form anahtarını burada kullanın
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Image.asset('resimler/login_screen_2.png', height: MediaQuery.of(context).size.height / 4),
                  SizedBox(height: MediaQuery.of(context).size.height / 50),
                  TextFormField(
                    controller: loginController.emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'E-posta',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height / 50),
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
                  SizedBox(height: MediaQuery.of(context).size.height / 50),
                  Row(
                    children: [
                      Flexible(
                        flex: 2,
                        child: Obx(() => DropdownButtonFormField<String>(
                          value: loginController.selectedCountryCode.value,
                          items: loginController.countryCodes
                              .map((code) => DropdownMenuItem(
                            value: code,
                            child: Text(code),
                          ))
                              .toList(),
                          onChanged: (value) {
                            loginController.selectedCountryCode.value = value!;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height / 50),
                            ),
                          ),
                        )),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.height / 50),
                      Flexible(
                        flex: 5,
                        child: TextFormField(
                          controller: loginController.phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: 'Telefon',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height / 50),
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
                  SizedBox(height: MediaQuery.of(context).size.height / 50),
                  Obx(() => TextFormField(
                    controller: loginController.passwordController,
                    obscureText: loginController.obscure2Text.value,
                    decoration: InputDecoration(
                      labelText: 'Şifre',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(loginController.obscure2Text.value
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          loginController.obscure2Text.value = !loginController.obscure2Text.value;
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Şifre boş olamaz';
                      }
                      return null;
                    },
                  )),
                  SizedBox(height: MediaQuery.of(context).size.height / 100),
                  Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Checkbox(
                        activeColor: Colors.black,
                        value: loginController.rememberMe.value,
                        onChanged: (bool? value) {
                          loginController.rememberMe.value = value!;
                        },
                      ),
                      Text(
                        'Beni Hatırla',
                        style: TextStyle(fontSize: MediaQuery.of(context).size.width / 27),
                      ),
                      SizedBox(width: 50),
                    ],
                  )),
                  Obx(() => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF0277BD),
                    ),
                    onPressed: authController.isLoading.value
                        ? null
                        : () {
                      if (_formKey.currentState!.validate()) {
                        authController.signIn(
                          loginController.emailController.text.trim(),
                          loginController.passwordController.text.trim(),
                        );
                      }
                    },
                    child: authController.isLoading.value
                        ? CircularProgressIndicator(
                      color: Colors.blueAccent,
                    )
                        : Text(
                      'Giriş Yap',
                      style: TextStyle(
                          color: Colors.white, fontSize: MediaQuery.of(context).size.width / 30),
                    ),
                  )),
                  SizedBox(height: MediaQuery.of(context).size.height / 40),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height / 1000,
                          width: MediaQuery.of(context).size.width / 5,
                          color: Colors.black,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed('/register');
                          },
                          child: Text(
                            "Kayıt ol",
                            style: TextStyle(
                                color: Colors.black, fontSize: MediaQuery.of(context).size.width / 20),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height / 1000,
                          width: MediaQuery.of(context).size.width / 5,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      'Şifremi unuttum',
                      style: TextStyle(fontSize: MediaQuery.of(context).size.width / 27, color: Colors.black45),
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'RegisterController.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final RegisterController controller = Get.put(RegisterController());
    final double yukseklik = MediaQuery.of(context).size.height;
    final double genislik = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
        elevation: 4,
        shadowColor: Colors.black38,
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 60.0),
            child: Container(
              height: 40,
              width: 130,
              decoration: const BoxDecoration(
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
              key: controller.formKey, // formKey kullanımı
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Image.asset('resimler/login_screen_2.png', height: yukseklik / 4),
                  SizedBox(height: yukseklik / 50),
                  TextFormField(
                    controller: controller.usernameController,
                    decoration: InputDecoration(
                      labelText: 'Kullanıcı Adı',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(yukseklik / 50),
                      ),
                      prefixIcon: const Icon(Icons.person),
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
                    controller: controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'E-posta',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(yukseklik / 50),
                      ),
                      prefixIcon: const Icon(Icons.email),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'E-posta boş olamaz';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: yukseklik / 50),
                  Obx(() => TextFormField(
                    controller: controller.passwordController,
                    obscureText: controller.obscureText.value,
                    decoration: InputDecoration(
                      labelText: 'Şifre',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(controller.obscureText.value ? Icons.visibility : Icons.visibility_off),
                        onPressed: controller.toggleObscureText,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Şifre boş olamaz';
                      }
                      return null;
                    },
                  )),
                  SizedBox(height: yukseklik / 50),
                  Obx(() => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0277BD),
                    ),
                    onPressed: controller.isLoading.value ? null : controller.register,
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(
                      color: Colors.blueAccent,
                    )
                        : Text(
                      'Kayıt Ol',
                      style: TextStyle(color: Colors.white, fontSize: genislik / 30),
                    ),
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

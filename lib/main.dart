import 'package:flutter/material.dart';
import 'package:form/second_page.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    initialRoute: '/login',
    getPages: [
      GetPage(
        name: '/login',
        page: () => LoginPage(),
        binding: LoginBinding(),
      ),
    ],
  ));
}

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}

class LoginController extends GetxController {
  final loginFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // @override
  // void onInit() {
  //   emailController.text = 'ibrahim@gmail.com';
  //   super.onInit();
  // }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  validator(String value) {
    if (value.isEmpty) {
      return 'Please this field must be filled';
    }
  }

  void login() {
    if (loginFormKey.currentState!.validate()) {
      checkUser(emailController.text, passwordController.text).then((auth) {
        if (auth) {
          Get.snackbar('Login', 'Login successfully',
              backgroundColor: Colors.green, colorText: Colors.white);
          Get.to(SecondPage());
        } else {
          Get.snackbar('Login', 'Invalid email or password',
              backgroundColor: Colors.red, colorText: Colors.white);
        }
        passwordController.clear();
      });
    }
  }

  Future<bool> checkUser(String user, String password) {
    if (user == 'ibrahim@gmail.com' && password == '123') {
      return Future.value(true);
    }
    return Future.value(false);
  }
}

class LoginPage extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('LOGIN')),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.loginFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: controller.emailController,
                decoration: const InputDecoration(labelText: 'E-mail'),
                //validator: controller.validator,
              ),
              TextFormField(
                controller: controller.passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                //validator: controller.validator,
                obscureText: true,
              ),
              ElevatedButton(
                child: Text('Login'),
                onPressed: controller.login,
              )
            ],
          ),
        ),
      ),
    );
  }
}

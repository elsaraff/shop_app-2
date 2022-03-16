import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_api_provider/core/functions.dart';
import 'package:shop_app_api_provider/screens/login/login_provider.dart';
import 'package:shop_app_api_provider/screens/register/register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: ChangeNotifierProvider(
        create: (BuildContext context) => LoginProvider(),
        child: Consumer<LoginProvider>(
          builder: (context, loginProvider, child) {
            return Padding(
              padding: const EdgeInsets.all(40.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Login',
                            style: TextStyle(
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.red)),
                        const SizedBox(height: 20.0),
                        const Text('Login now to browse our hot offers.',
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.grey)),
                        const SizedBox(height: 60.0),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Email is Empty";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Email Address',
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: Colors.red,
                              )),
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: loginProvider.isPassword,
                          onFieldSubmitted: (value) {
                            if (formKey.currentState!.validate()) {
                              loginProvider.userLogin(
                                  context: context,
                                  email: emailController.text,
                                  password: passwordController.text);
                              passwordController.clear();
                            }
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "password is Empty";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: 'Password',
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Colors.red,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                loginProvider.suffix,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                loginProvider.changePasswordVisibility();
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10)),
                          width: double.infinity,
                          child: MaterialButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                loginProvider.userLogin(
                                    context: context,
                                    email: emailController.text,
                                    password: passwordController.text);
                                passwordController.clear();
                              }
                            },
                            child: const Text(
                              'LOGIN',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have account ?',
                              style: TextStyle(fontSize: 20),
                            ),
                            TextButton(
                                onPressed: () {
                                  navigateTo(context, const RegisterScreen());
                                },
                                child: const Text(
                                  'Register',
                                  style: TextStyle(
                                      fontSize: 20,
                                      decoration: TextDecoration.underline),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

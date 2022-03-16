import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_api_provider/screens/register/register_provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (BuildContext context) => RegisterProvider(),
        child: Consumer<RegisterProvider>(
          builder: (context, registerProvider, child) {
            return SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: registerProvider.formKey,
                      child: Column(
                        children: [
                          const Text('Register',
                              style: TextStyle(
                                  fontSize: 40.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red)),
                          const SizedBox(height: 20.0),
                          const Text('Register now Don\'t waste your Time.',
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.grey)),
                          const SizedBox(height: 40.0),
                          TextFormField(
                            controller: registerProvider.nameController,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "password is Empty";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Name',
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.red,
                                )),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: registerProvider.emailController,
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
                          const SizedBox(height: 10),
                          TextFormField(
                              controller: registerProvider.phoneController,
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Phone is Empty";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Phone Number',
                                  prefixIcon: Icon(
                                    Icons.phone,
                                    color: Colors.red,
                                  ))),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: registerProvider.passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: registerProvider.isPassword,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password is  empty';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText: 'Password',
                              prefixIcon:
                                  const Icon(Icons.lock, color: Colors.red),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  registerProvider.suffix,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  registerProvider.changePasswordVisibility();
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.red),
                            child: MaterialButton(
                              child: const Text(
                                'Register',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                if (registerProvider.formKey.currentState!
                                    .validate()) {
                                  registerProvider.userRegister(
                                      context: context,
                                      name:
                                          registerProvider.nameController.text,
                                      email:
                                          registerProvider.emailController.text,
                                      phone:
                                          registerProvider.phoneController.text,
                                      password: registerProvider
                                          .passwordController.text);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
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

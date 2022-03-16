import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_api_provider/core/functions.dart';
import 'package:shop_app_api_provider/screens/shop_layout/shop_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();

    return Consumer<ShopProvider>(
      builder: (context, shopProvider, child) {
        if (shopProvider.userModel != null) {
          shopProvider.nameController.text =
              shopProvider.userModel!.data!.name!;
          shopProvider.emailController.text =
              shopProvider.userModel!.data!.email!;
          shopProvider.phoneController.text =
              shopProvider.userModel!.data!.phone!;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: shopProvider.nameController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Name is Empty";
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
                          controller: shopProvider.emailController,
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
                              prefixIcon: Icon(Icons.email_outlined,
                                  color: Colors.red))),
                      const SizedBox(height: 10),
                      TextFormField(
                          controller: shopProvider.phoneController,
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
                              prefixIcon:
                                  Icon(Icons.phone, color: Colors.red))),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.red),
                        child: MaterialButton(
                          child: const Text(
                            'Logout',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            signOut(context);
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.red),
                        child: MaterialButton(
                          child: const Text(
                            'Update',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              shopProvider.updateUserData(
                                  name: shopProvider.nameController.text,
                                  email: shopProvider.emailController.text,
                                  phone: shopProvider.phoneController.text);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

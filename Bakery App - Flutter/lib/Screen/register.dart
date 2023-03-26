import 'package:bakey/Screen/login.dart';
import 'package:flutter/material.dart';

import 'package:motion_toast/motion_toast.dart';

import '../model/user.dart';
import '../repository/user_repo.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  static const String route = "register";

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _key = GlobalKey<FormState>();
  final _fnameController = TextEditingController(text: "Ishwor");
  final _lnameController = TextEditingController(text: "Khadka");
  final _phoneNoController = TextEditingController(text: "5251405");
  final _emailController = TextEditingController(text: "khadka@gmail.com");
  final _passwordController = TextEditingController(text: "password");

  _saveUser() async {
    User user = User(
      firstName: _fnameController.text,
      lastName: _lnameController.text,
      phoneNumber: _phoneNoController.text,
      email: _emailController.text,
      password: _passwordController.text,
    );

    int status = await UserRepositoryImpl().addUser(user);
    _showMessage(status);
  }

  _showMessage(int status) {
    if (status > 0) {
      // MotionToast.success(
      //   description: const Text("Registration successfully"),
      // ).show(context);
      Navigator.pushNamed(context, LoginScreen.route);
    } else {
      MotionToast.error(
        description: const Text("Registration Failed"),
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: const Color.fromARGB(255, 249, 130, 33),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Form(
              key: _key,
              child: Column(
                children: [
                  TextFormField(
                    key: const Key('txtFname'),
                    controller: _fnameController,
                    decoration: InputDecoration(
                        labelText: 'First Name',
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.circular(5),
                        )),
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter first name';
                      }
                      return null;
                    }),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    key: const Key('txtLname'),
                    controller: _lnameController,
                    decoration: InputDecoration(
                        labelText: 'Last Name',
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.circular(5),
                        )),
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter last name';
                      }
                      return null;
                    }),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    key: const Key('txtPhone'),
                    controller: _phoneNoController,
                    decoration: InputDecoration(
                        labelText: 'Phone Numer',
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.circular(5),
                        )),
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter phone number';
                      }
                      return null;
                    }),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    key: const Key('txtEmail'),
                    controller: _emailController,
                    decoration: InputDecoration(
                        labelText: 'Email',
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.circular(5),
                        )),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    key: const Key('txtPassword'),
                    controller: _passwordController,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter Password',
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.circular(5),
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Password';
                      }
                      if (value.length < 6) {
                        return 'Password length must be at least 6 characters';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    key: const Key('btnRegister'),
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          _saveUser();
                        }
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: "Brand Bold",
                        ),
                      ),
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

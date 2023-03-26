import 'package:flutter/material.dart';

class Forgetpwd extends StatefulWidget {
  const Forgetpwd({super.key});

  @override
  State<Forgetpwd> createState() => _ForgetpwdState();
}

class _ForgetpwdState extends State<Forgetpwd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            // cursorColor: kPrimaryColor,
            onSaved: (email) {},
            // ignore: prefer_const_constructors
            decoration: InputDecoration(
              hintText: "Your email",
              // ignore: prefer_const_constructors
              prefixIcon: Padding(
                padding: const EdgeInsets.all(8),
                child: const Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: true,
              // cursorColor: kPrimaryColor,
              // ignore: prefer_const_constructors
              decoration: InputDecoration(
                hintText: "Your password",
                // ignore: prefer_const_constructors
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8),
                  child: const Icon(Icons.lock),
                ),
              ),
            ),
          ),
          const SizedBox(height: 19),
          Hero(
            tag: "login_btn",
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                "Login".toUpperCase(),
              ),
            ),
          ),
          const SizedBox(height: 19),
        ],
      ),
    ));
  }
}

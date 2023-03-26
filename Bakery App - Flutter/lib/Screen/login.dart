import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bakey/Screen/dashboad.dart';
import 'package:bakey/Screen/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repository/user_repo.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String route = "loginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController(text: "khadka@gmail.com");
  final _passwordController = TextEditingController(text: "password");
  // final _emailController = TextEditingController();
  // final _passwordController = TextEditingController();

  //FingerPrint Setup
  final LocalAuthentication auth = LocalAuthentication();
  bool? _CheckBiometric;

  List<BiometricType>? _availableBiometrics;
  String authorized = "Yes";

  Future<void> _checkBiometric() async {
    bool? CheckBiometric;
    try {
      CheckBiometric = await auth.canCheckBiometrics;
      bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
      bool canAuthenticate =
          canAuthenticateWithBiometrics || await auth.isDeviceSupported();
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _CheckBiometric = CheckBiometric;
    });
  }

  Future<void> _getBiometrics() async {
    List<BiometricType>? availableBiometric;

    // final List<BiometricType> availableBiometrics =
    //     await auth.getAvailableBiometrics();
    try {
      availableBiometric = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }
    setState(() {
      _availableBiometrics = availableBiometric;
    });
  }

  Future<void> _fingerprint() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: "Use your fingerprint",
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: false,
        ),
      );
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;
    setState(() async {
      authorized = authenticated ? "Successful" : "Failed";

      if (authenticated) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        String? val = pref.getString("token");

        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, DashboardScreen.route);
      }
    });
  }

  @override
  void initState() {
    _checkBiometric();
    _getBiometrics();

    super.initState();
  }

  _login() async {
    final islogin = await UserRepositoryImpl()
        .loginUser(_emailController.text, _passwordController.text);
    if (islogin) {
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 1,
          channelKey: 'basic_channel',
          title: "Log Out",
          body: "You are logged in to your account!",
        ),
      );
      _goToAnotherPage();
    } else {
      _showMessage();
    }
  }

  _goToAnotherPage() {
    Navigator.pushReplacementNamed(context, DashboardScreen.route);
  }

  _showMessage() {
    MotionToast.error(description: const Text("Login failed"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: const Color.fromARGB(255, 249, 130, 33),
        centerTitle: true,
      ),
      // backgroundColor: Color(0xffD3D3D),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  // ignore: prefer_const_constructors
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/images/bakery.jpg"))),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //     child: Image.asset("assets/images/bakery.jpeg")),
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(25.0),
                          child: Text(
                            "Welcome",
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                        ),
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Email';
                          }
                          return null;
                        },
                      ),
                      // ignore: prefer_const_constructors
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        key: const Key('txtPassword'),
                        controller: _passwordController,
                        obscureText: true,
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
                      // ignore: prefer_const_constructors
                      SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: SizedBox(
                          key: const ValueKey('btnLogin'),
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2)),
                              ),
                            ),
                            onPressed: () {
                              _login();
                            },
                            // ignore: prefer_const_constructors
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                              child: const Text('Login'),
                            ),
                          ),
                        ),
                      ),
                      // ignore: prefer_const_constructors
                      SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: TextButton(
                          onPressed: _fingerprint,
                          child: const Text(
                            "Fingerprint Log In",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Dont have Account?'),
                          InkWell(
                              onTap: () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Register()),
                                    )
                                  },
                              // ignore: prefer_const_constructors
                              child: Text(
                                ' Register here',
                                style: const TextStyle(
                                  color: Colors.blue,
                                ),
                              ))
                        ],
                      ),
                      // ignore: prefer_const_constructors
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

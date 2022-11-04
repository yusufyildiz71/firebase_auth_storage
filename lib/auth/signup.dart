import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:task_freelance/auth/login.dart';

import '../components/orDivider.dart';
import '../main.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isVisible = false;
  String? _name;
  String? _surname;
  String? _eMail;
  String? _password;
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 300.0, child: Lottie.asset('assets/hello.json')),
            const SizedBox(
              height: 28.0,
            ),

            const SizedBox(
              height: 8.0,
            ),

            //E-Mail
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: Colors.white.withOpacity(0.6),
                ),
                child: TextFormField(
                  cursorColor: Color(0xFF00897B),
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      print('Email boş olamaz.');
                      return 'Email boş olamaz.';
                    } else if (!isValidEmail(value)) {
                      print('Email formatı hatalı');
                      return 'Email formatı hatalı';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),

            //Password
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              child: TextFormField(
                cursorColor: Color(0xFF00897B),
                controller: passwordController,
                validator: (value) {
                  if (value!.isEmpty) {
                    print('Şifre alanı boş olamaz.');
                    return '';
                  } else if (value.length < 6) {
                    print('Şifreniz minimum 6 haneli olmalıdır.');
                    return '';
                  }
                  return null;
                },
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    label: const Padding(
                      padding: EdgeInsets.only(left: 22),
                      child: Text("Password"),
                    ),
                    suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        child: Icon(
                          isVisible ? Icons.visibility : Icons.visibility_off,
                          color: Color(0xFF00897B),
                        ))),
                obscureText: !isVisible,
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    onPrimary: Color(0xFF00897B),
                    primary: Color(0xFF00897B),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)),
                    minimumSize: const Size(double.infinity, 50)),
                onPressed: () async {
                  signUp();
                  // createUser(nameController.text, emailController.text,
                  //     surnameController.text, passwordController.text);
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => Login()));
                },
                child: Text("Sign Up",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    )),
              ),
            ),
            const OrDivider(),

            Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                // _buildForgotPassword(context),
                const SizedBox(height: 16),
                buildHaveAccount(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future signUp() async {
    showDialog(
        context: context,
        builder: ((context) => Center(
              child: CircularProgressIndicator(),
            )));
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  bool isValidEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  RichText buildHaveAccount(BuildContext context) {
    return RichText(
        text: TextSpan(
            style: const TextStyle(color: Colors.black54),
            text: "Have an Account? ",
            children: [
          TextSpan(
              // hesabın olmaması burda
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
              text: 'Sign In',
              style: const TextStyle(
                decoration: TextDecoration.underline,
                color: Color(0xFF00897B),
              )),
        ]));
  }
}

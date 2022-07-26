import 'package:flutter/material.dart';
import 'package:testapp/components/custom_bottom_tab.dart';
import 'package:testapp/components/password_field.dart';
import 'package:testapp/constans.dart';
import 'package:testapp/network/firebase.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  static String routeName = '/signUp';

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordConfirm = TextEditingController();

  bool showPassword = false;
  bool showPasswordConfirm = false;

  _createUser() async {
    if (userName.text != '' && password.text != '') {
      await FirebaseRequest.signUp(
          emailAddress: userName.text, password: password.text);
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => const MyStatefulWidget(
                  initRoute: 3,
                )),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Container(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: kDefaultPadding / 4),
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email or phone number',
                ),
                controller: userName,
              ),
            ),
            PasswordField(
              showPassword: showPassword,
              controller: password,
              title: 'Password',
              onPressed: () {
                setState(() {
                  showPassword = !showPassword;
                });
              },
            ),
            PasswordField(
              showPassword: showPasswordConfirm,
              controller: passwordConfirm,
              title: 'Password Confirm',
              onPressed: () {
                setState(() {
                  showPasswordConfirm = !showPasswordConfirm;
                });
              },
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(
                      60), // fromHeight use double.infinity as width and 40 is the height
                ),
                onPressed: () {
                  _createUser();
                },
                child: const Text('Sign Up',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
              child: const Text('Need help?'),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                child: Text(
                  'Already have an account? Sign In now.',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      elevation: 0.3,
      title: const Text(
        "Sign Up",
        style: headerText,
      ),
    );
  }
}

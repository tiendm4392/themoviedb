import 'package:flutter/material.dart';
import 'package:testapp/components/custom_bottom_tab.dart';
import 'package:testapp/components/password_field.dart';
import 'package:testapp/constans.dart';
import 'package:testapp/network/firebase.dart';
import 'package:testapp/screens/authentication/signUp/sign_up_screen.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);
  static String routeName = '/signIn';

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  bool showPassword = false;

  _signInUser() async {
    if (userName.text != '' && password.text != '') {
      await FirebaseRequest.signIn(
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
                controller: userName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email or phone number',
                ),
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
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(
                      60), // fromHeight use double.infinity as width and 40 is the height
                ),
                onPressed: () {
                  _signInUser();
                },
                child: const Text('Sign In',
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
                Navigator.pushNamed(context, SignUp.routeName);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                child: const Text(
                  'New to MovieZ? Sign up now.',
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
        "MovieZ",
        style: headerText,
      ),
    );
  }
}



import 'package:flutter/material.dart';
import 'package:testapp/constans.dart';
import 'package:testapp/screens/authentication/signUp/sign_up_screen.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);
  static String routeName = '/signIn';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Container(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 4),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email or phone number',
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 4),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(
                      60), // fromHeight use double.infinity as width and 40 is the height
                ),
                onPressed: () {},
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

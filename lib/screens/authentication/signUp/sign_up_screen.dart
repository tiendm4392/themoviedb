import 'package:flutter/material.dart';
import 'package:testapp/constans.dart';
import 'package:testapp/network/firebase.dart';
import 'package:testapp/screens/profile/profile_screen.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  static String routeName = '/signUp';

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    Future<void> createUser() async {
      if (nameController.text != '' && passwordController.text != '') {
        await FirebaseRequest.signUp(
            emailAddress: nameController.text,
            password: passwordController.text);
        if (!mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
      }
    }

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
            const Padding(
              padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 4),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Confirm Password',
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
                onPressed: () {
                  createUser();
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

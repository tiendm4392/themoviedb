import 'package:flutter/material.dart';
import 'package:testapp/constans.dart';
import 'package:testapp/network/firebase.dart';
import 'package:testapp/screens/authentication/signIn/sign_in.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
    FirebaseRequest.userStatus();
  }

  @override
  Widget build(BuildContext context) {
    return
        // GestureDetector(
        //     onTap: () {
        //       Navigator.of(context).push(_createRoute());
        //     },
        //     child: const Center(child: Text("profile")));
        Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      color: kLightGreenColor),
                  child: const Icon(
                    Icons.account_circle,
                    size: 80,
                    color: kGrayColor,
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: (() {
                    Navigator.of(context).push(_createRoute());
                  }),
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                        color: kLightGreenColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(
                  Icons.edit,
                  color: kLightGreenColor,
                ),
              ],
            ),
          ),
          ProfileItem(
            icon: Icons.star,
            title: 'Rate this app',
            onPressed: (() {
              print('object');
            }),
          ),
          ProfileItem(
            icon: Icons.mail,
            title: 'Contacts us',
            onPressed: (() {
              print('object');
            }),
          ),
          ProfileItem(
            icon: Icons.privacy_tip,
            title: 'Privacy policy',
            onPressed: (() {
              print('object');
            }),
          ),
          ProfileItem(
            icon: Icons.settings,
            title: 'App setting',
            onPressed: (() {
              print('object');
            }),
          ),
          GestureDetector(
            onTap: (() {
              print('logout');
            }),
            child: Padding(
              padding: EdgeInsets.only(top: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Text(
                    'Sign Out',
                    style: sectionText,
                  ),
                  SizedBox(width: 10),
                  Icon(
                    Icons.logout,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ProfileItem extends StatelessWidget {
  const ProfileItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 4),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(60),
              primary: kLightGreenColor),
          onPressed: onPressed,
          child: Row(
            children: [
              Icon(icon),
              Padding(
                padding: const EdgeInsets.only(left: kDefaultPadding / 2),
                child: Text(title),
              ),
              const Spacer(),
              const Icon(Icons.navigate_next)
            ],
          )),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const SignIn(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

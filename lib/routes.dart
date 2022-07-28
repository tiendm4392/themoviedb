import 'package:flutter/material.dart';
import 'package:testapp/components/custom_bottom_tab.dart';
import 'package:testapp/screens/authentication/signIn/sign_in.dart';
import 'package:testapp/screens/authentication/signUp/sign_up_screen.dart';
import 'package:testapp/screens/discover/discover_screen.dart';
import 'package:testapp/screens/home/home_screen.dart';
import 'package:testapp/screens/profile/profile_screen.dart';

final Map<String, WidgetBuilder> routes = {
  MyStatefulWidget.routeName: (context) => const MyStatefulWidget(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  DiscoverScreen.routeName: (context) => const DiscoverScreen(),
  SignIn.routeName: (context) => const SignIn(),
  SignUp.routeName: (context) => const SignUp(),
  ProfileScreen.routeName: (context) => const ProfileScreen(),
};

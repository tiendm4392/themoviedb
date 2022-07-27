import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testapp/constans.dart';
import 'package:testapp/model/home_management.dart';
import 'package:testapp/model/movie_management.dart';
import 'package:testapp/network/firebase.dart';
import 'package:testapp/routes.dart';
import 'components/custom_bottom_tab.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MoviesManagement>(
            create: (context) => MoviesManagement()),
        ChangeNotifierProvider<HomeManagement>(
            create: (context) => HomeManagement()),
        StreamProvider<User?>.value(value: FirebaseRequest().user, initialData: null)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FlutterApp',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primaryColor: kPrimaryColor,
          textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.black),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
          ),
        ),
        initialRoute: MyStatefulWidget.routeName,
        routes: routes,
      ),
    );
  }
}

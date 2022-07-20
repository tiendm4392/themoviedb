import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testapp/constans.dart';
import 'package:testapp/model/movie_management.dart';
import 'components/custom_bottom_tab.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MoviesManagement>(create: (context) => MoviesManagement()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FlutterApp',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primaryColor: kPrimaryColor,
          textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.black),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // home: const MyStatefulWidget(),
        initialRoute: '/',
        routes: {'/': (context) => const MyStatefulWidget()},
      ),
    );
  }
}

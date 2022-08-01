import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testapp/components/movie_item.dart';
import 'package:testapp/constans.dart';
import 'package:testapp/model/list_movie_management.dart';
import 'package:testapp/screens/authentication/signIn/sign_in.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _firestore = FirebaseFirestore.instance.collection("movie_bookmark");
  late ListMovieManagement bookmarkData;

  @override
  void initState() {
    super.initState();
    bookmarkData = Provider.of<ListMovieManagement>(context, listen: false);
    var user = Provider.of<User?>(context, listen: false);
    if (user != null) {
      getBookmark(user.uid);
    }
  }

  getBookmark(String? id) async {
    var docSnapshot = await _firestore.doc(id).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      final value = data?['ids'].cast<int>();
      await bookmarkData.fetchBookmark(ids: value);
    }
  }

  @override
  Widget build(BuildContext context) {
    var result = Provider.of<ListMovieManagement>(context);
    var movieData = result.getFavorite;
    var user = Provider.of<User?>(context);

    return Visibility(
      visible: user != null,
      replacement: Center(
          child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Please ', style: sectionText),
          GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, SignIn.routeName);
              },
              child: const Text(
                'Sign In',
                style: TextStyle(
                    color: kLightGreenColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              )),
          const Text(' to use this feature', style: sectionText)
        ],
      )),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: movieData.isEmpty
            ? const Center(
                child: Text(
                'List is empty',
                style: sectionText,
              ))
            : ListView.builder(
                itemCount: movieData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        bottom: index + 1 == movieData.length
                            ? kDefaultPadding
                            : 0),
                    child: MovieItem(
                      movie: movieData[index],
                      onPress: () {
                        getBookmark(user?.uid);
                        movieData.removeWhere(
                            (item) => item.id == movieData[index].id);
                      },
                    ),
                  );
                }),
      ),
    );
  }
}

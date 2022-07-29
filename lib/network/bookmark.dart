import 'package:cloud_firestore/cloud_firestore.dart';

class Bookmark {
  final _firestore = FirebaseFirestore.instance.collection("movie_bookmark");

  Future<void> addBookmark(String id, int movieId) async {
    var docSnapshot = await _firestore.doc(id).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      var value = data?['ids'].cast<int>();
      _firestore
          .doc(id)
          .set({
            'ids': [...value, movieId],
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    } else {
      _firestore
          .doc(id)
          .set({
            'ids': [movieId],
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }
  }
}

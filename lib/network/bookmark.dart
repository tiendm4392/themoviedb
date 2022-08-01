import 'package:cloud_firestore/cloud_firestore.dart';

class Bookmark {
  final _firestore = FirebaseFirestore.instance.collection("movie_bookmark");

  Future<void> addBookmark(String id, int movieId) async {
    var docSnapshot = await _firestore.doc(id).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      final values = data?['ids'].cast<int>();
      final check = values.remove(movieId);
      _firestore
          .doc(id)
          .set({
            'ids': check ? values : [...values, movieId],
          })
          .then((value) => print(check ? "remove movie" : "add movie"))
          .catchError((error) => print("Failed to add: $error"));
    } else {
      _firestore
          .doc(id)
          .set({
            'ids': [movieId],
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add : $error"));
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testapp/model/bookmark.dart';

class Bookmark {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<BookmarkList> getListBookmark() async {
    var snap = await _firestore
        .collection("movie_bookmark")
        .doc("DZgYFnUcgfaa7wTdj4Rrj4bdZoJ2")
        .get();
    return BookmarkList.fromMap(snap.data()!);
  }
}

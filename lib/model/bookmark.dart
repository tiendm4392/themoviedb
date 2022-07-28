class BookmarkList {
  List<int> ids;

  BookmarkList({required this.ids});

  factory BookmarkList.fromMap(Map data) {
    return BookmarkList(
      ids: data['ids'] ?? []
    );
  }
}

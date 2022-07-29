class BookmarkList {
  final List<int> ids;

  BookmarkList({required this.ids});

  factory BookmarkList.fromJson(Map data) {
    return BookmarkList(ids: data['ids']);
  }
}

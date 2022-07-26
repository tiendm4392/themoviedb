import 'dart:convert';

UserDetails userDetailsFromJson(String str) =>
    UserDetails.fromJson(json.decode(str));

String userDetailsToJson(UserDetails data) => json.encode(data.toJson());

class UserDetails {
  UserDetails({
    required this.displayName,
    required this.email,
    required this.emailVerified,
    required this.isAnonymous,
    required this.uid,
    required this.photoUrl,
  });

  String displayName;
  String email;
  bool emailVerified;
  bool isAnonymous;
  String uid;
  String photoUrl;

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        displayName: json["displayName"] ?? '',
        email: json["email"] ?? '',
        emailVerified: json["emailVerified"],
        isAnonymous: json["isAnonymous"],
        uid: json["uid"],
        photoUrl: json["photoURL"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "displayName": displayName,
        "email": email,
        "emailVerified": emailVerified,
        "isAnonymous": isAnonymous,
        "uid": uid,
        "photoURL": photoUrl,
      };
}

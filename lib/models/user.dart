// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.name,
    required this.email,
    required this.isOnline,
    required this.uid,
  });

  String name;
  String email;
  bool isOnline;
  String uid;

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        isOnline: json["isOnline"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "isOnline": isOnline,
        "uid": uid,
      };
}

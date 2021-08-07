// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User extends Equatable{

  const User({
    this.sub,
    this.emailVerified,
    this.name,
    this.preferredUsername,
    this.givenName,
    this.familyName,
    this.email,
  });

  const User.empty() : this();


  final String sub;
  final bool emailVerified;
  final String name;
  final String preferredUsername;
  final String givenName;
  final String familyName;
  final String email;

  User copyWith({
    String sub,
    bool emailVerified,
    String name,
    String preferredUsername,
    String givenName,
    String familyName,
    String email,
  }) =>
      User(
        sub: sub ?? this.sub,
        emailVerified: emailVerified ?? this.emailVerified,
        name: name ?? this.name,
        preferredUsername: preferredUsername ?? this.preferredUsername,
        givenName: givenName ?? this.givenName,
        familyName: familyName ?? this.familyName,
        email: email ?? this.email,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
    sub: json["sub"],
    emailVerified: json["email_verified"],
    name: json["name"],
    preferredUsername: json["preferred_username"],
    givenName: json["given_name"],
    familyName: json["family_name"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "sub": sub,
    "email_verified": emailVerified,
    "name": name,
    "preferred_username": preferredUsername,
    "given_name": givenName,
    "family_name": familyName,
    "email": email,
  };

  @override
  // TODO: implement props
  List<Object> get props => [sub, emailVerified, name, preferredUsername, givenName, familyName, email];
}

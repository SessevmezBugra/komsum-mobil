// To parse this JSON data, do
//
//     final keycloakUserEntity = keycloakUserEntityFromJson(jsonString);

import 'dart:convert';

KeycloakUserEntity keycloakUserEntityFromJson(String str) => KeycloakUserEntity.fromJson(json.decode(str));

String keycloakUserEntityToJson(KeycloakUserEntity data) => json.encode(data.toJson());

class KeycloakUserEntity {
  KeycloakUserEntity({
    this.id,
    this.firstName,
    this.username,
    this.enabled,
    this.emailVerified,
    this.lastName,
    this.email,
    this.federationLink,
    this.serviceAccountClientId,
    this.attributes,
  });

  String id;
  String firstName;
  String username;
  bool enabled;
  bool emailVerified;
  String lastName;
  String email;
  dynamic federationLink;
  dynamic serviceAccountClientId;
  List<Attribute> attributes;

  KeycloakUserEntity copyWith({
    String id,
    String firstName,
    String username,
    bool enabled,
    bool emailVerified,
    String lastName,
    String email,
    dynamic federationLink,
    dynamic serviceAccountClientId,
    List<Attribute> attributes,
  }) =>
      KeycloakUserEntity(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        username: username ?? this.username,
        enabled: enabled ?? this.enabled,
        emailVerified: emailVerified ?? this.emailVerified,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        federationLink: federationLink ?? this.federationLink,
        serviceAccountClientId: serviceAccountClientId ?? this.serviceAccountClientId,
        attributes: attributes ?? this.attributes,
      );

  factory KeycloakUserEntity.fromJson(Map<String, dynamic> json) => KeycloakUserEntity(
    id: json["id"],
    firstName: json["firstName"],
    username: json["username"],
    enabled: json["enabled"],
    emailVerified: json["emailVerified"],
    lastName: json["lastName"],
    email: json["email"],
    federationLink: json["federationLink"],
    serviceAccountClientId: json["serviceAccountClientId"],
    attributes: List<Attribute>.from(json["attributes"].map((x) => Attribute.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "username": username,
    "enabled": enabled,
    "emailVerified": emailVerified,
    "lastName": lastName,
    "email": email,
    "federationLink": federationLink,
    "serviceAccountClientId": serviceAccountClientId,
    "attributes": List<dynamic>.from(attributes.map((x) => x.toJson())),
  };
}

class Attribute {
  Attribute({
    this.id,
    this.name,
    this.value,
  });

  String id;
  String name;
  String value;

  Attribute copyWith({
    String id,
    String name,
    String value,
  }) =>
      Attribute(
        id: id ?? this.id,
        name: name ?? this.name,
        value: value ?? this.value,
      );

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
    id: json["id"],
    name: json["name"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "value": value,
  };
}

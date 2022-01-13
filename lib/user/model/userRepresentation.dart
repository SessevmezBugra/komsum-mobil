// To parse this JSON data, do
//
//     final userRepresentation = userRepresentationFromJson(jsonString);

import 'dart:convert';

UserRepresentation userRepresentationFromJson(String str) => UserRepresentation.fromJson(json.decode(str));

String userRepresentationToJson(UserRepresentation data) => json.encode(data.toJson());

class UserRepresentation {
  UserRepresentation({
    this.self,
    this.id,
    this.origin,
    this.createdTimestamp,
    this.username,
    this.enabled,
    this.totp,
    this.emailVerified,
    this.firstName,
    this.lastName,
    this.email,
    this.federationLink,
    this.serviceAccountClientId,
    this.attributes,
    this.credentials,
    this.disableableCredentialTypes,
    this.requiredActions,
    this.federatedIdentities,
    this.realmRoles,
    this.clientRoles,
    this.clientConsents,
    this.notBefore,
    this.applicationRoles,
    this.socialLinks,
    this.groups,
    this.access,
  });

  dynamic self;
  String id;
  dynamic origin;
  int createdTimestamp;
  String username;
  bool enabled;
  bool totp;
  bool emailVerified;
  String firstName;
  String lastName;
  String email;
  dynamic federationLink;
  dynamic serviceAccountClientId;
  Attributes attributes;
  dynamic credentials;
  List<dynamic> disableableCredentialTypes;
  List<dynamic> requiredActions;
  dynamic federatedIdentities;
  dynamic realmRoles;
  dynamic clientRoles;
  dynamic clientConsents;
  int notBefore;
  dynamic applicationRoles;
  dynamic socialLinks;
  dynamic groups;
  Access access;

  UserRepresentation copyWith({
    dynamic self,
    String id,
    dynamic origin,
    int createdTimestamp,
    String username,
    bool enabled,
    bool totp,
    bool emailVerified,
    String firstName,
    String lastName,
    String email,
    dynamic federationLink,
    dynamic serviceAccountClientId,
    Attributes attributes,
    dynamic credentials,
    List<dynamic> disableableCredentialTypes,
    List<dynamic> requiredActions,
    dynamic federatedIdentities,
    dynamic realmRoles,
    dynamic clientRoles,
    dynamic clientConsents,
    int notBefore,
    dynamic applicationRoles,
    dynamic socialLinks,
    dynamic groups,
    Access access,
  }) =>
      UserRepresentation(
        self: self ?? this.self,
        id: id ?? this.id,
        origin: origin ?? this.origin,
        createdTimestamp: createdTimestamp ?? this.createdTimestamp,
        username: username ?? this.username,
        enabled: enabled ?? this.enabled,
        totp: totp ?? this.totp,
        emailVerified: emailVerified ?? this.emailVerified,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        federationLink: federationLink ?? this.federationLink,
        serviceAccountClientId: serviceAccountClientId ?? this.serviceAccountClientId,
        attributes: attributes ?? this.attributes,
        credentials: credentials ?? this.credentials,
        disableableCredentialTypes: disableableCredentialTypes ?? this.disableableCredentialTypes,
        requiredActions: requiredActions ?? this.requiredActions,
        federatedIdentities: federatedIdentities ?? this.federatedIdentities,
        realmRoles: realmRoles ?? this.realmRoles,
        clientRoles: clientRoles ?? this.clientRoles,
        clientConsents: clientConsents ?? this.clientConsents,
        notBefore: notBefore ?? this.notBefore,
        applicationRoles: applicationRoles ?? this.applicationRoles,
        socialLinks: socialLinks ?? this.socialLinks,
        groups: groups ?? this.groups,
        access: access ?? this.access,
      );

  factory UserRepresentation.fromJson(Map<String, dynamic> json) => UserRepresentation(
    self: json["self"],
    id: json["id"],
    origin: json["origin"],
    createdTimestamp: json["createdTimestamp"],
    username: json["username"],
    enabled: json["enabled"],
    totp: json["totp"],
    emailVerified: json["emailVerified"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    federationLink: json["federationLink"],
    serviceAccountClientId: json["serviceAccountClientId"],
    attributes: json["attributes"] != null ? Attributes.fromJson(json["attributes"]) : null,
    credentials: json["credentials"],
    disableableCredentialTypes: List<dynamic>.from(json["disableableCredentialTypes"].map((x) => x)),
    requiredActions: List<dynamic>.from(json["requiredActions"].map((x) => x)),
    federatedIdentities: json["federatedIdentities"],
    realmRoles: json["realmRoles"],
    clientRoles: json["clientRoles"],
    clientConsents: json["clientConsents"],
    notBefore: json["notBefore"],
    applicationRoles: json["applicationRoles"],
    socialLinks: json["socialLinks"],
    groups: json["groups"],
    access: Access.fromJson(json["access"]),
  );

  Map<String, dynamic> toJson() => {
    "self": self,
    "id": id,
    "origin": origin,
    "createdTimestamp": createdTimestamp,
    "username": username,
    "enabled": enabled,
    "totp": totp,
    "emailVerified": emailVerified,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "federationLink": federationLink,
    "serviceAccountClientId": serviceAccountClientId,
    "attributes": attributes.toJson(),
    "credentials": credentials,
    "disableableCredentialTypes": List<dynamic>.from(disableableCredentialTypes.map((x) => x)),
    "requiredActions": List<dynamic>.from(requiredActions.map((x) => x)),
    "federatedIdentities": federatedIdentities,
    "realmRoles": realmRoles,
    "clientRoles": clientRoles,
    "clientConsents": clientConsents,
    "notBefore": notBefore,
    "applicationRoles": applicationRoles,
    "socialLinks": socialLinks,
    "groups": groups,
    "access": access.toJson(),
  };
}

class Access {
  Access({
    this.manageGroupMembership,
    this.view,
    this.mapRoles,
    this.impersonate,
    this.manage,
  });

  bool manageGroupMembership;
  bool view;
  bool mapRoles;
  bool impersonate;
  bool manage;

  Access copyWith({
    bool manageGroupMembership,
    bool view,
    bool mapRoles,
    bool impersonate,
    bool manage,
  }) =>
      Access(
        manageGroupMembership: manageGroupMembership ?? this.manageGroupMembership,
        view: view ?? this.view,
        mapRoles: mapRoles ?? this.mapRoles,
        impersonate: impersonate ?? this.impersonate,
        manage: manage ?? this.manage,
      );

  factory Access.fromJson(Map<String, dynamic> json) => Access(
    manageGroupMembership: json["manageGroupMembership"],
    view: json["view"],
    mapRoles: json["mapRoles"],
    impersonate: json["impersonate"],
    manage: json["manage"],
  );

  Map<String, dynamic> toJson() => {
    "manageGroupMembership": manageGroupMembership,
    "view": view,
    "mapRoles": mapRoles,
    "impersonate": impersonate,
    "manage": manage,
  };
}

class Attributes {
  Attributes({
    this.pictureId,
  });

  List<String> pictureId;

  Attributes copyWith({
    List<String> pictureId,
  }) =>
      Attributes(
        pictureId: pictureId ?? this.pictureId,
      );

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
    pictureId: List<String>.from(json["pictureId"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "pictureId": List<dynamic>.from(pictureId.map((x) => x)),
  };
}

import 'dart:convert';

class UserModel {
  UserData? data;
  String? message;
  String? access_token;
  String? token_type;
  List<String>? abilities;

  UserModel(
      {this.data,
      this.message,
      this.access_token,
      this.token_type,
      this.abilities});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        data: UserData.fromJson(json["data"]),
        message: json["message"],
        access_token: json["access_token"],
        token_type: json["token_type"],
        abilities:
            (json["abilites"] as List).map((e) => e.toString()).toList());
  }
}

class UserData {
  int? id;
  String? name;
  String? email;
  String? email_verified_at;
  String? phone;
  String? google_id;
  String? facebook_id;
  int? roles;
  String? created_at;
  String? updated_at;
  List<ActiveRoles>? activeroles;

  UserData(
      {this.id,
      this.name,
      this.email,
      this.email_verified_at,
      this.phone,
      this.google_id,
      this.facebook_id,
      this.roles,
      this.created_at,
      this.updated_at,
      this.activeroles});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      email_verified_at: json["email_verified_at"] ?? "",
      phone: json["phone"],
      google_id: json["google_id"] ?? "",
      facebook_id: json["facebook_id"] ?? "",
      roles: json["roles"],
      created_at: json["created_at"],
      updated_at: json["updated_at"],
      activeroles: (json["activeroles"] as List)
          .map((e) => ActiveRoles.fromJson(e))
          .toList(),
    );
  }
}

class ActiveRoles {
  int? id;
  String? name;
  int? user_id;
  int? role_id;
  String? created_at;
  String? updated_at;
  Role? role;

  ActiveRoles(
      {this.id,
      this.name,
      this.user_id,
      this.role_id,
      this.created_at,
      this.updated_at,
      this.role});

  factory ActiveRoles.fromJson(Map<String, dynamic> json) {
    return ActiveRoles(
        id: json["id"],
        user_id: json["user_id"],
        role_id: json["role_id"],
        created_at: json["created_at"],
        updated_at: json["updated_at"],
        role: Role.fromJson(json["role"]));
  }
}

class Role {
  int? id;
  String? name;

  Role({this.id, this.name});

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(id: json["id"], name: json["name"]);
  }
}

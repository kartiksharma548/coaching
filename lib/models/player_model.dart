import 'dart:convert';

class PlayerModel {
  int? id;
  String? created_at;
  String? updated_at;
  int? user_id;
  String? dob;
  String? name;

  PlayerModel(
      {this.id,
      this.created_at,
      this.updated_at,
      this.user_id,
      this.dob,
      this.name});

  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    return PlayerModel(
      id: json["id"],
      created_at: json["created_at"] ?? "",
      updated_at: json["updated_at"] ?? "",
      user_id: json["user_id"],
      dob: json["dob"],
      name: json["name"],
    );
  }
}

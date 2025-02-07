class UserModel {
  int? id;
  DateTime? created;
  String? name;
  String? email;
  String? uid;

  UserModel({
    this.id,
    this.created,
    this.name,
    this.email,
    this.uid,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    created = json["created_at"];
    name = json["name"];
    email = json["email"];
    uid = json["user_id"];
  }

  Map<String, dynamic> toJson() {
    return {
      "created_at": created?.toIso8601String(),
      "name": name,
      "email": email,
      "user_id": uid,
    };
  }
}

class User {
  User({
      this.type, 
      this.token,});

  User.fromJson(dynamic json) {
    type = json['type'];
    token = json['token'];
  }
  String? type;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['token'] = token;
    return map;
  }

}
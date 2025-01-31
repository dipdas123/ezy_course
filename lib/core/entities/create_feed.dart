class CreatePost {
  CreatePost({
    this.id,
  });

  CreatePost.fromJson(dynamic json) {
    id = json['id'];
  }
  int? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    return map;
  }

}
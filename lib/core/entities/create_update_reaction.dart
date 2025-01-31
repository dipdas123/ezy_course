class CreateUpdateReaction {
  CreateUpdateReaction({
      this.totalReactions, 
      this.likeType,});

  CreateUpdateReaction.fromJson(dynamic json) {
    totalReactions = json['total_reactions'];
    if (json['likeType'] != null) {
      likeType = [];
      json['likeType'].forEach((v) {
        likeType?.add(LikeType.fromJson(v));
      });
    }
  }
  num? totalReactions;
  List<LikeType>? likeType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total_reactions'] = totalReactions;
    if (likeType != null) {
      map['likeType'] = likeType?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class LikeType {
  LikeType({
      this.reactionType, 
      this.meta,});

  LikeType.fromJson(dynamic json) {
    reactionType = json['reaction_type'];
    meta = json['meta'];
  }
  String? reactionType;
  dynamic meta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['reaction_type'] = reactionType;
    map['meta'] = meta;
    return map;
  }

}
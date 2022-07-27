class CharacterModel {
  int? charId;
  String? name;
  String? nickName;
  String? image;
  List<dynamic>? jobs;
  String? statusIfDeadOrAlive;
  List<dynamic>? appearanceOfSeasons;
  String? actorName;
  String? categoryForTwoSeries;
  List<dynamic>? betterCallSaulAppearance;

  CharacterModel({
    this.charId,
    this.name,
    this.nickName,
    this.image,
    this.jobs,
    this.statusIfDeadOrAlive,
    this.appearanceOfSeasons,
    this.actorName,
    this.categoryForTwoSeries,
    this.betterCallSaulAppearance,
  });

  CharacterModel.fromJson(Map<String, dynamic> json) {
    charId = json['char_id'];
    name = json['name'];
    nickName = json['nickname'];
    image = json['img'];
    jobs = json['occupation'];
    statusIfDeadOrAlive = json['status'];
    appearanceOfSeasons = json['appearance'];
    actorName = json['portrayed'];
    categoryForTwoSeries = json['category'];
    betterCallSaulAppearance = json['better_call_saul_appearance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['char_id'] = charId;
    data['name'] = name;
    data['occupation'] = jobs;
    data['img'] = image;
    data['status'] = statusIfDeadOrAlive;
    data['nickname'] = nickName;
    data['appearance'] = appearanceOfSeasons;
    data['portrayed'] = actorName;
    data['category'] = categoryForTwoSeries;
    data['better_call_saul_appearance'] = betterCallSaulAppearance;

    return data;
  }
}

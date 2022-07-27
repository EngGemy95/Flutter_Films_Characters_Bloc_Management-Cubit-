class CharacterQuotesModel {
  late String quote;

  CharacterQuotesModel.fromJson(Map<String, dynamic> json) {
    quote = json['quote'];
  }
}

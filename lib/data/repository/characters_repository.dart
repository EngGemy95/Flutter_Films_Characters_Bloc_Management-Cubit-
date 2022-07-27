import 'package:important_app/data/models/character_quotes_model.dart';
import 'package:important_app/data/web_services/characters_web_services.dart';

import '../models/character_model.dart';

class CharactersRepository {
  final CharactersWebService charactersWebService;

  CharactersRepository(this.charactersWebService);

  Future<List<CharacterModel>> getAllCharacters() async {
    final characters = await charactersWebService.getAllCharacters();

    // return characters
    //     .map((character) => CharacterModel.fromJson({
    //           'char_id': character['char_id'],
    //           'name': character['name'],
    //           'birthday': character['birthday'],
    //           'nickname': character['nickname'],
    //           'img': character['img'],
    //           'occupation': character['occupation'],
    //           'status': character['status'],
    //           'appearance': character['appearance'],
    //           'portrayed': character['portrayed'],
    //           'category': character['category'],
    //           'better_call_saul_appearance':
    //               character['better_call_saul_appearance'],
    //         }))
    //     .toList();

    return characters
        .map((character) => CharacterModel.fromJson(character))
        .toList();
  }  

  Future<List<CharacterQuotesModel>> getCharacterQuotes(String author) async {
    final quotes = await charactersWebService.getCharactersQuotes(author);

    return quotes
        .map((characterQuote) => CharacterQuotesModel.fromJson(characterQuote))
        .toList();
  }
}

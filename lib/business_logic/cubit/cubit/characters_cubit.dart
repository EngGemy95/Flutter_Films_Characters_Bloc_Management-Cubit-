import 'package:bloc/bloc.dart';
import 'package:important_app/data/models/character_model.dart';
import 'package:important_app/data/models/character_quotes_model.dart';
import 'package:important_app/data/repository/characters_repository.dart';
import 'package:important_app/data/web_services/characters_web_services.dart';
import 'package:meta/meta.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;

  //final CharactersWebService charactersWebService;
  List<CharacterModel> characters = [];

  CharactersCubit(this.charactersRepository) : super(CharactersInitial());

  List<CharacterModel> getAllCharacters() {
    charactersRepository.getAllCharacters().then((characters) {
      emit(LoadedCharacters(characters));
      this.characters = characters;
    });
    return characters;
  }

  void getCharacterQuotes(String author) {
    charactersRepository.getCharacterQuotes(author).then((quote) {
      emit(LoadedCharacterQuotes(quote));
    });
  }
}

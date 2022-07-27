part of 'characters_cubit.dart';

@immutable
abstract class CharactersState {}

class CharactersInitial extends CharactersState {}

class LoadedCharacters extends CharactersState {
  final List<CharacterModel> characters;

  LoadedCharacters(this.characters);
}

class LoadedCharacterQuotes extends CharactersState {
  final List<CharacterQuotesModel> quotes;

  LoadedCharacterQuotes(this.quotes);
}

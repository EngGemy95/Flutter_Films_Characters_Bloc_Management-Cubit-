import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:important_app/business_logic/cubit/cubit/characters_cubit.dart';
import 'package:important_app/constants/strings.dart';
import 'package:important_app/data/models/character_model.dart';
import 'package:important_app/data/repository/characters_repository.dart';
import 'package:important_app/data/web_services/characters_web_services.dart';
import 'package:important_app/presentation/screens/character_details_screen.dart';
import 'package:important_app/presentation/screens/characters_screen.dart';

class AppRouter {
  late CharactersCubit charactersCubit;
  late CharactersRepository charactersRepository;

  AppRouter() {
    charactersRepository = CharactersRepository(CharactersWebService());
    charactersCubit = CharactersCubit(charactersRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case characterScreenRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (_) => charactersCubit,
                  child: CharactersScreen(),
                ));

      case characterDetailsRoute:
        final selectedCharacter = settings.arguments as CharacterModel;

        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (_) => CharactersCubit(charactersRepository),
                  child: CharacterDetailsScreen(
                    character: selectedCharacter,
                  ),
                ));

      // default:
      //   return MaterialPageRoute(builder: (_) => const CharactersScreen());
    }
  }
}

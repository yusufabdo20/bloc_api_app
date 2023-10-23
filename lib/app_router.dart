import 'package:bloc_apiapp/business_logic/cubit/charcters_cubit.dart';
import 'package:bloc_apiapp/constants/strings.dart';
import 'package:bloc_apiapp/data/model/character.dart';
import 'package:bloc_apiapp/data/services/characters_services.dart';
import 'package:bloc_apiapp/data/repository/characters_repository.dart';
import 'package:bloc_apiapp/presentation_layer/screens/characters_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation_layer/screens/characters_details_screen.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharctersCubit charactersCubit;

  AppRouter() {
    charactersRepository = CharactersRepository(
        CharactersWebServices()); // CharactersWebServices is object here
    charactersCubit = CharctersCubit(charactersRepository);
  }
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreenRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) =>
                CharctersCubit(charactersRepository),
            child: const CharactersScreen(),
          ),
        );

      case characterDetailsScreenRoute:
        final selectedCharcters = settings.arguments as CharacterModel;
        return MaterialPageRoute(
            builder: (_) => CharacterDetailsScreen(
                  character: selectedCharcters,
                ));
    }
    return null;
  }
}

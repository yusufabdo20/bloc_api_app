import 'package:bloc/bloc.dart';
import 'package:bloc_apiapp/data/model/character.dart';
import 'package:bloc_apiapp/data/repository/characters_repository.dart';
import 'package:meta/meta.dart';

part 'charcters_state.dart';

class CharctersCubit extends Cubit<CharctersState> {
  final CharactersRepository charactersRepository;
  List<CharacterModel> characters = [];
  CharctersCubit(this.charactersRepository) : super(CharctersInitial());

  List<CharacterModel> getAllCharacters() {
    charactersRepository.getAllCharacters().then((charactersItems) {
      emit(CharactersLoaded(charactersItems));
      characters = charactersItems;
    });
    return characters;
  }
}

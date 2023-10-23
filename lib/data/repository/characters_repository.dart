import 'package:bloc_apiapp/data/services/characters_services.dart';
import 'package:bloc_apiapp/data/model/character.dart';

class CharactersRepository {
  final CharactersWebServices charactersWebServices;

  CharactersRepository(this.charactersWebServices);
  Future<List<CharacterModel>> getAllCharacters() async {
    final characters = await charactersWebServices.getAllCharacters();
    return characters
        .map((character) => CharacterModel.fromJson(character))
        .toList();
  }
}
// الكلاس بتاع السيرفزس بيستقبل الداتا و يباصيها للريبوسيتوري و الريبوسيتوري يباصيها للكيوبت و الكيوبت يباصيها لل يو أي
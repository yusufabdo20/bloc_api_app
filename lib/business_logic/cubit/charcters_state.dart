part of 'charcters_cubit.dart';

@immutable
abstract class CharctersState {}

class CharctersInitial extends CharctersState {}

class CharactersLoaded extends CharctersState {
  final List<CharacterModel> characters;
  CharactersLoaded(this.characters);
}
// class CharctersErrorCase extends CharctersState {}
//في حالة الايرور يعما ايه و كدا 
// class CharctersLoading extends CharctersState {}
//في حالة التحميل او الكاركترز بتحمل .. بعمل ايه  

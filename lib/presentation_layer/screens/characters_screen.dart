import 'package:bloc_apiapp/business_logic/cubit/charcters_cubit.dart';
import 'package:bloc_apiapp/constants/my_colors.dart';
import 'package:bloc_apiapp/data/model/character.dart';
import 'package:bloc_apiapp/presentation_layer/widgets/character_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<CharacterModel> allCharacters;
//----------------------------------------------------------------------------------------------------------------------------------------
  //Search
  late List<CharacterModel> searchForCharacters;
  bool _isSearching = false; //searching now or not ?
  final searchTextController = TextEditingController();
  Widget _buildSearchField() {
    return TextField(
        controller: searchTextController,
        cursorColor: MyColors.myGrey,
        decoration: InputDecoration(
            labelText: "Search",
            hintText: "find a character",
            border: InputBorder.none,
            hintStyle: TextStyle(color: MyColors.myGrey, fontSize: 14)),
        style: TextStyle(color: MyColors.myGrey, fontSize: 14),
        onChanged: (searchedCharacter) {
          addSearchedForItemsToSearchedList(searchedCharacter);

          // الفانكشن دي هتاخد الحرف اللي اليوزر كاتبه و تبدا تشوف الايتمز اللي بيبدؤا بالحرف دا
        });
  }

  addSearchedForItemsToSearchedList(String searchedCharacter) {
    searchForCharacters = allCharacters
        .where((char) => char.name!.toLowerCase().startsWith(searchedCharacter))
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
          onPressed: () {
            _clearSearch();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.clear, color: MyColors.myGrey),
        )
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearch,
          icon: Icon(
            Icons.search,
            color: MyColors.myGrey,
          ),
        ),
      ];
    }
  }

  void _startSearch() {
    // Focus HERE ***********************
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      searchTextController.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharctersCubit>(context).getAllCharacters();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharctersCubit, CharctersState>(
        // Start buid the blocBuilder thats returns from BlocProvider and provide the cubit and state
        builder: (context, state) {
      //state type from CharactersStates بيبقا عندي اكتر من ستيت.. و عشان كدا بسأل بـ اف  .... و
      if (state is CharactersLoaded) {
        // بسأل هل ال ستيت دي حالتها لوديد ؟؟

        allCharacters = state.characters;
        // state.characters from CharactersLoaded State
        // List<Character> characters .. يبقا انا الكاركترز دي جاية من الستيت لوديد ..
        // لستة فاضية .. فلما تتملي .. تبدأبقا ترمي في الاووول كاركترزcharacters
        // allCharacters will take tha data thats come from the Repository ,So allCharacters carry all Loaded data

        return buildLoadedListWidgets();
      } else {
        return showLoadingIndicator();
      }
    });
  }

  Widget showLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: MyColors.myWhite,
        color: MyColors.myYellow,
      ),
    );
  }

  Widget buildLoadedListWidgets() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myWhite,
        child: Column(
          children: [
            buildCharactersList(),
          ],
        ),
      ),
    );
  }

  Widget buildCharactersList() {
    // هنا هحط و ابيلد الليست بتاعتي ..
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        // count of grids in one row
        childAspectRatio: 2 / 3,
        //Size of the grid width /height
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      //بتخلي الجريد تشتغل و معنديش مشكلة
      // padding: EdgeInsets.a,
      // احيانا بيحصل ايرورز في ال يو ااي فلما ممكن نستخدم ال دوت زيرو .. بتتحل المشكلة

      itemCount: searchTextController.text.isEmpty
          ? allCharacters.length
          : searchForCharacters.length,
      itemBuilder: (context, index) {
        return CharacterItem(
          character: searchTextController.text.isEmpty
              ? allCharacters[index]
              : searchForCharacters[index],
        );
      },
    );
  }

  Widget _buildAppBarTitle() {
    return const Text(
      "Characters",
      style: TextStyle(color: MyColors.myGrey, fontSize: 20),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.myYellow,
        leading: _isSearching
            ? BackButton(
                color: MyColors.myGrey,
              )
            : Container(),
        title: _isSearching ? _buildSearchField() : _buildAppBarTitle(),
        actions: _buildAppBarActions(),
      ),
      body: buildBlocWidget(),
    );
  }
}

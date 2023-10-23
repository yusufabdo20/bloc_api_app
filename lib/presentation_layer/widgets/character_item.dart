import 'package:bloc_apiapp/constants/my_colors.dart';
import 'package:bloc_apiapp/constants/strings.dart';
import 'package:bloc_apiapp/data/model/character.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CharacterItem extends StatelessWidget {
  const CharacterItem({Key? key, required this.character}) : super(key: key);
  // Constructor for final field (character) .
  final CharacterModel character;
// انا عملت كاركتر للواحد .. باجي بقا هنا و ابدا اظبط الدنيا
  //  Now I will build one item  ..  How to build one item ? One image , One character >>
  //Build One grid and put it #<standard> for all grids .
  //and after that,  put all these properties in all charcters (List)
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsetsDirectional.fromSTEB(
        5,
        5,
        5,
        5,
      ),
      //fromSTEB(start, top, end, bottom),
      padding: EdgeInsetsDirectional.all(05),
      decoration: BoxDecoration(
        color: MyColors.myWhite,
        borderRadius: BorderRadius.circular(10),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, characterDetailsScreenRoute,
              arguments: character);
        },
        child: GridTile(
          child: Hero(
            tag: character.id!,
            child: Container(
              color: MyColors.myGrey,
              // لما يكون في نت هات صورة من لوتي فايل و حطها في ملف الاميجيز و بعدين حطها في ال بليس هولدر
              child: character.image!.isNotEmpty
                  ? FadeInImage.assetNetwork(
                      width: double.infinity,
                      height: double.infinity,
                      placeholder: "assets/images/loading2.gif",
                      image: character.image!, // IMAGE IS HERE
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/images/burger.png'), // هنا حط اي صورة .. مش مشكلة مكان البليس هولدر ...
            ),
          ),
          footer: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: Colors.black54,
            alignment: Alignment.bottomCenter,
            child: Text(
              '${character.name}',
              style: TextStyle(
                  height: 1.3,
                  fontSize: 16,
                  color: MyColors.myWhite,
                  fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

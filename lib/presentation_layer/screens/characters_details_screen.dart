// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc_apiapp/constants/my_colors.dart';
import 'package:flutter/material.dart';

import 'package:bloc_apiapp/data/model/character.dart';

class CharacterDetailsScreen extends StatelessWidget {
  CharacterModel character;
  CharacterDetailsScreen({
    Key? key,
    required this.character,
  }) : super(key: key);
  buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 800,
      pinned: true,
      stretch: false,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              10,
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                color: MyColors.myGrey,
                offset: Offset(
                  3,
                  5,
                ),
              )
            ],
          ),
          child: Text(
            character.name!,
            style: TextStyle(
              color: MyColors.myGrey,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            // textAlign: TextAlign.start,
          ),
        ),
        background: Hero(
          tag: character.id!,
          child: Image.network(
            character.image!,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  characterInfo(
    String title,
    String value,
  ) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: '$title : ',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              color: MyColors.myWhite,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  buildDivider(double width) {
    return Divider(
      endIndent: width,
      height: 10,
      color: MyColors.myYellow,
      thickness: 2.5,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  characterInfo(
                    "Species",
                    character.species!,
                  ),
                  buildDivider(150),
                  characterInfo(
                    "Status",
                    character.status!,
                  ),
                  buildDivider(200),
                  characterInfo(
                    "Gender",
                    character.gender!,
                  ),
                  buildDivider(300),
                  characterInfo(
                    "Location",
                    character.location!.name!,
                  ),
                  buildDivider(175),
                  // buildDivider(175),
                  SizedBox(
                    height: 300,
                  )
                ],
              ),
            )
          ]))
        ],
      ),
    );
  }
}

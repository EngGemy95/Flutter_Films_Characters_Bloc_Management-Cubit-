import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:important_app/business_logic/cubit/cubit/characters_cubit.dart';
import 'package:important_app/constants/my_colors.dart';
import 'package:important_app/data/models/character_model.dart';

class CharacterDetailsScreen extends StatelessWidget {
  const CharacterDetailsScreen({
    Key? key,
    required this.character,
  }) : super(key: key);

  final CharacterModel character;

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height * 0.55,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        //centerTitle: true,
        title: Text(
          character.nickName ?? '-',
          style: TextStyle(color: MyColors.myWhite),
          textAlign: TextAlign.start,
        ),
        background: Hero(
            tag: character.charId!,
            child: Image.network(
              character.image!,
              fit: BoxFit.cover,
            )),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(children: [
          TextSpan(
              text: title,
              style: const TextStyle(
                color: MyColors.myYellow,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              )),
          TextSpan(
              text: value,
              style: const TextStyle(
                color: MyColors.myWhite,
                fontSize: 16,
              ))
        ]));
  }

  Widget buildDivider(double _endIndent) {
    return Divider(
      color: MyColors.myYellow,
      height: 30,
      endIndent: _endIndent,
      thickness: 2,
    );
  }

  Widget displayRandomQuoteOrEmptySpace(state) {
    final quotes = (state).quotes;

    if (quotes.length != 0) {
      int randomQuoteIndex = Random().nextInt(quotes.length - 1);
      return Center(
        child: DefaultTextStyle(
          child: TextLiquidFill(
            text: quotes[randomQuoteIndex].quote,
            waveColor: MyColors.myYellow,
            boxBackgroundColor: MyColors.myGrey,
            textStyle: const TextStyle(
              fontSize: 30.0,
            ),
            boxHeight: 300.0,
          ),
          // child: AnimatedTextKit(
          //   repeatForever: true,
          //   animatedTexts: [
          //     FlickerAnimatedText(quotes[randomQuoteIndex].quote)
          //   ],
          // ),
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: MyColors.myYellow,
            fontSize: 20,
            shadows: [
              Shadow(
                blurRadius: 7,
                color: MyColors.myYellow,
                offset: Offset(0, 0),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget showProgressIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }

  Widget checkIfQuotesAreLoaed(state) {
    if (state is LoadedCharacterQuotes) {
      return displayRandomQuoteOrEmptySpace(state);
    } else {
      return showProgressIndicator();
    }
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharactersCubit>(context)
        .getCharacterQuotes(character.name!);
    return Scaffold(
        backgroundColor: MyColors.myGrey,
        body: CustomScrollView(
          slivers: [
            _buildSliverAppBar(context),
            SliverList(
                delegate: SliverChildListDelegate([
              Container(
                margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    characterInfo('Job : ', character.jobs!.join(' / ')),
                    //buildDivider(400),
                    characterInfo(
                        'Appeared in : ', character.categoryForTwoSeries!),
                    //buildDivider(335),
                    character.appearanceOfSeasons!.isNotEmpty
                        ? characterInfo('Seasons : ',
                            character.appearanceOfSeasons!.join(' / '))
                        : Container(),
                    // character.appearanceOfSeasons!.isNotEmpty
                    //     ? buildDivider(365)
                    //     : Container(),
                    characterInfo('Status : ', character.statusIfDeadOrAlive!),
                    //buildDivider(385),
                    character.betterCallSaulAppearance!.isNotEmpty
                        ? characterInfo('Better Call Saul Seasons : ',
                            character.betterCallSaulAppearance!.join(' / '))
                        : Container(),
                    // character.betterCallSaulAppearance!.isNotEmpty
                    //     ? buildDivider(230)
                    //     : Container(),
                    characterInfo(
                        'Actor/Actress : ', character.jobs!.join(' / ')),
                    //buildDivider(315),
                    SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<CharactersCubit, CharactersState>(
                      builder: ((context, state) {
                        return checkIfQuotesAreLoaed(state);
                      }),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 500,
              )
            ]))
          ],
        ));
  }
}

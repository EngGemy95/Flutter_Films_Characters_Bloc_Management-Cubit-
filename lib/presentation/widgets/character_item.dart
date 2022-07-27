import 'package:flutter/material.dart';
import 'package:important_app/constants/my_colors.dart';
import 'package:important_app/constants/strings.dart';
import 'package:important_app/data/models/character_model.dart';

class CharacterItem extends StatelessWidget {
  const CharacterItem({required this.characterItem, Key? key})
      : super(key: key);

  final CharacterModel characterItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: const EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
      decoration: BoxDecoration(
        color: MyColors.myWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
          onTap: () => Navigator.pushNamed(
                context,
                characterDetailsRoute,
                arguments: characterItem,
              ),
          child: GridTile(
            child: Hero(
              tag: characterItem.charId!,
              child: Container(
                color: MyColors.myGrey,
                child: characterItem.image != null
                    ? characterItem.image!.isNotEmpty
                        ? FadeInImage.assetNetwork(
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                            placeholder: 'assets/images/_loading.gif',
                            image: characterItem.image!,
                          )
                        : Image.asset('assets/images/_loading.gif')
                    : const Center(
                        child: Text('No Image!'),
                      ),
              ),
            ),
            footer: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              color: Colors.black54,
              alignment: Alignment.bottomCenter,
              child: Text(
                '${characterItem.name}',
                style: const TextStyle(
                  height: 1.3,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: MyColors.myWhite,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          )),
    );
  }
}

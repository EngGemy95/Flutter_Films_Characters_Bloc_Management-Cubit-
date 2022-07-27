import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:important_app/business_logic/cubit/cubit/characters_cubit.dart';
import 'package:important_app/constants/my_colors.dart';
import 'package:important_app/data/models/character_model.dart';
import 'package:important_app/presentation/widgets/character_item.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<CharacterModel> allCharacters;
  List<CharacterModel> searchedCharacters = [];
  bool _isSearching = false;
  final _searchTextController = TextEditingController();

  Widget _buildSearchField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: MyColors.myGrey,
      decoration: const InputDecoration(
        hintText: 'Find a character',
        counterStyle: TextStyle(
          color: MyColors.myWhite,
          fontSize: 18,
        ),
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: MyColors.myWhite,
          fontSize: 18,
        ),
      ),
      style: const TextStyle(
        color: MyColors.myWhite,
        fontSize: 18,
      ),
      onChanged: (searchedCharacter) {
        searchedCharacters = allCharacters
            .where((character) =>
                character.name!.toLowerCase().startsWith(searchedCharacter))
            .toList();
        setState(() {});
      },
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: _searchTextController.text.isEmpty
          ? allCharacters.length
          : searchedCharacters.length,
      itemBuilder: (ctx, index) {
        return CharacterItem(
          characterItem: _searchTextController.text.isEmpty
              ? allCharacters[index]
              : searchedCharacters[index],
        );
      },
    );
  }

  Widget buildLoadedCharacters() {
    return (searchedCharacters.isEmpty &&
            _isSearching &&
            _searchTextController.hasListeners)
        ? Center(
            child: Container(
              alignment: Alignment.center,
              height: double.infinity,
              width: double.infinity,
              color: MyColors.myGrey,
              child: const Text(
                'Character Not Found!',
                style: TextStyle(
                  color: MyColors.myWhite,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
        : SingleChildScrollView(
            child: Container(
              color: MyColors.myGrey,
              child: Column(
                children: [
                  buildCharactersList(),
                ],
              ),
            ),
          );
  }

  Widget showLoadingIndicator() {
    return const Center(
        child: CircularProgressIndicator(
      color: Colors.blueGrey,
    ));
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(builder: ((_, state) {
      if (state is LoadedCharacters) {
        allCharacters = (state).characters;
        return buildLoadedCharacters();
      } else {
        return showLoadingIndicator();
      }
    }));
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
          onPressed: () {
            setState(() {
              //clear search
              _searchTextController.clear();
            });
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.clear,
            color: MyColors.myWhite,
          ),
        ),
      ];
    } else {
      return [
        IconButton(
            onPressed: _startSearch,
            icon: const Icon(
              Icons.search,
              color: MyColors.myWhite,
            )),
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearch));
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearch() {
    setState(() {
      //clear search
      _searchTextController.clear();
      _isSearching = false;
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  Widget _buildAppBarTitle() {
    return const Text(
      'Characters',
      style: TextStyle(color: MyColors.myWhite),
    );
  }

  Widget buildNoInternet() {
    return Center(
        child: Container(
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          const Text(
            'Can\'t connect... Check Internet',
            style: TextStyle(
              fontSize: 22,
              color: MyColors.myGrey,
            ),
          ),
          Image.asset(
            'assets/images/no_internet.png',
          ),
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching ? _buildSearchField() : _buildAppBarTitle(),
        actions: _buildAppBarActions(),
        leading: _isSearching
            ? const BackButton(
                color: MyColors.myWhite,
              )
            : null,
      ),
      body: OfflineBuilder(
        connectivityBuilder: (ctx, connectivity, child) {
          final bool connected = connectivity != ConnectivityResult.none;
          return connected ? buildBlocWidget() : buildNoInternet();
        },
        child: showLoadingIndicator(),
      ),
    );
  }
}

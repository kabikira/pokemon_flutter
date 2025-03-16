import 'package:flutter/material.dart';
import 'package:pokemon_flutter/consts/pokeapi.dart';
import 'package:pokemon_flutter/models/favorite.dart';
import 'package:pokemon_flutter/models/pokemon.dart';
import 'package:pokemon_flutter/poke_list_item.dart';
import 'package:pokemon_flutter/view_mode_bttom_sheet.dart';
import 'package:provider/provider.dart';

class PokeList extends StatefulWidget {
  const PokeList({super.key});
  @override
  _PokeListState createState() => _PokeListState();
}

class _PokeListState extends State<PokeList> {
  bool isFavoriteMode = true;
  int _currentPage = 1;

  int itemCount(int page, int size, int maxId, FavoritesNotifier favs) {
    int ret = page * size;
    if (isFavoriteMode && ret > favs.favs.length) {
      ret = favs.favs.length;
    }
    if (ret > maxId) {
      ret = maxId;
    }
    return ret;
  }

  int itemId(int index, FavoritesNotifier favs) {
    int ret = index + 1;
    if (isFavoriteMode) {
      ret = favs.favs[index].pokeId;
    }
    return ret;
  }

  bool isLastPage(int page, FavoritesNotifier favs) {
    if (isFavoriteMode) {
      if (_currentPage * pageSize < favs.favs.length) {
        return false;
      }
      return true;
    } else {
      if (_currentPage * pageSize < pokeMaxId) {
        return false;
      }
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesNotifier>(
      builder:
          (context, favs, child) => Column(
            children: [
              Container(
                height: 24,
                alignment: Alignment.topRight,
                child: IconButton(
                  padding: const EdgeInsets.all(0),
                  icon: const Icon(Icons.auto_awesome_outlined),
                  onPressed: () async {
                    var ret = await showModalBottomSheet<bool>(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      builder: (BuildContext context) {
                        return ViewModeBottomSheet(favMode: isFavoriteMode);
                      },
                    );
                    if (ret != null && ret) {
                      setState(() {
                        isFavoriteMode = !isFavoriteMode;
                      });
                    }
                  },
                ),
              ),
              Expanded(
                child: Consumer<PokemonsNotifier>(
                  builder: (context, pokes, child) {
                    if (itemCount(_currentPage, pageSize, pokeMaxId, favs) ==
                        0) {
                      return const Text('no data');
                    } else {
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 16,
                        ),
                        itemCount:
                            itemCount(_currentPage, pageSize, pokeMaxId, favs) +
                            1, // pokeMaxId,
                        itemBuilder: (context, index) {
                          if (index ==
                              itemCount(
                                _currentPage,
                                pageSize,
                                pokeMaxId,
                                favs,
                              )) {
                            return OutlinedButton(
                              child: const Text('more'),
                              onPressed:
                                  isLastPage(_currentPage, favs)
                                      ? null
                                      : () => {setState(() => _currentPage++)},
                            );
                          } else {
                            return PokeListItem(
                              poke: pokes.byId(itemId(index, favs)),
                            );
                          }
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pokemon_flutter/consts/pokeapi.dart';
import 'package:pokemon_flutter/models/favorite.dart';
import 'package:pokemon_flutter/models/pokemon.dart';
import 'package:pokemon_flutter/poke_list_item.dart';
import 'package:provider/provider.dart';

class PokeList extends StatefulWidget {
  const PokeList({super.key});
  @override
  _PokeListState createState() => _PokeListState();
}

class _PokeListState extends State<PokeList> {
  bool isFavoriteMode = true;
  int _currentPage = 1;

  List<Favorite> favMock = [
    Favorite(pokeId: 1),
    Favorite(pokeId: 4),
    Favorite(pokeId: 7),
  ];

  int itemCount(int page, int size, int maxId) {
    int ret = page * size;
    if (isFavoriteMode && ret > favMock.length) {
      ret = favMock.length;
    }
    if (ret > maxId) {
      ret = maxId;
    }
    return ret;
  }

  int itemId(int index) {
    int ret = index + 1;
    if (isFavoriteMode) {
      ret = favMock[index].pokeId;
    }
    return ret;
  }

  bool isLastPage(int page) {
    if (isFavoriteMode) {
      if (_currentPage * pageSize < favMock.length) {
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
    return Column(
      children: [
        Container(
          height: 24,
          alignment: Alignment.topRight,
          child: IconButton(
            padding: const EdgeInsets.all(0),
            icon:
                isFavoriteMode
                    ? const Icon(Icons.star, color: Colors.orangeAccent)
                    : const Icon(Icons.star_outline),
            onPressed: () => {setState(() => isFavoriteMode = !isFavoriteMode)},
          ),
        ),
        Expanded(
          child: Consumer<PokemonsNotifier>(
            builder:
                (context, pokes, child) => ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 16,
                  ),
                  itemCount:
                      itemCount(_currentPage, pageSize, pokeMaxId) +
                      1, // pokeMaxId,
                  itemBuilder: (context, index) {
                    if (index == itemCount(_currentPage, pageSize, pokeMaxId)) {
                      return OutlinedButton(
                        child: const Text('more'),
                        onPressed:
                            isLastPage(_currentPage)
                                ? null
                                : () => {setState(() => _currentPage++)},
                      );
                    } else {
                      return PokeListItem(poke: pokes.byId(itemId(index)));
                    }
                  },
                ),
          ),
        ),
      ],
    );
  }
}

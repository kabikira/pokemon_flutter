import 'package:flutter/material.dart';
import 'package:pokemon_flutter/poke_list_item.dart';

class PokeList extends StatelessWidget {
  const PokeList({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      itemCount: 1010,
      itemBuilder: (context, index) => PokeListItem(index: index),
    );
  }
}

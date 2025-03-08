import 'package:flutter/material.dart';
import 'package:pokemon_flutter/poke_detail.dart';
import 'package:pokemon_flutter/poke_list_item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const TopPage(),
    );
  }
}

class TopPage extends StatelessWidget {
  const TopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children:
            List.generate(
              10000,
              (id) => id,
            ).map((val) => PokeListItem(index: val)).toList(),
      ),
    );
  }
}

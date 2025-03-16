import 'package:flutter/material.dart';
import 'package:pokemon_flutter/models/favorite.dart';
import 'package:pokemon_flutter/models/pokemon.dart';
import 'package:pokemon_flutter/models/theme_mode.dart';
import 'package:pokemon_flutter/poke_list.dart';
import 'package:pokemon_flutter/settings.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences pref = await SharedPreferences.getInstance();
  final themeModeNotifier = ThemeModeNotifier(pref);
  final pokemonsNotifier = PokemonsNotifier();
  final favoritesNotifier = FavoritesNotifier();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => themeModeNotifier),
        ChangeNotifierProvider(create: (context) => pokemonsNotifier),
        ChangeNotifierProvider(create: (context) => favoritesNotifier),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    /*
    この実装の美味しいところはこの mode に対するアクセスが完全に同期的であり、
    かつその設定値がどこに保存されているのか、どうやって取り出されるのかがすべてブラックボックス化されているところです。
    MaterialApp としては、「ThemeModeNotifier がもっている mode を取得した」という認知しかなく、
    その裏で SharedPreferences が使われているか SQLite か Firebase かといったことはまったく気にしなくて良いのです。
    このような設計は View と Model の切り離しとしてよく知られており、MVVM と呼ばれています。
    これ、とっっっっっても大事です。
    */
    return Consumer<ThemeModeNotifier>(
      builder:
          (context, mode, child) => MaterialApp(
            title: 'Pokemon Flutter',
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: mode.mode,
            home: const TopPage(),
          ),
    );
  }
}

class TopPage extends StatefulWidget {
  const TopPage({super.key});

  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  int currentbnb = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: currentbnb == 0 ? const PokeList() : const Settings(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => {setState(() => currentbnb = index)},
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'home'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'setting'),
        ],
      ),
    );
  }
}

class ThemeModeSelectionPage extends StatefulWidget {
  const ThemeModeSelectionPage({super.key, required this.mode});
  final ThemeMode mode;

  @override
  _ThemeModeSelectionPage createState() => _ThemeModeSelectionPage();
}

class _ThemeModeSelectionPage extends State<ThemeModeSelectionPage> {
  late ThemeMode _current;
  @override
  void initState() {
    super.initState();
    _current = widget.mode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ListTile(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  context.read<ThemeModeNotifier>().update(_current);
                  Navigator.pop(context, _current);
                },
              ),
            ),
            RadioListTile<ThemeMode>(
              value: ThemeMode.system,
              groupValue: _current,
              title: const Text('System'),
              onChanged: (val) => {setState(() => _current = val!)},
            ),
            RadioListTile<ThemeMode>(
              value: ThemeMode.dark,
              groupValue: _current,
              title: const Text('Dark'),
              onChanged: (val) => {setState(() => _current = val!)},
            ),
            RadioListTile<ThemeMode>(
              value: ThemeMode.light,
              groupValue: _current,
              title: const Text('Light'),
              onChanged: (val) => {setState(() => _current = val!)},
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pokemon_flutter/main.dart';
import 'package:pokemon_flutter/utils/theme_mode.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  ThemeMode _themeMode = ThemeMode.system;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.lightbulb),
          title: const Text('Dark/Light Mode'),
          trailing: Text(
            (_themeMode == ThemeMode.system)
                ? 'System'
                : (_themeMode == ThemeMode.dark ? 'Dark' : 'Light'),
          ),
          onTap: () async {
            var ret = await Navigator.of(context).push<ThemeMode>(
              MaterialPageRoute(
                builder: (context) => ThemeModeSelectionPage(mode: _themeMode),
              ),
            );
            setState(() => _themeMode = ret!);
            await saveThemeMode(_themeMode);
          },
        ),
        SwitchListTile(
          title: const Text('Switch'),
          value: true,
          onChanged: (yes) => {},
        ),
        CheckboxListTile(
          title: const Text('Checkbox'),
          value: true,
          onChanged: (yes) => {},
        ),
        RadioListTile(
          title: const Text('Radio'),
          value: true,
          groupValue: true,
          onChanged: (yes) => {},
        ),
      ],
    );
  }
}

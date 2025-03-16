import 'package:flutter/material.dart';

class ViewModeBottomSheet extends StatelessWidget {
  const ViewModeBottomSheet({
    super.key,
    required this.favMode,
    required this.changeFavMode,
    required this.gridMode,
    required this.changeGridMode,
  });
  final bool favMode;
  final Function(bool) changeFavMode;
  final bool gridMode;
  final Function(bool) changeGridMode;
  String mainText(bool fav) {
    return '表示設定';
  }

  String menuFavTitle(bool fav) {
    if (fav) {
      return '「すべて」表示に切り替え';
    } else {
      return '「お気に入り」表示に切り替え';
    }
  }

  String menuFavSubtitle(bool fav) {
    if (fav) {
      return '全てのポケモンが表示されます';
    } else {
      return 'お気に入りに登録したポケモンのみが表示されます';
    }
  }

  String menuGridTitle(bool grid) {
    if (grid) {
      return 'リスト表示に切り替え';
    } else {
      return 'グリッド表示に切り替え';
    }
  }

  String menuGridSubtitle(bool grid) {
    if (grid) {
      return 'ポケモンをグリッド表示します';
    } else {
      return 'ポケモンをリスト表示します';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Center(
        child: Column(
          children: <Widget>[
            Container(
              height: 5,
              width: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Text(
                mainText(favMode),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.swap_horiz),
              title: Text(menuFavTitle(favMode)),
              subtitle: Text(menuFavSubtitle(favMode)),
              onTap: () {
                changeFavMode(favMode);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.grid_3x3),
              title: Text(menuGridTitle(gridMode)),
              subtitle: Text(menuGridSubtitle(gridMode)),
              onTap: () {
                changeGridMode(gridMode);
                Navigator.pop(context);
              },
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              child: const Text('キャンセル'),
              onPressed: () => Navigator.pop(context, false),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:pokemon_flutter/const/db.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/favorite.dart';

class FavoritesDb {
  static Future<Database> openDb() async {
    return await openDatabase(
      join(await getDatabasesPath(), favFileName),
      onCreate: (db, version) {
        return db.execute('CREATE TABLE $favTableName(id INTEGER PRIMARY KEY)');
      },
      version: 1,
    );
  }

  static Future<void> create(Favorite fav) async {
    var db = await openDb();
    await db.insert(
      favTableName,
      fav.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Favorite>> read() async {
    var db = await openDb();
    final List<Map<String, dynamic>> maps = await db.query(favTableName);
    return List.generate(maps.length, (index) {
      return Favorite(pokeId: maps[index]['id']);
    });
  }

  static Future<void> delete(int poleId) async {
    var db = await openDb();
    await db.delete(favTableName, where: 'id = ?', whereArgs: [poleId]);
  }
}

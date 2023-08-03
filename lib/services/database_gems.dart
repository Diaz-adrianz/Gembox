import 'package:gemboxapp/models/gem.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:uuid/uuid.dart';

class DatabaseGems {
  static const String db_name = 'gembox.db';
  static const String table_name = 'gems';

  static Future<List<Gem>> list(String q) async {
    final db = await DatabaseGems.db();
    List<Map<String, dynamic>> raw = await db.query(table_name,
        where: "name LIKE '$q%'", orderBy: 'updated_at');
    List<Gem> data = [];

    raw.forEach((entry) {
      data.add(Gem.fromJson(entry));
    });

    return data;
  }

  static Future<Gem?> get(String id) async {
    final db = await DatabaseGems.db();

    List<Map<String, dynamic>> raw =
        await db.query(table_name, where: "id = ?", whereArgs: [id]);

    if (raw.isEmpty) return null;

    return Gem.fromJson(raw[0]);
  }

  static Future<bool> create(Gem data) async {
    final db = await DatabaseGems.db();

    try {
      Map<String, dynamic> raw = data.toJson();
      final res = await db.insert(table_name, raw,
          conflictAlgorithm: sql.ConflictAlgorithm.replace);

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> update(Gem data) async {
    final db = await DatabaseGems.db();

    try {
      Map<String, dynamic> raw = data.toJson();
      final res = await db
          .update(table_name, raw, where: 'id = ?', whereArgs: [data.id]);
      print(res);

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> delete(String id) async {
    final db = await DatabaseGems.db();

    try {
      final res = await db.delete(table_name, where: 'id = ?', whereArgs: [id]);
      print(res);

      return true;
    } catch (e) {
      print(e);

      return false;
    }
  }

  static Future<sql.Database> db() async {
    return await sql.openDatabase(db_name, version: 2,
        onCreate: (sql.Database db, int version) async {
      await createTables(db);
    });
  }

  // static void dropTable() async {
  //   final sql.Database db = await DatabaseGems.db();
  //   await db.execute('DROP TABLE IF EXISTS $table_name;');
  // }

  static Future<void> createTables(sql.Database db) async {
    await db.execute('''
        CREATE TABLE $table_name (
          id CHAR PRIMARY KEY,
          name VARCHAR NOT NULL,
          identifier VARCHAR NOT NULL,
          secret VARCHAR NOT NULL,
          type VARCHAR NOT NULL,
          imageurl VARCHAR NOT NULL,
          created_at VARCHAR NOT NULL,
          updated_at VARCHAR NOT NULL
       )
    ''');
  }
}

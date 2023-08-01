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

  static Future<sql.Database> db() async {
    return await sql.openDatabase(db_name, version: 1,
        onCreate: (sql.Database db, int version) async {
      await createTables(db);
    });
  }

  static Future<void> createTables(sql.Database db) async {
    await db.execute('''
        CREATE TABLE $table_name(
        id CHAR PRIMARY KEY,
        name VARCHAR NOT NULL,
        secret VARCHAR NOT NULL,
        type VARCHAR NOT NULL,
        imageurl VARCHAR NOT NULL,
        created_at VARCHAR NOT NULL,
        updated_at VARCHAR NOT NULL
       )
    ''');
  }
}

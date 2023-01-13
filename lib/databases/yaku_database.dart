import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;

class YakuDatabase {
  static Future<void> createYakuTables(sql.Database database) async {
    await database.execute('''
  CREATE TABLE yaku(
    id INTEGER,
    yaku TEXT,
    point INTEGER,
  )
  ''');
  }

  static Future<sql.Database> yakuDb() async {
    return sql.openDatabase(
      'yaku.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createYakuTables(database);
      },
    );
  }

  // read all items
  static Future<List<Map<String, dynamic>>> getMemberItems() async {
    final db = await YakuDatabase.yakuDb();
    return db.query('yaku');
  }

  // Update an item by id
  static Future<int> updateMemberItem({
    required int id,
    required String yaku,
    required int point,
  }) async {
    final db = await YakuDatabase.yakuDb();

    final data = {
      'id': id,
      'yaku': yaku,
      'point': point,
    };

    final result = await db.update(
      'yaku',
      data,
    );

    return result;
  }
}

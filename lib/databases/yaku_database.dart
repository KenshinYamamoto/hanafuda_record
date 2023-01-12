import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;

class YakuDatabase {
  static Future<void> createYakuTables(sql.Database database) async {
    await database.execute('''
  CREATE TABLE yaku(
  gokou INTEGER,
  amesikou INTEGER,
  sikou INTEGER,
  sankou INTEGER,
  ino INTEGER,
  akaao INTEGER,
  aka INTEGER,
  ao INTEGER,
  tukimi INTEGER,
  hanami INTEGER,
  tane INTEGER,
  tan INTEGER,
  kasu INTEGER,
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
    required int gokou,
    required int amesikou,
    required int sikou,
    required int sankou,
    required int ino,
    required int akaao,
    required int aka,
    required int ao,
    required int tukimi,
    required int hanami,
    required int tane,
    required int tan,
    required int kasu,
  }) async {
    final db = await YakuDatabase.yakuDb();

    final data = {
      'gokou': gokou,
      'amesikou': amesikou,
      'sikou': sikou,
      'sankou': sankou,
      'ino': ino,
      'akaao': akaao,
      'aka': aka,
      'ao': ao,
      'tukimi': tukimi,
      'hanami': hanami,
      'tane': tane,
      'tan': tan,
      'kasu': kasu,
    };

    final result = await db.update(
      'yaku',
      data,
    );

    return result;
  }
}

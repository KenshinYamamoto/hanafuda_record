import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;

class MonthDatabase {
  static Future<void> createMonthTables(
    sql.Database database,
    String month,
  ) async {
    await database.execute('''
  CREATE TABLE $month(
  id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
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
  createAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
  )
  ''');
  }

  static Future<sql.Database> monthDb(String month) async {
    return sql.openDatabase(
      '$month.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createMonthTables(database, month);
      },
    );
  }

  // create new item
  static Future<int> createItem({
    required String month,
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
    final db = await MonthDatabase.monthDb(month);

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
    final id = await db.insert(
      month, // テーブル名
      data, // insertする値
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
    return id;
  }

  // read all items
  static Future<List<Map<String, dynamic>>> getMemberItems(String month) async {
    final db = await MonthDatabase.monthDb(month);
    return db.query(
      month,
      orderBy: 'id',
    );
  }

  // read a single item by id
  static Future<List<Map<String, dynamic>>> getItem(
    String month,
    int id,
  ) async {
    final db = await MonthDatabase.monthDb(month);
    return db.query(
      month,
      where: 'id=?',
      whereArgs: [id],
      limit: 1,
    );
  }

  // Update an item by id
  static Future<int> updateMemberItem({
    required int id,
    required String month,
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
    final db = await MonthDatabase.monthDb(month);

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
      'createAt': DateTime.now().toString(),
    };

    final result = await db.update(
      month,
      data,
      where: 'id=?',
      whereArgs: [id],
    );

    return result;
  }

  // delete
  static Future<void> deleteItem(String month, int id) async {
    final db = await MonthDatabase.monthDb(month);

    try {
      await db.delete(
        month,
        where: 'id=?',
        whereArgs: [id],
      );
    } catch (err) {
      debugPrint('Something went wrong when deleting an item: $err');
    }
  }
}

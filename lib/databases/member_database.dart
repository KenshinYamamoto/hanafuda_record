import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;

class MemberDatabase {
  static Future<void> createMemberTables(sql.Database database) async {
    await database.execute('''
  CREATE TABLE members(
  id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  one TEXT NOT NULL,
  two TEXT NOT NULL,
  three TEXT,
  four TEXT,
  oneTotal INTEGER NOT NULL,
  twoTotal INTEGER NOT NULL,
  threeTotal INTEGER,
  fourTotal INTEGER,
  createAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
  )
  ''');
  }

  static Future<sql.Database> memberDb() async {
    return sql.openDatabase(
      'member.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createMemberTables(database);
      },
    );
  }

  // create new item
  static Future<int> createItem({
    required String one,
    required String two,
    String? three,
    String? four,
    required int oneTotal,
    required int twoTotal,
    int? threeTotal,
    int? fourTotal,
  }) async {
    final db = await MemberDatabase.memberDb();

    final data = {
      'one': one,
      'two': two,
      'three': three,
      'four': four,
      'oneTotal': oneTotal,
      'twoTotal': twoTotal,
      'threeTotal': threeTotal,
      'fourTotal': fourTotal,
    };
    final id = await db.insert(
      'members', // テーブル名
      data, // insertする値
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
    return id;
  }

  // read all items
  static Future<List<Map<String, dynamic>>> getMemberItems() async {
    final db = await MemberDatabase.memberDb();
    return db.query(
      'members',
      orderBy: 'id',
    );
  }

  // read a single item by id
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await MemberDatabase.memberDb();
    return db.query(
      'members',
      where: 'id=?',
      whereArgs: [id],
      limit: 1,
    );
  }

  // Update an item by id
  static Future<int> updateMemberItem({
    required int id,
    required String one,
    required String two,
    String? three,
    String? four,
    required int oneTotal,
    required int twoTotal,
    int? threeTotal,
    int? fourTotal,
  }) async {
    final db = await MemberDatabase.memberDb();

    final data = {
      'one': one,
      'two': two,
      'three': three,
      'four': four,
      'oneTotal': oneTotal,
      'twoTotal': twoTotal,
      'threeTotal': threeTotal,
      'fourTotal': fourTotal,
      'createAt': DateTime.now().toString(),
    };

    final result = await db.update(
      'members',
      data,
      where: 'id=?',
      whereArgs: [id],
    );

    return result;
  }

  // delete
  static Future<void> deleteItem(int id) async {
    final db = await MemberDatabase.memberDb();

    try {
      await db.delete(
        'members',
        where: 'id=?',
        whereArgs: [id],
      );
    } catch (err) {
      debugPrint('Something went wrong when deleting an item: $err');
    }
  }
}

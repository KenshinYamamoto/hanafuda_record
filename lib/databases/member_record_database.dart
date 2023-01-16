import 'dart:async';

import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;

class MemberRecordDatabase {
  static Future<void> createTables(sql.Database database) async {
    await database.execute('''
  CREATE TABLE records(
  id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  member1 TEXT NOT NULL,
  member2 TEXT NOT NULL,
  member3 TEXT,
  member4 TEXT,
  member1Total INTEGER NOT NULL,
  member2Total INTEGER NOT NULL,
  member3Total INTEGER,
  member4Total INTEGER,
  createAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
  )
  ''');
  }

  static Future<sql.Database> recordDb() async {
    return sql.openDatabase(
      'record.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // create new item
  static Future<int> createRecordItem({
    required String member1,
    required String member2,
    String? member3,
    String? member4,
    required int member1Total,
    required int member2Total,
    int? member3Total,
    int? member4Total,
  }) async {
    final db = await MemberRecordDatabase.recordDb();

    final data = {
      'member1': member1,
      'member2': member2,
      'member3': member3,
      'member4': member4,
      'member1Total': member1Total,
      'member2Total': member2Total,
      'member3Total': member3Total,
      'member4Total': member4Total,
    };
    final id = await db.insert(
      'records', // テーブル名
      data, // insertする値
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
    return id;
  }

  // read all items
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await MemberRecordDatabase.recordDb();

    return db.query(
      'records',
      orderBy: 'id',
    );
  }

  // read a single item by id
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await MemberRecordDatabase.recordDb();

    return db.query(
      'records',
      where: 'id=?',
      whereArgs: [id],
      limit: 1,
    );
  }

  // Update an item by id
  static Future<int> updateItem({
    required int id,
    required String member1,
    required String member2,
    String? member3,
    String? member4,
    required int member1Total,
    required int member2Total,
    int? member3Total,
    int? member4Total,
  }) async {
    final db = await MemberRecordDatabase.recordDb();
    initializeDateFormatting('ja_JP');

    final data = {
      'member1': member1,
      'member2': member2,
      'member3': member3,
      'member4': member4,
      'member1Total': member1Total,
      'member2Total': member2Total,
      'member3Total': member3Total,
      'member4Total': member4Total,
      'createAt': DateTime.now().toLocal().toString(),
    };

    final result = await db.update(
      'records',
      data,
      where: 'id=?',
      whereArgs: [id],
    );

    return result;
  }

  // delete
  static Future<void> deleteItem(int id) async {
    final db = await MemberRecordDatabase.recordDb();

    // return db.execute('''delete from sqlite_sequence where name='records';''');

    try {
      await db.delete(
        'records',
        where: 'id=?',
        whereArgs: [id],
      );
    } catch (err) {
      debugPrint('Something went wrong when deleting an item: $err');
    }
  }

  static Future<void> deleteItems() async {
    final db = await MemberRecordDatabase.recordDb();

    // return db.execute('''delete from sqlite_sequence where name='records';''');

    try {
      await db.delete(
        'records',
      );
    } catch (err) {
      debugPrint('Something went wrong when deleting an item: $err');
    }
  }
}

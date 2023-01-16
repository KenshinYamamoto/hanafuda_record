import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;

class MonthWinnerDatabase {
  static Future<void> createTables(sql.Database database) async {
    await database.execute('''
  CREATE TABLE winner(
  id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  january TEXT NOT NULL,
  february TEXT NOT NULL,
  march TEXT NOT NULL,
  april TEXT NOT NULL,
  may TEXT NOT NULL,
  june TEXT NOT NULL,
  july TEXT NOT NULL,
  august TEXT NOT NULL,
  september TEXT NOT NULL,
  october TEXT NOT NULL,
  november TEXT NOT NULL,
  december TEXT NOT NULL
  )
  ''');
  }

  static Future<sql.Database> monthWinnerDb() async {
    return sql.openDatabase(
      'winners.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // create new item
  static Future<int> createMonthWinnerItem({
    required String january,
    required String february,
    required String march,
    required String april,
    required String may,
    required String june,
    required String july,
    required String august,
    required String september,
    required String october,
    required String november,
    required String december,
  }) async {
    final db = await MonthWinnerDatabase.monthWinnerDb();

    final data = {
      'january': january,
      'february': february,
      'march': march,
      'april': april,
      'may': may,
      'june': june,
      'july': july,
      'august': august,
      'september': september,
      'october': october,
      'november': november,
      'december': december,
    };
    final id = await db.insert(
      'winner', // テーブル名
      data, // insertする値
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
    return id;
  }

  // read all items
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await MonthWinnerDatabase.monthWinnerDb();

    return db.query(
      'winner',
      orderBy: 'id',
    );
  }

  // read a single item by id
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await MonthWinnerDatabase.monthWinnerDb();

    return db.query(
      'winner',
      where: 'id=?',
      whereArgs: [id],
      limit: 1,
    );
  }

  // Update an item by id
  static Future<int> updateItem({
    required int id,
    required String january,
    required String february,
    required String march,
    required String april,
    required String may,
    required String june,
    required String july,
    required String august,
    required String september,
    required String october,
    required String november,
    required String december,
  }) async {
    final db = await MonthWinnerDatabase.monthWinnerDb();

    final data = {
      'january': january,
      'february': february,
      'march': march,
      'april': april,
      'may': may,
      'june': june,
      'july': july,
      'august': august,
      'september': september,
      'october': october,
      'november': november,
      'december': december,
    };

    final result = await db.update(
      'winner',
      data,
      where: 'id=?',
      whereArgs: [id],
    );

    return result;
  }

  // delete
  static Future<void> deleteItem(int id) async {
    final db = await MonthWinnerDatabase.monthWinnerDb();

    // return db.execute('''delete from sqlite_sequence where name='records';''');

    try {
      await db.delete(
        'winner',
        where: 'id=?',
        whereArgs: [id],
      );
    } catch (err) {
      debugPrint('Something went wrong when deleting an item: $err');
    }
  }

  static Future<void> deleteItems() async {
    final db = await MonthWinnerDatabase.monthWinnerDb();

    // return db.execute('''delete from sqlite_sequence where name='records';''');

    try {
      await db.delete(
        'winner',
      );
    } catch (err) {
      debugPrint('Something went wrong when deleting an item: $err');
    }
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;

class MonthPointDatabase {
  static Future<void> createTables(sql.Database database) async {
    await database.execute('''
  CREATE TABLE point(
  id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  january INTEGER NOT NULL,
  february INTEGER NOT NULL,
  march INTEGER NOT NULL,
  april INTEGER NOT NULL,
  may INTEGER NOT NULL,
  june INTEGER NOT NULL,
  july INTEGER NOT NULL,
  august INTEGER NOT NULL,
  september INTEGER NOT NULL,
  october INTEGER NOT NULL,
  november INTEGER NOT NULL,
  december INTEGER NOT NULL
  )
  ''');
  }

  static Future<sql.Database> monthPointDb() async {
    return sql.openDatabase(
      'points.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // create new item
  static Future<int> createMonthWinnerItem({
    required int january,
    required int february,
    required int march,
    required int april,
    required int may,
    required int june,
    required int july,
    required int august,
    required int september,
    required int october,
    required int november,
    required int december,
  }) async {
    final db = await MonthPointDatabase.monthPointDb();

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
      'point', // テーブル名
      data, // insertする値
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
    return id;
  }

  // read all items
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await MonthPointDatabase.monthPointDb();

    return db.query(
      'point',
      orderBy: 'id',
    );
  }

  // read a single item by id
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await MonthPointDatabase.monthPointDb();

    return db.query(
      'point',
      where: 'id=?',
      whereArgs: [id],
      limit: 1,
    );
  }

  // Update an item by id
  static Future<int> updateItem({
    required int id,
    required int january,
    required int february,
    required int march,
    required int april,
    required int may,
    required int june,
    required int july,
    required int august,
    required int september,
    required int october,
    required int november,
    required int december,
  }) async {
    final db = await MonthPointDatabase.monthPointDb();

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
      'point',
      data,
      where: 'id=?',
      whereArgs: [id],
    );

    return result;
  }

  // delete
  static Future<void> deleteItem(int id) async {
    final db = await MonthPointDatabase.monthPointDb();

    // return db.execute('''delete from sqlite_sequence where name='records';''');

    try {
      await db.delete(
        'point',
        where: 'id=?',
        whereArgs: [id],
      );
    } catch (err) {
      debugPrint('Something went wrong when deleting an item: $err');
    }
  }

  static Future<void> deleteItems() async {
    final db = await MonthPointDatabase.monthPointDb();

    // return db.execute('''delete from sqlite_sequence where name='records';''');

    try {
      await db.delete(
        'point',
      );
    } catch (err) {
      debugPrint('Something went wrong when deleting an item: $err');
    }
  }
}

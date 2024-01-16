// methods

import 'dart:developer';
import 'dart:io';
import 'package:karate_app/domain/entities/kata.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

class SqliteProvider {
  static Database? _database;
  final String dbName = 'karate_app.db';

  Future<void> initializeDatabase() async {
    // Get the application documents directory
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);

    // Check if the database exists
    bool exists = await databaseExists(path);

    if (!exists) {
      log("Database not created, initialising from assets root");
      // If the database does not exist, copy it from the assets folder
      await _copyDatabaseFromAssets(path);
    }

    // Open the database
    _database = await openDatabase(path);
  }

  Future<List<Map<String, dynamic>>?> getAllKatas() async {
    return await _database?.query('katas');
  }

  Future<void> _copyDatabaseFromAssets(String path) async {
    // Copy the database from the assets folder
    ByteData data = await rootBundle.load('karate_app.db');
    List<int> bytes = data.buffer.asUint8List();
    await File(path).writeAsBytes(bytes);
  }

  Future<Database?> get database async {
    if(_database == null) {
      await initializeDatabase();
    }
    return _database;
  }

  Future<void> updateKata(Kata kata) async {
      String? kataName = kata.name;
      String selected = kata.selected == true ? 'true' : 'false';
      var data = await _database?.rawUpdate(
        'UPDATE katas SET selected=? WHERE name=?',
        [kata.selected, kata.name]);
      log('updated $kataName with value $selected');
  }
  
}

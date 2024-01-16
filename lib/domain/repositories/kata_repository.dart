import 'dart:convert';
import 'dart:io';
import 'package:karate_app/infrastructure/sqlite_provider.dart';

import '../entities/kata.dart';
import 'package:path_provider/path_provider.dart';

class KataRepository {
  final SqliteProvider _sqliteProvider = SqliteProvider();

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/data/katas.json');
  }


  Future<List<Kata>> getAllKatas() async {
    try {
      var dbResult = await _sqliteProvider.getAllKatas();
      if(dbResult == null || dbResult.length == 0) {
        throw Exception("No Data in Katas table");
      }
      List<Kata> allKatas = List.generate(dbResult.length, (index) => Kata.fromJson(dbResult[index]));
      return allKatas;
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<List<Kata>> getAllSelectedKatas() async {
    final allKatas = await getAllKatas();
    return allKatas.where((kata) => kata.selected == true).toList();
  }

  Future<void> update(Kata kata) async {
    try {
      await _sqliteProvider.updateKata(kata);      
    } catch(error) {
      throw Exception(error);
    }
  }
}
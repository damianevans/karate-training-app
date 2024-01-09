import 'dart:convert';
import '../entities/kata.dart';
import 'package:flutter/services.dart';

class KataRepository {
  Future<List<Kata>> getAllKatas() async {
    try {
      final result = await readJsonFile();
      return result;
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<List<Kata>> getAllSelectedKatas() async {
    final allKatas = await getAllKatas();
    return allKatas.where((kata) => kata.selected == true).toList();
  }

  Future<List<Kata>> readJsonFile() async {
    try {
      final kataJson = await rootBundle.loadString('assets/katas.json');
      return (json.decode(kataJson) as List).map((item) => Kata.fromJson(item)).toList();
    } catch (error) {
      throw Exception(error);
    }
  }
}
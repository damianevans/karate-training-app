import 'dart:math';

import '../domain/entities/kata.dart';
import '../domain/repositories/kata_repository.dart';
import '../infrastructure/sqlite_provider.dart';

class KataService {
  final _random = Random();
  final KataRepository _kataRepository;
  final SqliteProvider _sqliteProvider = new SqliteProvider();
  List<Kata> _selectedKatas = [];

  KataService(this._kataRepository);

  Future<Kata> getRandomKata() async {
    if (_selectedKatas.isEmpty) {
      _selectedKatas = (await _kataRepository.getAllSelectedKatas()).cast<Kata>();
    }
    int max = _selectedKatas.length;
    int min = 0;
    int rnd = min + _random.nextInt(max - min);

    return _selectedKatas[rnd];
  }

  Future<List<Kata>> getAllKatas() async {
    return await _kataRepository.getAllKatas();
  }

  Future<void> updateKata(Kata kata) async {
    await _kataRepository.update(kata);
    _selectedKatas = (await _kataRepository.getAllSelectedKatas()).cast<Kata>();
  }

  Future<void> initialiseDatabase() async {
    await _sqliteProvider.initializeDatabase();
  }
}
import 'dart:math';

import '../domain/entities/kata.dart';
import '../domain/repositories/kata_repository.dart';

class KataService {
  final _random = Random();
  final KataRepository _kataRepository;
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
}
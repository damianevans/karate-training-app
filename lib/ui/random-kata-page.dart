import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:karate_app/main.dart';

import '../application/kata_service.dart';
import '../domain/entities/kata.dart';

class RandomKataPage extends StatefulWidget {
  final KataService _kataService;
  RandomKataPage(this._kataService);
  
  @override
  State<StatefulWidget> createState() => _RandomKataPage(_kataService);
}

class _RandomKataPage extends State<RandomKataPage> {
 final KataService _kataService;
  Kata _currentKata = Kata();
  
  _RandomKataPage(this._kataService);

  void selectKata() async {
    // Fetch the random kata asynchronously
    final randomKata = await _kataService.getRandomKata();

    setState(() {
      // Update _currentKata with the fetched value
      _currentKata = randomKata as Kata;
    });
  }

  Future<void> _loadInitialKata() async {
    // Fetch the initial random kata
    final randomKata = await _kataService.getRandomKata();

    setState(() {
      _currentKata = randomKata as Kata;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadInitialKata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Kata Selector'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget> [
                Padding(padding: EdgeInsets.all(15.0), 
                child: 
                  AutoSizeText('${_currentKata.name}',
                        style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                        maxLines: 2,
                      ) 
                    ),               
              ]
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 0, 0, 15),
                    child: Text(_currentKata.kanji ?? '',
                        style: Theme.of(context).textTheme.headlineMedium),
                  ),
                ]), 
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: 
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        _currentKata.description ?? '',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    )
              ),

              ],
            )       
          ],
      ),
            
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: selectKata,
        tooltip: 'Next Random Kata',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

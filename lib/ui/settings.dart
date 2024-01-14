import 'package:flutter/material.dart';

import '../application/kata_service.dart';
import '../domain/entities/kata.dart';

class SettingsPage extends StatefulWidget {
  final KataService _kataService;

  SettingsPage(this._kataService);

  @override
  State<StatefulWidget> createState() => _SettingsPage(_kataService);
}

class _SettingsPage extends State<SettingsPage> {
  final KataService _kataService;
  List<Kata> _allKatas = [];

  _SettingsPage(this._kataService);
  
  Future<void> _loadKatas() async {
    // Fetch the initial random kata
    final allKatas = await _kataService.getAllKatas();

    setState(() {
      _allKatas = allKatas;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadKatas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Container(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: _allKatas.length,
            itemBuilder: (context , index){
            return Card(
              elevation: 8.0,
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(64, 75, 96, 0.9),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  leading: Container(
                    padding: EdgeInsets.only(right: 12.0),
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(width: 1.0, color: Colors.white24),
                      ),
                    ),
                    child: Icon(Icons.autorenew, color: Colors.white,),
                  ),
                  title: Text(_allKatas[index].name ?? '<missing title>',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                  subtitle: Row(
                    children: [
                      // Icon(Icons.linear_scale, color: Colors.yellowAccent,),
                      // Text(" Intermediate", style: TextStyle(color: Colors.white),)
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: EdgeInsets.only(left: 0.0),
                          child: Text(_allKatas[index].kanji ?? '', style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    ],
                  ),
                  trailing: Switch(
                    value: _allKatas[index].selected ?? true,
                    onChanged: (selected) async => {
                      setState(() => _allKatas[index].selected = selected,),
                      await _kataService.updateKata(_allKatas[index]),
                  },),
                ),
              ),
            );
            }),
      ),
    );
  }
}

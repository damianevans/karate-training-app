import 'package:flutter/material.dart';

import 'application/kata_service.dart';
import 'domain/repositories/kata_repository.dart';
import 'ui/kihon-drills.dart';
import 'ui/kumite-drills.dart';
import 'ui/random-kata-page.dart';
import 'ui/settings.dart';
import 'ui/videos.dart';

void main() {
  runApp(MyKarateTrainingApp());
}

class MyKarateTrainingApp extends StatelessWidget {
  final KataService _kataService = KataService(KataRepository());

  MyKarateTrainingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Karate Training App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(_kataService),
      routes: {
        '/randomKata': (context) => RandomKataPage(_kataService),
        '/kihonDrills': (context) => KihonDrillsPage(),
        '/kumiteDrills': (context) => KumiteDrillsPage(),
        '/videos': (context) => VideosPage(),
        '/settings': (context) => SettingsPage(_kataService),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  final KataService _kataService;
  const HomePage(this._kataService, {super.key});

    @override
    _HomePageState createState() => _HomePageState(_kataService);
}

class _HomePageState extends State<HomePage> {

  final KataService _kataService;
  
  _HomePageState(this._kataService);

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    await _kataService.initialiseDatabase();

  }



    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Karate App'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          buildGridItem(context, 'Random Kata', Icons.star, '/randomKata'),
          buildGridItem(
              context, 'Kihon Drills', Icons.fitness_center, '/kihonDrills'),
          buildGridItem(
              context, 'Kumite Drills', Icons.sports_mma, '/kumiteDrills'),
          buildGridItem(context, 'Videos', Icons.video_library, '/videos'),
          buildGridItem(context, 'Settings', Icons.settings, '/settings'),
        ],
      ),
    );

  
  }
  
    Widget buildGridItem(
      BuildContext context, String title, IconData icon, String route) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Card(
        margin: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 50.0),
            SizedBox(height: 10.0),
            Text(title, style: TextStyle(fontSize: 18.0)),
          ],
        ),
      ),
    );
  }
}
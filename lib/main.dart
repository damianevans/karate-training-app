import 'package:flutter/material.dart';

import 'application/kata_service.dart';
import 'domain/repositories/kata_repository.dart';
import 'ui/random-kata-page.dart';

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
      home: HomePage(),
      routes: {
        '/randomKata': (context) => RandomKataPage(_kataService),
        '/kihonDrills': (context) => KihonDrillsPage(),
        '/kumiteDrills': (context) => KumiteDrillsPage(),
        '/videos': (context) => VideosPage(),
        '/settings': (context) => SettingsPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Karate App'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          _buildGridItem(context, 'Random Kata', Icons.star, '/randomKata'),
          _buildGridItem(
              context, 'Kihon Drills', Icons.fitness_center, '/kihonDrills'),
          _buildGridItem(
              context, 'Kumite Drills', Icons.sports_mma, '/kumiteDrills'),
          _buildGridItem(context, 'Videos', Icons.video_library, '/videos'),
          _buildGridItem(context, 'Settings', Icons.settings, '/settings'),
        ],
      ),
    );
  }

  Widget _buildGridItem(
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

class KihonDrillsPage extends StatelessWidget {
  const KihonDrillsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Kihon Drills')),
      body: Center(child: Text('Kihon Drills Page')),
    );
  }
}

class KumiteDrillsPage extends StatelessWidget {
  const KumiteDrillsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Kumite Drills')),
      body: Center(child: Text('Kumite Drills Page')),
    );
  }
}

class VideosPage extends StatelessWidget {
  const VideosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Videos')),
      body: Center(child: Text('Videos Page')),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Center(child: Text('Settings Page')),
    );
  }
}

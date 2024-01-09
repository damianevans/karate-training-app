import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Karate App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
      routes: {
        '/randomKata': (context) => RandomKataPage(),
        '/kihonDrills': (context) => KihonDrillsPage(),
        '/kumiteDrills': (context) => KumiteDrillsPage(),
        '/videos': (context) => VideosPage(),
        '/settings': (context) => SettingsPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
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

// Dummy pages for demonstration purposes
class RandomKataPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Random Kata')),
      body: Center(child: Text('Random Kata Page')),
    );
  }
}

class KihonDrillsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Kihon Drills')),
      body: Center(child: Text('Kihon Drills Page')),
    );
  }
}

class KumiteDrillsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Kumite Drills')),
      body: Center(child: Text('Kumite Drills Page')),
    );
  }
}

class VideosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Videos')),
      body: Center(child: Text('Videos Page')),
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Center(child: Text('Settings Page')),
    );
  }
}

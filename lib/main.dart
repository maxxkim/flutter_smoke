import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  var favorites = <WordPair>[];
  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0; // ← Add this property.

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
        break;
      case 2:
        page = ContactsPage();
        break;
      case 1:
        page = AchievementsPage();
        break;
      case 3:
        page = MotivationPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: constraints.maxWidth >= 600,
                destinations: [
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.done),
                    label: Text('My Achievements'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.chat),
                    label: Text('Chats'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.sunny),
                    label: Text('Motivation'),
                  ),
                ],
                selectedIndex: selectedIndex, // ← Change to this.
                onDestinationSelected: (value) {
                  // ↓ Replace print with this.
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ),
            ),
          ],
        ),
      );
    });
  }
}

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.share;
    } else {
      icon = Icons.share;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("You havent't been smoking for"),
          SizedBox(height: 10),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "2 months 14 days 3 hours and 14 minutes",
                semanticsLabel: pair.asPascalCase,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text('This also means'),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "76 packs",
                    semanticsLabel: pair.asPascalCase,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Text('or'),
              SizedBox(width: 10),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "248 \$",
                    semanticsLabel: pair.asPascalCase,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite();
                },
                icon: Icon(icon),
                label: Text('Share'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  appState.getNext();
                },
                child: Text('Edit'),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text('Your next goal is not to smoke for'),
          SizedBox(height: 10),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "14 days 20 hours and 46 minutes",
                semanticsLabel: pair.asPascalCase,
              ),
            ),
          ),
          SizedBox(height: 20),
          Text('Good luck!'),
        ],
      ),
    );
  }
}

class AchievementsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView(
        children: [
          Text('Your stats for today'),
          SizedBox(height: 10),
          Text('Cigarettes smoked:'),
          SizedBox(height: 10),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "You did not smoke!",
              ),
            ),
          ),
          SizedBox(height: 10),
          Text('Cravings felt:'),
          SizedBox(height: 10),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "2",
              ),
            ),
          ),
          SizedBox(height: 10),
          Text('Goals available:'),
          SizedBox(height: 10),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Your lungs are way cleaner now!",
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ContactsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Card(
          child: ListTile(
            leading: Image.asset("assets/images/joseph.jpeg"),
            title: Text('Joseph Mengele'),
            subtitle: Text('Your psychiatrist'),
            trailing: Icon(Icons.more_vert),
          ),
        ),
        Card(
          child: ListTile(
            leading: Image.asset('assets/images/edvard.jpg'),
            title: Text('Edward Elric'),
            subtitle: Text('Friend'),
            trailing: Icon(Icons.more_vert),
          ),
        ),
        Card(
          child: ListTile(
            leading: Image.asset('assets/images/alina.jpeg'),
            title: Text('Alina Fox'),
            subtitle: Text('Friend'),
            trailing: Icon(Icons.more_vert),
          ),
        ),
      ],
    );
  }
}

class MotivationPage extends StatefulWidget {
  @override
  State<MotivationPage> createState() => _MotivationPageState();
}

class _MotivationPageState extends State<MotivationPage> {
  late VideoPlayerController _controller;
  @override
  void initState() {
    _controller = VideoPlayerController.asset("assets/images/doit.mp4")
      ..initialize().then((_) {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _controller.value.initialized
          ? VideoPlayer(_controller)
          : Container(),
      floatingActionButton: FloatingActionButton(
          child: Icon(
              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
          onPressed: () {
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
          }),
    );
  }

  /* Widget content(BuildContext context) {
    return Center(
      child: Container(
        width: 350,
        height: 350,
        child: _controller.value.initialized
            ? VideoPlayer(_controller)
            : Container(),
      ),
    );
  }*/
}

class BigCard extends StatelessWidget {
  const BigCard({
    Key? key,
    required this.pair,
  }) : super(key: key);

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var style = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          "2 months 14 days 3 hours and 14 minutes",
          style: style,
          semanticsLabel: pair.asPascalCase,
        ),
      ),
    );
  }
}

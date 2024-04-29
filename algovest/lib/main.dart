import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'screens/screen_one.dart';
import 'screens/screen_two.dart';
import 'screens/screen_three.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PortfoliBro Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueGrey, // Sets the core palette
          primary: Color(0xFF1a237e), // Deep blue
          secondary: Color(0xFF64b5f6), // Light blue
          tertiary: Color(0xFFd32f2f), // Red for negative indicators
          onTertiary: Colors.white,
        ),
        useMaterial3: true, // Enable Material 3 features
        scaffoldBackgroundColor: Color(0xFFe8eaf6), // Light background color
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.black87),
          bodyText2: TextStyle(color: Colors.black87),
        ),
        appBarTheme: AppBarTheme(
          color: Color(0xFF1a237e), // Matching the primary color
          foregroundColor: Colors.white, // For title and icons
        ),
        iconTheme: IconThemeData(
          color: Color(0xFF1a237e),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF64b5f6),
          foregroundColor: Colors.white,
        ),
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.all(Color(0xFF64b5f6)),
          trackColor: MaterialStateProperty.all(Color(0xFFbbdefb)),
        ),
      ),
      home: const MyHomePage(title: 'PortfoliBro Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  // List of the pages to switch between
  final List<Widget> _pages = [
  ScreenOne(),
    ScreenTwo(),
    ScreenThree()// Make sure this is the correct screen class
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Portfolio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Analysis',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
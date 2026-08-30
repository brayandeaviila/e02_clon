import 'package:flutter/material.dart';

void main() {
  runApp(const RumbaApp());
}

class RumbaApp extends StatelessWidget {
  const RumbaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rumba',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const RumbaHomePage(),
    );
  }
}

class RumbaHomePage extends StatefulWidget {
  const RumbaHomePage({super.key});

  @override
  State<RumbaHomePage> createState() => _RumbaHomePageState();
}

class _RumbaHomePageState extends State<RumbaHomePage> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    Center(
      child: Text(
        'Inicio',
        style: TextStyle(fontSize: 32),
      ),
    ),
    Center(
      child: Text(
        'Mis Beats',
        style: TextStyle(fontSize: 32),
      ),
    ),
    Center(
      child: Text(
        'Mi Perfil',
        style: TextStyle(fontSize: 32),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWideScreen = constraints.maxWidth >= 700;

        if (isWideScreen) {
          return Scaffold(
            body: Row(
              children: [
                NavigationRail(
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  labelType: NavigationRailLabelType.all,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                      label: Text('Inicio'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.music_note_outlined),
                      selectedIcon: Icon(Icons.music_note),
                      label: Text('Beats'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.person_outline),
                      selectedIcon: Icon(Icons.person),
                      label: Text('Perfil'),
                    ),
                  ],
                ),
                const VerticalDivider(thickness: 1, width: 1),
                Expanded(
                  child: pages[selectedIndex],
                ),
              ],
            ),
          );
        }

        return Scaffold(
          body: pages[selectedIndex],
          bottomNavigationBar: NavigationBar(
            selectedIndex: selectedIndex,
            onDestinationSelected: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Inicio',
              ),
              NavigationDestination(
                icon: Icon(Icons.music_note_outlined),
                selectedIcon: Icon(Icons.music_note),
                label: 'Beats',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person),
                label: 'Perfil',
              ),
            ],
          ),
        );
      },
    );
  }
}
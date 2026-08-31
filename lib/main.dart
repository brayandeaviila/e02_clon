import 'package:flutter/material.dart';
import 'package:battery_plus/battery_plus.dart';

void main() {
  runApp(const RumbaApp());
}

class BatteryService {
  final Battery battery = Battery();

  Future<int> getBatteryLevel() {
    return battery.batteryLevel;
  }

  Future<BatteryState> getBatteryState() {
    return battery.batteryState;
  }
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
  HomePage(),
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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final BatteryService batteryService = BatteryService();
  

  int batteryLevel = 0;
  BatteryState batteryState = BatteryState.unknown;

  @override
  void initState() {
    super.initState();
    loadBatteryData();
  }

  Future<void> loadBatteryData() async {
    final level = await batteryService.getBatteryLevel();
    final state = await batteryService.getBatteryState();

    if (!mounted) return;

    setState(() {
      batteryLevel = level;
      batteryState = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isCharging =
        batteryState == BatteryState.charging ||
        batteryState == BatteryState.full;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rumba'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Feed',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Encuentra los artistas y beats destacados.',
            ),
            const SizedBox(height: 32),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Icon(
                      isCharging
                          ? Icons.battery_charging_full
                          : Icons.battery_std,
                      size: 40,
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Estado batería',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text('$batteryLevel%'),
                        Text(
                          isCharging ? 'Cargando' : 'No está cargando',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
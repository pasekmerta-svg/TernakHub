import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/livestock_provider.dart';
import 'services/supabase_service.dart';
import 'screens/home_screen.dart';
import 'screens/livestock_list_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseService.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LivestockProvider()..fetchCatalog()..fetchSavedItems()),
      ],
      child: const TernakHubApp(),
    ),
  );
}

class TernakHubApp extends StatelessWidget {
  const TernakHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TernakHub Buleleng',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const LivestockListScreen(),
    const FavoritesScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Katalog'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Incaran'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}
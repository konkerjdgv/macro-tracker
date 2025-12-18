import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart';
import 'screens/add_food_screen.dart';
import 'screens/summary_screen.dart';
import 'screens/history_screen.dart';
import 'screens/settings_screen.dart';
import 'logic/storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.loadDailyIntake(); // Carga datos guardados
  runApp(const MyFoodApp());
}

class MyFoodApp extends StatelessWidget {
  const MyFoodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Food App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const DashboardScreen(),
        '/add-food': (context) => const AddFoodScreen(),
        '/summary': (context) => const SummaryScreen(),
        '/history': (context) => const HistoryScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}

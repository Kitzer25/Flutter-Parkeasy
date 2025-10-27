import 'package:flutter/material.dart';
import 'backend/models/supabase_flutter.dart';
import 'frontend/screens/welcome_screen.dart';
import 'frontend/screens/login_screen.dart';
import 'frontend/screens/register_screen.dart';
import 'frontend/screens/home_screen.dart';
import 'frontend/screens/dashboard_screen.dart';
import 'frontend/screens/map_screen.dart'; // ✅ importa la nueva pantalla del mapa

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initSupabase();
  runApp(const ParkeasyApp());
}

class ParkeasyApp extends StatelessWidget {
  const ParkeasyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parkeasy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Arial',
        scaffoldBackgroundColor: const Color(0xFFdfe2e7),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 138, 142, 146),
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/map': (context) => const MapScreen(), // ✅ nueva ruta añadida
      },
    );
  }
}

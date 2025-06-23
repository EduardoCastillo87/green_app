import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Check if Firebase options are properly configured
    if (DefaultFirebaseOptions.currentPlatform.projectId == 'your-project-id') {
      print(
        '⚠️  Firebase not configured. Please follow the setup guide in FIREBASE_SETUP.md',
      );
      print('⚠️  Running app without Firebase for now...');
    } else {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      print('✅ Firebase initialized successfully');
    }
  } catch (e) {
    print('❌ Failed to initialize Firebase: $e');
    print('⚠️  Running app without Firebase for now...');
  }

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GreenApp',
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: const Color(0xFF4CAF50),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4CAF50),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/register': (context) => const RegisterScreen(),
      },
    );
  }
}

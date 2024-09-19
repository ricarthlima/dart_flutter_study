import 'package:dart_flutter/ui/home_screen.dart';
import 'package:dart_flutter/ui/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Colors.grey,
        scaffoldBackgroundColor: Colors.amber[50],
      ),
      routes: {
        "login": (context) => const LoginScreen(),
        "home": (context) => const HomeScreen(),
      },
      initialRoute: "login",
    );
  }
}

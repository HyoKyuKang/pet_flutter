import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/game_state.dart';
import 'screens/main_screen.dart';
import 'utils/save_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final saveManager = await SaveManager.create();

  runApp(
    ProviderScope(
      overrides: [
        saveManagerProvider.overrideWithValue(saveManager),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '펫 키우기',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

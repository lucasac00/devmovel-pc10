import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'database/app_database.dart';
import 'view/person_screen.dart';
import 'view/person_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  final personDao = database.personDao;

  runApp(
    ChangeNotifierProvider(
      create: (context) => PersonViewModel(personDao),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Floor Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const PersonScreen(),
    );
  }
}
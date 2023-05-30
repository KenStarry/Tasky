import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/presentation/provider/core_provider.dart';
import 'package:tasky/dependency_injection/locator.dart';
import 'package:tasky/features/feature_home/presentation/home_screen.dart';

void main() {

  init();

  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => CoreProvider())],
      child: MyApp(),
    ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'home_view.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
    ),
  );
  runApp(const KokoApp());
}

class KokoApp extends StatelessWidget {
  const KokoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Koko-App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const HomeView(),
    );
  }
}

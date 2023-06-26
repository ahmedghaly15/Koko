import 'package:flutter/material.dart';

import 'features/home/presentation/view/home_view.dart';
import 'core/global/app_texts.dart';

void main() => runApp(const KokoApp());

class KokoApp extends StatelessWidget {
  const KokoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppTexts.appTitle,
      home: HomeView(),
    );
  }
}

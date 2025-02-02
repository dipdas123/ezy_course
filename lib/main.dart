import 'package:ezycourse/presentation/screens/intro/intro_screen.dart';
import 'package:ezycourse/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Community Feed',
      home: IntroScreen(),
    );
  }
}
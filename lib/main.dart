import 'package:ezycourse/presentation/screens/auth/login_screen.dart';
import 'package:ezycourse/presentation/screens/intro/intro_screen.dart';
import 'package:ezycourse/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'infrastructure/datasources/local/database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  DatabaseHelper dbHelper = DatabaseHelper();
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
      home: IntroScreen(), // Replace with your initial screen
    );
  }
}
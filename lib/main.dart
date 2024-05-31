import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:whatif_project/core/cache/shared_pref.dart';
import 'package:whatif_project/firebase_options.dart';
import 'package:whatif_project/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  CacheHeleper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}



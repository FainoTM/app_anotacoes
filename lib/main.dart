import 'package:anotacao_firebase/firebase_options.dart';
import 'package:anotacao_firebase/homePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'route/appRoutes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
    initialRoute: AppRoutes.homePage,
    routes: AppRoutes.define(),
  ),);
}

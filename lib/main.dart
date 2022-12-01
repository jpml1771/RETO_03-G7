import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reto3/controllers/controllers.dart';

import 'interfaz/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyB3VK8bYYsxgzFivT2pxxCE88Kka_1gzXw",
          authDomain: "reto3-g7-2289.firebaseapp.com",
          projectId: "reto3-g7-2289",
          storageBucket: "reto3-g7-2289.appspot.com",
          messagingSenderId: "136422735586",
          appId: "1:136422735586:web:93bbae325a69849df3e8bb",
          measurementId: "G-RPXSBNRYHK"));
  Get.put(controllers());
  runApp(const MyApp());
}

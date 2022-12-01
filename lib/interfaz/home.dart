import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reto3/interfaz/chat.dart';
import 'package:reto3/interfaz/login.dart';
import 'package:reto3/interfaz/startpage.dart';
import 'package:reto3/interfaz/usuarios.dart';
import 'package:reto3/proceso/autenticacion.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'App Mensajeria',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'App de Chat'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: autenticacion().estadoLogin,
      builder: (context, response) {
        if (response.hasData) {
          return startPage();
        } else {
          return login();
        }
      },
    );
  }
}

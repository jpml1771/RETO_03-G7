import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reto3/interfaz/mensajes.dart';
import 'package:reto3/interfaz/usuarios.dart';
import 'package:reto3/proceso/autenticacion.dart';

class startPage extends StatefulWidget {
  const startPage({super.key});

  @override
  State<startPage> createState() => _startPageState();
}

final message = TextEditingController();
final aut_fire = FirebaseFirestore.instance;

class _startPageState extends State<startPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[500],
        title: Center(
          child: Text(
            'Hola, ${(autenticacion().usuarios?.email).toString()}',
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                autenticacion().cerraSesion();
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.green[200]!],
            stops: [.2, 5],
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 40, 20, 10),
                  child: Text(
                    "Tus Conversaciones,",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                        fontSize: 25),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(offset),
                child: Usuarios(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

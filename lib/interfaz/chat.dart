import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reto3/controllers/controllers.dart';
import 'package:reto3/interfaz/mensajes.dart';
import 'package:reto3/proceso/autenticacion.dart';

class chat extends StatefulWidget {
  const chat({super.key});

  @override
  State<chat> createState() => _chatState();
}

final message = TextEditingController();
final aut_fire = FirebaseFirestore.instance;

class _chatState extends State<chat> {
  controllers control = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: (() {
              Navigator.pop(context);
            }),
            icon: Icon(Icons.chevron_left)),
        backgroundColor: Colors.green[500],
        title: Center(
          child: Text(
            'Chats con ${control.user_chat}',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.white, Colors.green[200]!],
                stops: [.2, 5],
                begin: Alignment.topRight,
                end: Alignment.bottomRight)),
        child: Column(
          children: [
            //Text(control.user_chat),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(offset),
                child: mensajes(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Row(
            children: [
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                    child: TextField(
                      scrollPadding: EdgeInsets.fromLTRB(0, 0, 0, offset),
                      controller: message,
                      decoration: InputDecoration(
                        hintText: 'Mensaje...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (message.text.isNotEmpty) {
                    aut_fire.collection("chat").doc().set({
                      "message": message.text,
                      "time": DateTime.now(),
                      "sender": (autenticacion().usuarios?.email).toString(),
                      "receiver": control.user_chat,
                    });
                    message.text = "";
                    print(control.user_chat);
                  } else {}
                },
                child: Icon(Icons.send),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(offset),
                  backgroundColor: Colors.green[500],
                ),
              )
            ],
          ),
        ),
      ),
      backgroundColor: Colors.black.withOpacity(0.1),
    );
  }
}

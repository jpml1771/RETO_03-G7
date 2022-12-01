import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reto3/proceso/autenticacion.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

final mail = TextEditingController();
final password = TextEditingController();
final aut_fire = FirebaseFirestore.instance;

class _loginState extends State<login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[500],
        title: Center(
            child: Text(
          'APPS DE PERSONAS',
          style: TextStyle(fontWeight: FontWeight.w800),
        )),
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
        child: Padding(
          padding: EdgeInsets.all(offset),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 30, bottom: 20),
                child: Image(
                    image: NetworkImage(
                        'https://cdni.iconscout.com/illustration/premium/thumb/message-sent-4320179-3598814.png')),
              ),
              Row(
                children: [
                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: TextField(
                          scrollPadding: EdgeInsets.fromLTRB(0, 0, 0, offset),
                          controller: mail,
                          decoration: InputDecoration(
                            icon: Icon(Icons.mail),
                            hintText: 'Email...',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: TextField(
                          obscureText: true,
                          scrollPadding: EdgeInsets.fromLTRB(0, 0, 0, offset),
                          controller: password,
                          decoration: InputDecoration(
                            icon: Icon(Icons.lock),
                            hintText: 'Contraseña...',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, offset, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[500],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: (() {
                        autenticacion().inciarSesion(
                            email: mail.text, password: password.text);
                        mail.clear();
                        password.clear();
                      }),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Iniciar Sesión',
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 15),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[500],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: (() {
                        autenticacion().crearUsuario(
                            email: mail.text, password: password.text);
                        if (mail.text.isNotEmpty) {
                          aut_fire.collection("user").doc().set({
                            "user": mail.text,
                            "time": DateTime.now(),
                          });
                          mail.text = "";
                        } else {}

                        mail.clear();
                        password.clear();
                      }),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Crear Usuario',
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:reto3/controllers/controllers.dart';
import 'package:reto3/interfaz/chat.dart';
import '../proceso/autenticacion.dart';
import 'package:flutter/material.dart';

class Usuarios extends StatefulWidget {
  const Usuarios({super.key});

  @override
  State<Usuarios> createState() => _UsuariosState();
}

class _UsuariosState extends State<Usuarios> {
  controllers control = Get.find();
  Stream<QuerySnapshot> response_user = FirebaseFirestore.instance
      .collection("user")
      .orderBy("time", descending: true)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: response_user,
        builder: (context, AsyncSnapshot<QuerySnapshot> respuesta) {
          return respuesta.hasData == true
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: respuesta.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return (autenticacion().usuarios?.email).toString() !=
                            respuesta.data!.docs[index].get("user")
                        ? Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            color: Colors.green[200],
                            elevation: 3,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                              child: ListTile(
                                title: Text(
                                  'Conversación con',
                                  style: TextStyle(fontWeight: FontWeight.w400),
                                ),
                                subtitle: Padding(
                                  padding: EdgeInsets.only(top: 5, bottom: 8),
                                  child: Text(
                                    respuesta.data!.docs[index].get("user"),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        color: Colors.black,
                                        fontSize: 20),
                                  ),
                                ),
                                trailing: Icon(Icons.chevron_right),
                                onTap: () {
                                  control.asignarUsuario(
                                      respuesta.data!.docs[index].get("user"));
                                  print(control.user_chat);
                                  Get.to(() => chat());
                                },
                              ),
                            ),
                          )
                        : Container();
                  },
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        });
  }
}

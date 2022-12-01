import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reto3/controllers/controllers.dart';

import '../proceso/autenticacion.dart';

class mensajes extends StatefulWidget {
  const mensajes({Key? key}) : super(key: key);

  @override
  State<mensajes> createState() => _mensajesState();
}

class _mensajesState extends State<mensajes> {
  controllers control = Get.find();

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> response_messages = FirebaseFirestore.instance
        .collection("chat")
        .orderBy("time", descending: true)
        .snapshots();
    return Column(
      children: [
        //Text(control.user_chat),
        StreamBuilder(
            stream: response_messages,
            builder: (context, AsyncSnapshot<QuerySnapshot> respuesta) {
              return respuesta.hasData == true
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: respuesta.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return control.user_chat ==
                                    respuesta.data!.docs[index].get("sender") ||
                                (autenticacion().usuarios?.email).toString() ==
                                    respuesta.data!.docs[index].get("sender")
                            ? control.user_chat ==
                                        respuesta.data!.docs[index]
                                            .get("receiver") ||
                                    (autenticacion().usuarios?.email)
                                            .toString() ==
                                        respuesta.data!.docs[index]
                                            .get("receiver")
                                ? Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    color: (autenticacion().usuarios?.email)
                                                .toString() ==
                                            respuesta.data!.docs[index]
                                                .get("sender")
                                        ? Colors.cyan
                                        : Colors.cyan[200],
                                    elevation: 3,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 2, 10, 2),
                                      child: ListTile(
                                        title: Text(
                                          respuesta.data!.docs[index]
                                              .get("message"),
                                          textAlign: (autenticacion()
                                                          .usuarios
                                                          ?.email)
                                                      .toString() ==
                                                  respuesta.data!.docs[index]
                                                      .get("sender")
                                              ? TextAlign.end
                                              : TextAlign.start,
                                        ),
                                        subtitle: Padding(
                                          padding: EdgeInsets.only(top: 5),
                                          child: Text(
                                            respuesta.data!.docs[index]
                                                .get("sender"),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w200,
                                                fontSize: 12),
                                            textAlign: (autenticacion()
                                                            .usuarios
                                                            ?.email)
                                                        .toString() ==
                                                    respuesta.data!.docs[index]
                                                        .get("sender")
                                                ? TextAlign.end
                                                : TextAlign.start,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Container()
                            : Container();
                      },
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            }),
      ],
    );
  }
}

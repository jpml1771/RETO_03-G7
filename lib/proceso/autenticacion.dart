import 'package:firebase_auth/firebase_auth.dart';

class autenticacion {
  final FirebaseAuth aut_fire = FirebaseAuth.instance;
  User? get usuarios => aut_fire.currentUser;
  Stream<User?> get estadoLogin => aut_fire.authStateChanges();

  Future<void> inciarSesion(
      {required String email, required String password}) async {
    try {
      await aut_fire.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e.code);
    }
  }

  Future<void> crearUsuario(
      {required String email, required String password}) async {
    try {
      await aut_fire.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e.code);
    }
  }

  Future<void> cerraSesion() async {
    try {
      await aut_fire.signOut();
    } on FirebaseAuthException catch (e) {
      print(e.code);
    }
  }
}

final double offset = 20;

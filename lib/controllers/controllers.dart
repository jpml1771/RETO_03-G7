import 'package:get/get.dart';

class controllers extends GetxController {
  var _user_chat = "".obs;
  void asignarUsuario(String x) {
    _user_chat.value = x;
  }

  get user_chat => _user_chat.value;
}

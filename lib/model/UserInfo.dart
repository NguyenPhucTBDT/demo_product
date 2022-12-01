import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserInfo extends GetxController {
  late final int idU;
  late final String account;
  late final String password;
  late final String fullname;
  late final String phone;
  late final String email;

  updateInfo({@required fullname, @required phone, @required email}) {
    this.fullname = fullname;
    this.phone = phone;
    this.email = email;
    update();
  }
}

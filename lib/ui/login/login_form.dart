
import 'package:demo_product/constants/StringCommon.dart';
import 'package:demo_product/model/UserInfo.dart';
import 'package:demo_product/resources/common_widgets.dart';
import 'package:demo_product/ui/counter_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage(BuildContext context, {super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController accountController, passwordController;

  @override
  void initState() {
    super.initState();
    accountController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        margin: const EdgeInsets.all(0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            inputWidget(
                label: StringCommon.account,
                hintText: StringCommon.inputAccount,
                controller: accountController),
            inputWidget(
                label: StringCommon.password,
                hintText: StringCommon.inputPassword,
                controller: passwordController),
            buttonWidget(
                label: StringCommon.buttonLogIn,
                colorButton: Colors.amberAccent,
                onPress: () {
                  print(accountController.text);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CounterView()));
                })
          ],
        ),
      ),
    ));
  }
}

openDialog(BuildContext context) {
  // This is the ok button
  Widget ok = TextButton(
    child: const Text("Okay"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  // show the alert dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("I am Here!"),
        content: const Text("I appeared because you pressed the button!"),
        actions: [
          ok,
        ],
        elevation: 5,
      );
    },
  );
}

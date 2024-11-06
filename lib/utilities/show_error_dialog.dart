import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

Future<void> showErrorDialog(BuildContext context, String text) async {
  return AwesomeDialog(
    context: context,
    dialogType: DialogType.error,
    animType: AnimType.bottomSlide,
    title: 'An Error Occurred!',
    desc: text,
    btnOkOnPress: () {},
    btnOkIcon: Icons.cancel,
    btnOkColor: Colors.red,
  ).show();
  // return showDialog<void>(
  //   context: context,
  //   builder: (context) {
  //     // return AlertDialog(
  //     //   title: const Text('An Error Occurred!'),
  //     //   content: Text(text),
  //     //   actions: <Widget>[
  //     //     TextButton(
  //     //       onPressed: () {
  //     //         Navigator.of(context).pop();
  //     //       },
  //     //       child: const Text('OK'),
  //     //     )
  //     //   ],
  //     // );
  //   },
  // );
}

Future<dynamic> showDeleteDialog(BuildContext context, String text) async {
  return AwesomeDialog(
    context: context,
    dialogType: DialogType.warning,
    animType: AnimType.bottomSlide,
    title: 'Are you sure?',
    desc: text,
    btnOkOnPress: () {},
    btnOkIcon: Icons.delete,
    btnOkColor: Colors.red,
  ).show();
}

Future<dynamic> showLogOutDialog(BuildContext context, String text) async {
  return AwesomeDialog(
    context: context,
    dialogType: DialogType.warning,
    animType: AnimType.bottomSlide,
    title: 'Are you sure?',
    desc: text,
    btnOkOnPress: () {},
    btnOkIcon: Icons.logout,
    btnOkColor: Colors.red,
  ).show();
}

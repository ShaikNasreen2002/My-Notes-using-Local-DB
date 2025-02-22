import 'package:flutter/material.dart';
import 'package:flutter_application/utilities/dialogs/generic_dialog.dart';

Future<void> showErrorDialog(BuildContext context, String text) async {
  return showGenericDialog(
      context: context,
      title: 'An error occurred',
      content: text,
      optionsBuilder: () => {'OK': null});
}

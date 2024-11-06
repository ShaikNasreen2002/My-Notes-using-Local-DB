import 'package:flutter/material.dart';
import 'package:flutter_application/utilities/dialogs/generic_dialog.dart';

Future<bool> showDeleteDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Delete',
    content: 'Are you sure you want to delete this item?',
    optionsBuilder: () => {'Cancel': false, 'Ok': true},
  ).then(
    (value) => value ?? false,
  );
}

import 'package:flutter/material.dart';

void showAlertDialog({
  required BuildContext context,
  required String title,
  required String msg,
  required VoidCallback onYesAction,
}) {
  // Set up the buttons
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      onYesAction();
      Navigator.pop(context);
    },
  );
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed: () => Navigator.pop(context),
  );

  // Set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(msg),
    actions: [okButton, cancelButton],
  );

  // Show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

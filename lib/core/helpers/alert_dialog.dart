import 'package:flutter/material.dart';

class AlertDialogHelper {
  // build constructor
  final BuildContext context;
  AlertDialogHelper(this.context);

  // singleton
  static AlertDialogHelper? _instance;
  static AlertDialogHelper instance(context) {
    _instance ??= AlertDialogHelper(context);
    return _instance!;
  }

  showLoader() {
    var alert = const AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white70,
        ),
      ),
    );

    showDialog(context: context, barrierDismissible: true, builder: (_) => alert);
  }

  showError(String message) {
    var alert = AlertDialog(
      backgroundColor: Colors.white,
      elevation: 2,
      content: Center(child: SizedBox(height: MediaQuery.of(context).size.height * 0.3, child: Text(message))),
    );

    showDialog(context: context, barrierDismissible: true, builder: (_) => alert);
  }

  hideLoader() {
    Navigator.of(context, rootNavigator: true).pop();
  }
}

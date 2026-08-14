import 'package:flutter/material.dart';

class DialogUtils {
  static showMessageDialog({
    required BuildContext context,
    required String content,
    required String actionTitle,
    required void Function() actionPress
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Warning"),
        content: Text(content),
        actions: [ElevatedButton(onPressed: actionPress, child: Text(actionTitle))],
      ),
    );
  }

  static showLoadingDialog(BuildContext context){
    showDialog(context: context, builder: (context) => AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Loading..."),
              Center(child: CircularProgressIndicator(),)
            ],),
        ],
      ),
    ),);
  }

  static showSnackbar(BuildContext context,String content){
    SnackBar snackBar = SnackBar(
        content: Text(content));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
import 'package:flutter/material.dart';

const String apiBaseUrl = 'http://192.168.0.210:5200';

void showLoadingDialog(BuildContext context, String text) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 16.0),
            Text(text),
          ],
        ),
      );
    }
  ); 
}
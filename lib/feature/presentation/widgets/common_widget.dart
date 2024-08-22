import 'package:flutter/material.dart';

void snackBarError({String? msg, GlobalKey<ScaffoldState>? scaffoldState}) {
final context = scaffoldState!.currentContext;
  
  if (context != null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg ?? "Something went wrong.")),
    );
  }
}

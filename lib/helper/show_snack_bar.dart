import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

// ignore: non_constant_identifier_names
void ShowSnackBar(BuildContext context,String msg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg),backgroundColor: kPrimaryColor
    ,padding: const EdgeInsets.all(12.0),));
}
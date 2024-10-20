  import 'package:flutter/material.dart';

InputDecoration inputDecoration(String labelText) {
    return InputDecoration(
      focusedBorder:const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: Colors.deepPurple),
      ),
      enabledBorder:const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: Colors.white),
      ),
      border:const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: Colors.white), 
      ),
      labelText: labelText,
      labelStyle:const TextStyle(color: Colors.white),
    );
  }
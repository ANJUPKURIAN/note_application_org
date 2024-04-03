import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:note_application_org/core/constant/color_constant.dart';


class NotesScreenController {
  static List notesListKeys = [];

  static List<Color> colorList = [
    ColorConstant.primaryBlue,
    ColorConstant.primaryGreen,
    ColorConstant.primaryYellow,
    ColorConstant.customPink
  ];

  // hive referrence
  static var myBox= Hive.box("noteBox");

  // add note
   static getInitKeys() {
    notesListKeys = myBox.keys.toList();
  }

  static Future<void> addNote({
    required String title,
    required String description,
    required String date,
    int colorIndex = 0,
  }) async {
    await myBox.add({
      "title": title,
      "description": description,
      "date": date,
      "colorIndex": colorIndex,
    });
    notesListKeys = myBox.keys.toList();
  }

  static Future<void> deleteNote(var key) async {
    await myBox.delete(key);
    notesListKeys = myBox.keys.toList();
  }

  static Future<void> editNote({
    required var key,
    required String title,
    required String description,
    required String date,
    int colorIndex = 0,
  }) async {
    await myBox.put(key, {
      "title": title,
      "description": description,
      "date": date,
      "colorIndex": colorIndex,
    });
  }
}
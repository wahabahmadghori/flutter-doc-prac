import 'package:flutter/material.dart';

class NovelViewProvider extends ChangeNotifier {
  List<String> pages = [];
  int page = 9;
  void generatePagesList() {
    for (page; page <= 383; page++) {
      pages.add(page.toString());
    }
  }
}

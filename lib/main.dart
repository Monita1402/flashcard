import 'package:flutter/material.dart';
import 'flashcard_model.dart';
import 'flashcard_add_edit.dart';
import 'flashcard_list.dart';

void main() {
  runApp(FlashcardApp());
}

class FlashcardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FlashcardListScreen(),
    );
  }
}

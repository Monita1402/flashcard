import 'package:flutter/material.dart';
import 'flashcard_model.dart';

class FlashcardAddEditScreen extends StatelessWidget {
  final Flashcard? flashcard;
  final void Function(String, String) onSave;

  FlashcardAddEditScreen({this.flashcard, required this.onSave});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final questionController = TextEditingController(text: flashcard?.question ?? '');
    final answerController = TextEditingController(text: flashcard?.answer ?? '');

    return Scaffold(
      appBar: AppBar(
        title: Text(flashcard == null ? 'Add Flashcard' : 'Edit Flashcard'),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade200, Colors.deepPurple.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Question Text Field
                      TextFormField(
                        controller: questionController,
                        decoration: InputDecoration(
                          labelText: 'Question',
                          labelStyle: TextStyle(color: Colors.deepPurple),
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) => value == null || value.isEmpty ? 'Cannot be empty' : null,
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 16),
                      // Answer Text Field
                      TextFormField(
                        controller: answerController,
                        maxLines: 5,
                        decoration: InputDecoration(
                          labelText: 'Answer',
                          labelStyle: TextStyle(color: Colors.deepPurple),
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) => value == null || value.isEmpty ? 'Cannot be empty' : null,
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
            // Save Button
            Padding(
              padding: EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    onSave(questionController.text, answerController.text);
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Flashcard saved successfully!'),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.save, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Save',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

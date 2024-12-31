import 'package:flutter/material.dart';
import 'flashcard_add_edit.dart';
import 'flashcard_model.dart';
import 'confirmation_dialog.dart';  // Import the confirmation dialog

class FlashcardListScreen extends StatefulWidget {
  @override
  _FlashcardListScreenState createState() => _FlashcardListScreenState();
}

class _FlashcardListScreenState extends State<FlashcardListScreen> {
  List<Flashcard> flashcards = [];

  void _addFlashcard(String question, String answer) {
    setState(() {
      flashcards.add(Flashcard(question: question, answer: answer));
    });
  }

  void _editFlashcard(int index, String question, String answer) {
    setState(() {
      flashcards[index] = Flashcard(question: question, answer: answer);
    });
  }

  void _deleteFlashcard(int index) {
    setState(() {
      flashcards.removeAt(index);
    });
  }

  void _navigateToAddEditScreen({Flashcard? flashcard, int? index}) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => FlashcardAddEditScreen(
        flashcard: flashcard,
        onSave: (question, answer) {
          if (index == null) {
            _addFlashcard(question, answer);
          } else {
            _editFlashcard(index, question, answer);
          }
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flashcards', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // The main content of the screen
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurple.shade200, Colors.deepPurple.shade50],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: flashcards.isEmpty
                ? Center(
              child: Text(
                'No flashcards available.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
                : ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 16),
              itemCount: flashcards.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: Colors.deepPurple, width: 2), // Add border around card
                  ),
                  elevation: 8,
                  color: Colors.white,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.help_outline, color: Colors.blue, size: 24),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                flashcards[index].question,
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.check_circle_outline, color: Colors.green, size: 24),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                flashcards[index].answer,
                                style: TextStyle(fontSize: 16, color: Colors.black87),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // Edit Button
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.blue, width: 1),
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.blue.withOpacity(0.1),
                              ),
                              child: IconButton(
                                icon: Icon(Icons.edit, color: Colors.blue),
                                onPressed: () => _navigateToAddEditScreen(
                                  flashcard: flashcards[index],
                                  index: index,
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            // Delete Button
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.red, width: 1),
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.red.withOpacity(0.1),
                              ),
                              child: IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () => showConfirmationDialog(
                                  context,
                                  'Delete Flashcard',
                                  'Are you sure you want to delete this flashcard?',
                                      () {
                                    _deleteFlashcard(index);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Add Flashcard button at the bottom-center of the screen
          Positioned(
            bottom: 16,
            left: 70,
            right: 70,
            child: Container(
              /*decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2), // Border properties
                 // Match the button's shape
              ),*/
              child: FloatingActionButton.extended(
                onPressed: () => _navigateToAddEditScreen(),
                backgroundColor: Colors.deepPurple,
                label: Row(
                  mainAxisSize: MainAxisSize.min, // This will make the row take up only the required space
                  children: [
                    Icon(Icons.add, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Add Flashcard',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}

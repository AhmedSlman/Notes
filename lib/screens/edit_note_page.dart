import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/todo_cubit.dart';
import 'note_datailed_page.dart';

class EditNotePage extends StatelessWidget {
  final String title;
  final String text;
  final int noteIndex;

  const EditNotePage({
    super.key,
    required this.title,
    required this.text,
    required this.noteIndex,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController =
        TextEditingController(text: title);
    final TextEditingController textController =
        TextEditingController(text: text);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: textController,
              decoration: const InputDecoration(
                labelText: 'Note',
              ),
              maxLines: null,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                String editedTitle = titleController.text;
                String editedText = textController.text;
                if (editedTitle.isNotEmpty && editedText.isNotEmpty) {
                  BlocProvider.of<NoteCubit>(context)
                      .editNote(noteIndex, editedTitle, editedText);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NoteDetailsPage(
                        title: editedTitle,
                        text: editedText,
                        noteIndex: noteIndex,
                      ),
                    ),
                  );
                }
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}

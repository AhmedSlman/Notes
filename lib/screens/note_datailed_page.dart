import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_app/cubit/todo_cubit.dart';

import '../cubit/todo_state.dart';
import 'edit_note_page.dart';

class NoteDetailsPage extends StatelessWidget {
  final String title;
  final String text;
  final int noteIndex;

  const NoteDetailsPage({
    super.key,
    required this.title,
    required this.text,
    required this.noteIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteCubit, NoteState>(
        builder: (BuildContext context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Note Details'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditNotePage(
                        noteIndex: noteIndex,
                        text: text,
                        title: title,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.edit))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Title: $title',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Text: $text',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

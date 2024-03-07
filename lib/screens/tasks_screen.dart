import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/todo_cubit.dart';
import '../cubit/todo_state.dart';
import 'edit_note_page.dart';
import 'note_datailed_page.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final noteCubit = BlocProvider.of<NoteCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: BlocBuilder<NoteCubit, NoteState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.notes.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(state.notes[index].title),
                subtitle: Text(state.notes[index].text),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NoteDetailsPage(
                        title: state.notes[index].title,
                        text: state.notes[index].text,
                        noteIndex: index,
                      ),
                    ),
                  );
                },
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    _showDeleteConfirmationDialog(context, noteCubit, index);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddNoteDialog(context, noteCubit);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddNoteDialog(BuildContext context, NoteCubit noteCubit) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController textEditingController =
            TextEditingController();
        final TextEditingController noteTitelController =
            TextEditingController();
        return AlertDialog(
          title: const Text('Add Note'),
          content: Column(
            children: [
              TextField(
                controller: noteTitelController,
                decoration: const InputDecoration(hintText: 'Title'),
              ),
              TextField(
                controller: textEditingController,
                decoration: const InputDecoration(hintText: 'Enter your note'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String note = textEditingController.text;
                String title = noteTitelController.text;
                if (note.isNotEmpty) {
                  noteCubit.addNote(note, title);
                }
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

void _showDeleteConfirmationDialog(
    BuildContext context, NoteCubit noteCubit, int index) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete this note?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              noteCubit.deleteNote(index);
              Navigator.of(context).pop();
            },
            child: const Text('Delete'),
          ),
        ],
      );
    },
  );
}

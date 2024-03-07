import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasks_app/cubit/todo_state.dart';

import '../models/note_model.dart';

class NoteCubit extends Cubit<NoteState> {
  late SharedPreferences prefs;

  NoteCubit() : super(NoteState([])) {
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    prefs = await SharedPreferences.getInstance();
    List<String>? jsonNotes = prefs.getStringList('notes');
    if (jsonNotes != null) {
      List<Note> notes =
          jsonNotes.map((json) => Note.fromJson(jsonDecode(json))).toList();
      emit(NoteState(notes.cast<Note>()));
    }
  }

  Future<void> _saveNotes(List<Note> notes) async {
    List<String> jsonNotes =
        notes.map((note) => jsonEncode(note.toJson())).toList();
    await prefs.setStringList('notes', jsonNotes);
  }

  void addNote(String title, String text) {
    final List<Note> updatedNotes = List.from(state.notes)
      ..add(Note(text: title, title: text));
    emit(NoteState(updatedNotes.cast<Note>()));
    _saveNotes(updatedNotes);
  }

  void deleteNote(int index) {
    final List<Note> updatedNotes = List.from(state.notes)..removeAt(index);
    emit(NoteState(updatedNotes.cast<Note>()));
    _saveNotes(updatedNotes);
  }

  void editNote(int index, String newTitle, String newText) {
    final List<Note> updatedNotes = List.from(state.notes);
    updatedNotes[index] = Note(
      text: newTitle,
      title: newText,
    );
    emit(NoteState(updatedNotes));
    _saveNotes(updatedNotes);
  }
}

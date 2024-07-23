import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_bloc/models/Notes.dart';

class NoteViewModel extends Cubit<List<Note>> {
  NoteViewModel() : super([]);

  void addNote(Note note) {
    state.add(note);
    emit(List.from(state));
  }

  void updateNote(int index, Note note) {
    state[index] = note;
    emit(List.from(state));
  }

  void deleteNote(int index) {
    state.removeAt(index);
    emit(List.from(state));
  }
}
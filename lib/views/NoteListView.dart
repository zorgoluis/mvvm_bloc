import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_bloc/models/Notes.dart';
import 'package:mvvm_bloc/viewmodels/NoteViewModel.dart';

class NoteListView extends StatelessWidget {
  final NoteViewModel viewModel = NoteViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note App'),
      ),
      body: BlocBuilder<NoteViewModel, List<Note>>(
        bloc: viewModel,
        builder: (context, notes) {
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(notes[index].title),
                subtitle: Text(notes[index].content),
                onTap: () {
                  _editNote(context, notes[index], index);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addNote(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _addNote(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        String title = '';
        String content = '';

        return AlertDialog(
          title: Text('Add Note'),
          content: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                onChanged: (value) {
                  title = value;
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Content',
                ),
                onChanged: (value) {
                  content = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Note note = Note(
                  title: title,
                  content: content,
                );
                viewModel.addNote(note);
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _editNote(BuildContext context, Note note, int index) {
    showDialog(
      context: context,
      builder: (context) {
        String title = note.title;
        String content = note.content;

        return AlertDialog(
          title: Text('Edit Note'),
          content: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                onChanged: (value) {
                  title = value;
                },
                controller: TextEditingController(text: title),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Content',
                ),
                onChanged: (value) {
                  content = value;
                },
                controller: TextEditingController(text: content),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Note updatedNote = Note(
                  title: title,
                  content: content,
                );
                viewModel.updateNote(index, updatedNote);
                Navigator.of(context).pop();
              },
              child: Text('Update'),
            ),
            TextButton(
              onPressed: () {
                viewModel.deleteNote(index);
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
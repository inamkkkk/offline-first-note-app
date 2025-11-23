import 'package:flutter/material.dart';
import 'package:offline_note_app/models/note.dart';
import 'package:offline_note_app/screens/note_screen.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<NoteProvider>(context, listen: false).loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: noteProvider.notes.isEmpty
          ? const Center(
              child: Text('No notes yet!'),
            )
          : ListView.builder(
              itemCount: noteProvider.notes.length,
              itemBuilder: (context, index) {
                final note = noteProvider.notes[index];
                return Card(
                  child: ListTile(
                    title: Text(note.title),
                    subtitle: Text(note.content),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        noteProvider.deleteNote(note.id);
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NoteScreen(note: note),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NoteScreen(
                note: Note(id: const Uuid().v4(), title: '', content: ''),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
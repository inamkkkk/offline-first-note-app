import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:offline_note_app/models/note.dart';
import 'package:offline_note_app/screens/home_screen.dart';
import 'package:offline_note_app/services/hive_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  await HiveService.openBoxes();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NoteProvider(),
      child: MaterialApp(
        title: 'Offline Notes',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

class NoteProvider extends ChangeNotifier {
  List<Note> _notes = [];

  List<Note> get notes => _notes;

  Future<void> loadNotes() async {
    _notes = await HiveService.getNotes();
    notifyListeners();
  }

  Future<void> addNote(Note note) async {
    await HiveService.addNote(note);
    await loadNotes();
  }

  Future<void> updateNote(Note note) async {
    await HiveService.updateNote(note);
    await loadNotes();
  }

  Future<void> deleteNote(String id) async {
    await HiveService.deleteNote(id);
    await loadNotes();
  }
}
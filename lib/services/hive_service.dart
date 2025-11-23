import 'package:hive/hive.dart';
import 'package:offline_note_app/models/note.dart';

class HiveService {
  static const String _noteBoxName = 'notes';
  static Box<Note>? _noteBox;

  static Future<void> openBoxes() async {
    _noteBox = await Hive.openBox<Note>(_noteBoxName);
  }

  static Future<void> addNote(Note note) async {
    await _noteBox!.put(note.id, note);
  }

  static Future<void> updateNote(Note note) async {
    await _noteBox!.put(note.id, note);
  }

  static Future<void> deleteNote(String id) async {
    await _noteBox!.delete(id);
  }

  static Future<List<Note>> getNotes() async {
    return _noteBox!.values.toList();
  }
}

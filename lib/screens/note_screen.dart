import 'package:flutter/material.dart';
import 'package:offline_note_app/models/note.dart';
import 'package:provider/provider.dart';

class NoteScreen extends StatefulWidget {
  final Note? note;

  const NoteScreen({Key? key, required this.note}) : super(key: key);

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note!.title);
    _contentController = TextEditingController(text: widget.note!.content);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Note'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              final updatedNote = Note(
                id: widget.note!.id,
                title: _titleController.text,
                content: _contentController.text,
              );

              if (widget.note!.title.isEmpty && widget.note!.content.isEmpty) {
                noteProvider.addNote(updatedNote);
              } else {
                noteProvider.updateNote(updatedNote);
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: 'Title',
                border: InputBorder.none,
              ),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Expanded(
              child: TextField(
                controller: _contentController,
                decoration: const InputDecoration(
                  hintText: 'Content',
                  border: InputBorder.none,
                ),
                maxLines: null,
                expands: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
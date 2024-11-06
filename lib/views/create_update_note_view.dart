// import 'package:flutter/material.dart';
// import '../services/auth/auth_service.dart';
// import '../services/cloud/cloud_note.dart';
// import '../services/cloud/firebase_cloud_storage.dart';

// class CreateUpdateNoteView extends StatefulWidget {
//   const CreateUpdateNoteView({super.key});

//   @override
//   State<CreateUpdateNoteView> createState() => _CreateUpdateNoteViewState();
// }

// class _CreateUpdateNoteViewState extends State<CreateUpdateNoteView> {
//   CloudNote? _note;
//   late final FirebaseCloudStorage _notesService;
//   late final TextEditingController _textController;
//   @override
//   void initState() {
//     _notesService = FirebaseCloudStorage();
//     _textController = TextEditingController();
//     super.initState();
//   }

//   void textControllerListener() async {
//     final note = _note;
//     if (note == null) {
//       return;
//     }
//     final text = _textController.text;
//     await _notesService.updateNote(
//       documentId: note.documentId,
//       text: text,
//     );
//   }

//   void deleteNoteIfTextIsEmpty() {
//     final note = _note;
//     if (_textController.text.isEmpty && note != null) {
//       _notesService.deleteNote(documentId: note.documentId);
//     }
//   }

//   // void _textControllerListener() async {
//   //   final note = _note;
//   //   if (note == null) {
//   //     return;
//   //   }
//   //   final text = _textController.text;
//   //   await _notesService.updateNote(
//   //     documentId: note.documentId,
//   //     text: text,
//   //   );
//   // }

//   Future<CloudNote> createOrGetExistingNote(BuildContext context) async {
//     final widgetNote = context.getArgument<CloudNote>();
//     if (widgetNote != null) {
//       _note = widgetNote;
//       _textController.text = widgetNote.text;
//       return widgetNote;
//     }
//     final existingNote = _note;
//     if (existingNote != null) {
//       return existingNote;
//     }
//     final currentUser = AuthService.firebase().currentUser;
//     final userId = currentUser?.id;
//     final newNote =
//         await _notesService.createNewNote(ownerUserId: userId ?? '');
//     _note = newNote;
//     return newNote;
//   }

//   void _saveNoteIfTextNotEmpty() async {
//     final note = _note;
//     final text = _textController.text;
//     if (note != null && text.isNotEmpty) {
//       await _notesService.updateNote(
//         documentId: note.documentId,
//         text: text,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_application/services/auth/auth_service.dart';
import 'package:flutter_application/services/crud/notes_service.dart';
import 'package:flutter_application/utilities/generics/get_arguments.dart';

class CreateUpdateNoteView extends StatefulWidget {
  const CreateUpdateNoteView({super.key});

  @override
  _CreateUpdateNoteViewState createState() => _CreateUpdateNoteViewState();
}

class _CreateUpdateNoteViewState extends State<CreateUpdateNoteView> {
  DatabaseNote? _note;
  late final NotesService _notesService;
  late final TextEditingController _textController;
  @override
  void initState() {
    _notesService = NotesService();
    _textController = TextEditingController();
    super.initState();
  }

  void _textControllerListener() async {
    final note = _note;
    if (note == null) {
      return;
    }
    final text = _textController.text;
    await _notesService.updateNote(
      note: note,
      text: text,
    );
  }

  void _setupTextControllerListener() {
    _textController.removeListener(_textControllerListener);
    _textController.addListener(_textControllerListener);
  }

  Future<DatabaseNote> _createOrGetExistingNote(BuildContext context) async {
    final widgetNote = context.getArgument<DatabaseNote>();
    if (widgetNote != null) {
      _note = widgetNote;
      _textController.text = widgetNote.text;
      return widgetNote;
    }
    final existingNote = _note;
    if (existingNote != null) {
      return existingNote;
    }
    final currentUser = AuthService.firebase().currentUser!;
    final email = currentUser.email!;
    final owner = await _notesService.getUser(email: email);
    final newNote = await _notesService.createNote(owner: owner);
    _note = newNote;
    return newNote;
  }

  void _deletedNoteIfTextIsEmpty() {
    final note = _note;
    if (_textController.text.isEmpty && note != null) {
      _notesService.deleteNote(id: note.id);
    }
  }

  void _saveNoteIfTextNotEmpty() async {
    final note = _note;
    final text = _textController.text;
    if (text.isNotEmpty && note != null) {
      await _notesService.updateNote(note: note, text: text);
    }
  }

  @override
  void dispose() {
    _deletedNoteIfTextIsEmpty();
    _saveNoteIfTextNotEmpty();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('New Note')),
        body: FutureBuilder(
          future: _createOrGetExistingNote(context),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                _note = snapshot.data as DatabaseNote;
                _setupTextControllerListener();
                return TextField(
                  controller: _textController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: 'Start typing your note...',
                  ),
                );
              default:
                return const CircularProgressIndicator();
            }
          },
        ));
  }
}

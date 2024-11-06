import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application/services/cloud/cloud_note.dart';

import '../utilities/show_error_dialog.dart';

typedef NoteCallback = void Function(CloudNote note);

class NotesListViewPage extends StatelessWidget {
  final Iterable<CloudNote> notes;
  final NoteCallback onDeleteNote;
  final NoteCallback onTap;
  NotesListViewPage(
      {super.key,
      required this.notes,
      required this.onDeleteNote,
      required this.onTap});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes.elementAt(index);
        return ListTile(
          title: Text(
            note.text,
            maxLines: 1,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () {
            onTap(note);
          },
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              final shouldDelete = await showDeleteDialog(
                  context, 'Are you sure you want to delete this note?');
              if (shouldDelete == true) {
                onDeleteNote(note);
              }
            },
          ),
        );
      },
    );
  }
}


// class NotesListViewPage extends StatefulWidget {
//   @override
//   _NotesListViewPageState createState() => _NotesListViewPageState();
// }

// class _NotesListViewPageState extends State<NotesListViewPage> {
//   // List<String> notes = ['Note 1', 'Note 2', 'Note 3'];
//   late final Iterable<CloudNote> notes;
//   late final NoteCallback onDeleteNote;
//   late final NoteCallback onTap;
//   int? editingIndex;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Notes List'),
//       ),
//       body: ListView.builder(
//         itemCount: notes.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: editingIndex == index
//                 ? TextField(
//                     autofocus: true,
//                     onSubmitted: (newValue) {
//                       setState(() {
//                         notes[index] = newValue;
//                         editingIndex = null;
//                       });
//                     },
//                     controller: TextEditingController()..text = notes[index],
//                   )
//                 : GestureDetector(
//                     onDoubleTap: () {
//                       setState(() {
//                         editingIndex = index;
//                       });
//                     },
//                     child: Text(notes[index]),
//                   ),
//             trailing: IconButton(
//               icon: Icon(Icons.delete),
//               onPressed: () {
//                 setState(() {
//                   notes.removeAt(index);
//                 });
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }



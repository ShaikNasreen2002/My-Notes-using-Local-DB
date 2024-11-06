import 'package:flutter/material.dart';
import 'package:flutter_application/services/auth/auth_service.dart';
import 'package:flutter_application/services/crud/notes_service.dart';
import 'package:flutter_application/utilities/dialogs/logout_dialog.dart';
import 'package:flutter_application/views/notes/notes_list_view.dart';

import '../../constants/routes.dart';
// import '../../utilities/show_error_dialog.dart';

class NotesViewPage extends StatefulWidget {
  const NotesViewPage({Key? key}) : super(key: key);
  @override
  _NotesViewPageState createState() => _NotesViewPageState();
}

class _NotesViewPageState extends State<NotesViewPage> {
  late final NotesService _noteService;
  String get userEmail => AuthService.firebase().currentUser!.email!;
  // late final FirebaseCloudStorage _noteService;
  // String get userId => AuthService.firebase().currentUser!.id!;
  @override
  void initState() {
    _noteService = NotesService();
    // _noteService = FirebaseCloudStorage();
    super.initState();
  }

  @override
  void dispose() {
    _noteService.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('(Your Notes)Main UI'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(createOrUpdateNoteRoute);
              },
            ),
            PopupMenuButton(onSelected: (value) async {
              switch (value) {
                case 'Logout':
                  final shouldLogout = await showLogOutDialog(context);
                  if (shouldLogout) {
                    await AuthService.firebase().logOut();
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(loginRoute, (route) => false);
                  }
                  break;
              }
              ;
            }, itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  // value: MenuAction.logout actually
                  value: 'Logout',
                  child: Text('Logout'),
                ),
              ];
            }),
          ],
        ),
        body: FutureBuilder(
          future: _noteService.getOrCreateUser(email: userEmail),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return StreamBuilder(
                    stream: _noteService.allNotes,
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                        case ConnectionState.active:
                          if (snapshot.hasData) {
                            final allNotes =
                                snapshot.data as List<DatabaseNote>;
                            print(allNotes);
                            return NotesListView(
                                notes: allNotes,
                                onDeleteNote: (note) async {
                                  await _noteService.deleteNote(id: note.id);
                                },
                                onTap: (DatabaseNote note) {
                                  Navigator.of(context).pushNamed(
                                    createOrUpdateNoteRoute,
                                    arguments: note,
                                  );
                                });
                            // return const Text('Got all notes.....');
                          } else {
                            return const CircularProgressIndicator();
                          }
                        // return const Text('Waiting for all notes.....');
                        default:
                          return const CircularProgressIndicator();
                      }
                    });
              default:
                return const CircularProgressIndicator();
            }
          },
        )
        // StreamBuilder(
        //   stream: _noteService.allNotes(ownerUserId: userId),
        //   builder: (context, snapshot) {
        //     switch (snapshot.connectionState) {
        //       case ConnectionState.waiting:
        //       case ConnectionState.active:
        //         if (snapshot.hasData) {
        //           final allNotes = snapshot.data as Iterable<CloudNote>;
        //           return NotesListViewPage(
        //             notes: allNotes,
        //             onDeleteNote: (note) async {
        //               await _noteService.deleteNote(documentId: note.documentId);
        //             },
        //             onTap: (CloudNote note) {
        //               Navigator.of(context)
        //                   .pushNamed(createOrUpdateNoteRoute, arguments: note);
        //             },
        //           );
        //           // ListView.builder(
        //           //   itemCount: allNotes.length,
        //           //   itemBuilder: (context, index) {
        //           //     final note = allNotes.elementAt(index);
        //           //     return Text(note.text);
        //           //   },
        //           // );
        //         } else {
        //           return const Text('There are no notes');
        //         }
        //       default:
        //         return const CircularProgressIndicator();
        //     }
        //   },
        // ),
        );
  }
}

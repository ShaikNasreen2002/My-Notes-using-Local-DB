import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application/services/cloud/cloud_exceptions.dart';
import 'package:flutter_application/services/cloud/cloud_storage_constants.dart';

import 'cloud_note.dart';

class FirebaseCloudStorage {
  final notes = FirebaseFirestore.instance.collection('notes');
  Future<void> deleteNote({required String documentId}) async {
    try {
      await notes.doc(documentId).delete();
    } catch (e) {
      throw CouldNotDeleteNoteException();
    }
  }

  Future<void> updateNote(
      {required String documentId, required String text}) async {
    try {
      await notes.doc(documentId).update({textFieldName: text});
    } catch (e) {
      throw CouldNotUpdateNoteException();
    }
  }

  Stream<Iterable<CloudNote>> allNotes({required String ownerUserId}) =>
      notes.snapshots().map(
            (event) => event.docs
                .map((doc) => CloudNote(
                    documentId: doc.id,
                    ownerUserId: doc.data()[ownerUserIdFieldName],
                    text: doc.data()[textFieldName]))
                .where((note) => note.ownerUserId == ownerUserId),
          );
  Future<Iterable<CloudNote>> getNotes({required String ownerUserId}) async {
    try {
      await notes
          .where(ownerUserIdFieldName, isEqualTo: ownerUserId)
          .get()
          .then(
              (value) => value.docs.map((doc) => CloudNote.fromSnapshot(doc)));
      // .then((value) => value.docs.map((doc) => CloudNote(
      //     documentId: doc.id,
      //     ownerUserId: doc.data()[ownerUserIdFieldName],
      //     text: doc.data()[textFieldName])));
    } catch (e) {
      throw CouldNotGetAllNotesException();
    }
    throw UnimplementedError();
  }

  Future<CloudNote> createNewNote({required String ownerUserId}) async {
    final document =
        await notes.add({ownerUserIdFieldName: ownerUserId, textFieldName: ''});
    final fetchedNote = await document.get();
    return CloudNote(
        documentId: fetchedNote.id, ownerUserId: ownerUserId, text: '');
  }

  static final FirebaseCloudStorage _shared =
      FirebaseCloudStorage._sharedInstance();
  FirebaseCloudStorage._sharedInstance();

  factory FirebaseCloudStorage() => _shared;
}

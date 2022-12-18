import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasenotes/src/helpers/storage_helper.dart';
import 'package:firebasenotes/src/helpers/storage_key.dart';
import 'package:firebasenotes/src/models/notes_model.dart';

class NotesRepository {
  createNote(NotesModel notesModel) async {
    String? uid = await StorageHelper.readData(StorageKey.userId.name);
    CollectionReference reference = FirebaseFirestore.instance
        .collection("users")
        .doc("$uid")
        .collection("tasks");
    reference.add(notesModel.toJson());
  }

  Future<QuerySnapshot> getAllNotes() async {
    String? uid = await StorageHelper.readData(StorageKey.userId.name);
    CollectionReference reference = FirebaseFirestore.instance
        .collection("users")
        .doc("$uid")
        .collection("tasks");
    QuerySnapshot snapshot = await reference.get();
    return snapshot;
  }

  editNote(NotesModel updatedTask) async {
    String? uid = await StorageHelper.readData(StorageKey.userId.name);
    CollectionReference reference = FirebaseFirestore.instance
        .collection("users")
        .doc("$uid")
        .collection("tasks");
    reference.doc("${updatedTask.id}").update(updatedTask.toJson());
  }

  deleteNote(NotesModel updatedTask) async {
    String? uid = await StorageHelper.readData(StorageKey.userId.name);
    CollectionReference reference = FirebaseFirestore.instance
        .collection("users")
        .doc("$uid")
        .collection("tasks");
    reference.doc("${updatedTask.id}").delete();
  }
}

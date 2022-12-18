import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebasenotes/src/bloc/notes_bloc/notes_repository.dart';
import 'package:firebasenotes/src/models/notes_model.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesInitial());

  NotesRepository _repository = NotesRepository();

  createNote(NotesModel notesModel) async {
    emit(NotesLoading());
    try {
      await _repository.createNote(notesModel);
      await Future.delayed(Duration(seconds: 2));
      getAllNotes();
      emit(NotesCreateSuccess());
    } catch (ex) {
      emit(NotesCreateError());
    }
  }

  getAllNotes() async {
    emit(NotesLoading());
    try {
      QuerySnapshot snapshot = await _repository.getAllNotes();
      List<NotesModel> notesList = snapshot.docs.map<NotesModel>((e) {
        Map<String, dynamic> dx = e.data() as Map<String, dynamic>;
        String id = e.id;
        NotesModel notesModel = NotesModel.fromJson(dx);
        notesModel.id = id;
        return notesModel;
      }).toList();
      emit(NotesLoadSuccess(notesList));
    } catch (ex) {
      emit(NotesLoadError());
    }
  }

  updateNote(NotesModel updatedTask) async {
    emit(NotesLoading());
    try {
      await _repository.editNote(updatedTask);
      emit(NotesUpdateSuccess());
      await Future.delayed(Duration(seconds: 2));
      getAllNotes();
    } catch (ex) {
      emit(NotesUpdateError());
    }
  }

  deleteNote(NotesModel notesModel) async {
    emit(NotesLoading());

    try {
      await _repository.deleteNote(notesModel);
      emit(NotesDeleteSuccess(notesModel));
      await Future.delayed(Duration(seconds: 2));
      getAllNotes();
    } catch (ex) {
      emit(NotesDeleteError());
    }
  }
}

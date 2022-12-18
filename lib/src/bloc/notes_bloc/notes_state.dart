part of 'notes_cubit.dart';

abstract class NotesState extends Equatable {
  const NotesState();
}

class NotesInitial extends NotesState {
  @override
  List<Object> get props => [];
}

class NotesLoading extends NotesState {
  @override
  List<Object> get props => [];
}

class NotesLoadSuccess extends NotesState {
  final List<NotesModel> notesList;

  NotesLoadSuccess(this.notesList);

  @override
  List<Object> get props => [notesList];
}

class NotesLoadError extends NotesState {
  @override
  List<Object> get props => [];
}

class NotesCreateSuccess extends NotesState {
  @override
  List<Object> get props => [];
}

class NotesCreateError extends NotesState {
  @override
  List<Object> get props => [];
}

class NotesUpdateSuccess extends NotesState {
  @override
  List<Object> get props => [];
}

class NotesUpdateError extends NotesState {
  @override
  List<Object> get props => [];
}

class NotesDeleteSuccess extends NotesState {
  final NotesModel notesModel;

  NotesDeleteSuccess(this.notesModel);

  @override
  List<Object> get props => [notesModel];
}

class NotesDeleteError extends NotesState {
  @override
  List<Object> get props => [];
}

import 'package:firebasenotes/src/bloc/notes_bloc/notes_cubit.dart';
import 'package:firebasenotes/src/models/notes_model.dart';
import 'package:firebasenotes/src/pages/addnote_page.dart';
import 'package:firebasenotes/src/pages/editnote_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotesCubit()..getAllNotes(),
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => AddnotePage()));
            },
            child: Icon(Icons.add),
          ),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text("Note-ify"),
            centerTitle: true,
            backgroundColor: Colors.blue,
          ),
          body: BlocBuilder<NotesCubit, NotesState>(
            builder: (context, state) {
              if (state is NotesLoading) {
                return CircularProgressIndicator();
              } else if (state is NotesLoadSuccess) {
                return _buildTaskUI(state.notesList);
              } else if (state is NotesLoadError) {
                return Text("error");
              } else {
                return CircularProgressIndicator();
              }
              return Text("");
            },
          )),
    );
  }

  _buildTaskUI(List<NotesModel> notesList) {
    return ListView.builder(
        itemCount: notesList.length,
        itemBuilder: (context, index) {
          NotesModel item = notesList[index];
          return Card(
            elevation: 10,
            child: ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title),
                  Text(item.description),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                EditnotePage(notesModel: item)));
                      },
                      icon: Icon(Icons.edit)),
                  IconButton(
                      onPressed: () {
                        context.read<NotesCubit>().deleteNote(item);
                      },
                      icon: Icon(Icons.delete))
                ],
              ),
            ),
          );
        });
  }
}

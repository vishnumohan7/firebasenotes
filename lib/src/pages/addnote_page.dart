import 'package:firebasenotes/src/bloc/notes_bloc/notes_cubit.dart';
import 'package:firebasenotes/src/models/notes_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddnotePage extends StatefulWidget {
  const AddnotePage({Key? key}) : super(key: key);

  @override
  State<AddnotePage> createState() => _AddnotePageState();
}

class _AddnotePageState extends State<AddnotePage> {
  TextEditingController _titleConrtoller = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotesCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add New Note"),
          centerTitle: true,
        ),
        body: Form(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _titleConrtoller,
                  decoration: InputDecoration(labelText: "Title"),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: "Description"),
                ),
                SizedBox(
                  height: 15,
                ),
                BlocConsumer<NotesCubit, NotesState>(
                  listener: (context, state) {
                    if (state is NotesCreateSuccess) {
                      Navigator.pop(context);
                    } else if (state is NotesCreateError) {
                      Fluttertoast.showToast(
                          msg: "Error Creating a Note",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    if (state is NotesLoading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return ElevatedButton(
                        onPressed: () {
                          NotesModel notesModel = NotesModel(
                              title: _titleConrtoller.text,
                              description: _descriptionController.text);
                          context.read<NotesCubit>().createNote(notesModel);
                        },
                        child: Text("Add Note"));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:firebasenotes/src/bloc/notes_bloc/notes_cubit.dart';
import 'package:firebasenotes/src/models/notes_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditnotePage extends StatefulWidget {
  final NotesModel notesModel;

  const EditnotePage({Key? key, required this.notesModel}) : super(key: key);

  @override
  State<EditnotePage> createState() => _EditnotePageState();
}

class _EditnotePageState extends State<EditnotePage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    _titleController.text = widget.notesModel.title;
    _descriptionController.text = widget.notesModel.description;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotesCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Edit Note"),
          centerTitle: true,
        ),
        body: Form(
          child: Column(
            children: [
              TextFormField(
                onChanged: (value) {
                  widget.notesModel.title = value;
                },
                controller: _titleController,
                decoration: InputDecoration(labelText: "Title"),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                onChanged: (value) {
                  widget.notesModel.description = value;
                },
                controller: _descriptionController,
                decoration: InputDecoration(labelText: "Description"),
              ),
              SizedBox(
                height: 15,
              ),
              BlocConsumer<NotesCubit, NotesState>(
                listener: (context, state) {
                  if (state is NotesUpdateSuccess) {
                    Navigator.pop(context);
                  } else if (state is NotesUpdateError) {
                    Fluttertoast.showToast(
                        msg: "Error Updating Task",
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
                        context
                            .read<NotesCubit>()
                            .updateNote(widget.notesModel);
                      },
                      child: Text("Update"));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

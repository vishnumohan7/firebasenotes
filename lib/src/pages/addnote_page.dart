import 'package:firebasenotes/src/bloc/notes_bloc/notes_cubit.dart';
import 'package:firebasenotes/src/models/notes_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

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
        backgroundColor: Color.fromRGBO(31, 29, 43, 1),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(31, 29, 43, 1),
          title: Text("Add New Note",style: GoogleFonts.montserratAlternates(fontSize: 16),),
          centerTitle: true,
        ),
        body: Form(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _titleConrtoller,
                  decoration: InputDecoration(labelText: "Title", labelStyle: GoogleFonts.mulish(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: BorderSide(
                      color: Colors.white
                    )
                  )),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: "Description", labelStyle: GoogleFonts.mulish(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide(
                              color: Colors.white
                          )
                      )),
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
                        },style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color.fromRGBO(111, 111, 200, 1))
                    ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 100.0,right: 100,top: 10,bottom: 10),
                          child: Text("Add Note"),
                        ));
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

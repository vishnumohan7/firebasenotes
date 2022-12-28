import 'package:firebasenotes/src/bloc/notes_bloc/notes_cubit.dart';
import 'package:firebasenotes/src/models/notes_model.dart';
import 'package:firebasenotes/src/pages/addnote_page.dart';
import 'package:firebasenotes/src/pages/editnote_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

enum SampleItem { itemOne, itemTwo }

class _HomePageState extends State<HomePage> {
  SampleItem? selectedMenu;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotesCubit()..getAllNotes(),
      child: Scaffold(
          backgroundColor: Color.fromRGBO(31, 29, 43, 1),
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddnotePage()));
              },
              backgroundColor: Color.fromRGBO(111, 111, 200, 1),
              child: Icon(Icons.add_box_outlined)),
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(31, 29, 43, 1),
            automaticallyImplyLeading: false,
            title: Text(
              "Notes",
              style: GoogleFonts.montserratAlternates(
                  fontSize: 24, fontWeight: FontWeight.w600),
            ),
            centerTitle: false,
          ),
          body: BlocBuilder<NotesCubit, NotesState>(
            builder: (context, state) {
              if (state is NotesLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is NotesLoadSuccess) {
                return _buildTaskUI(state.notesList, context);
              } else if (state is NotesLoadError) {
                return Text("error");
              } else {
                return Center(child: CircularProgressIndicator());
              }
              return Text("");
            },
          )),
    );
  }

  _buildTaskUI(List<NotesModel> notesList, context) {
    return ListView.builder(
        itemCount: notesList.length,
        itemBuilder: (context, index) {
          NotesModel items = notesList[index];
          return Card(
            elevation: 10,
            color: Color.fromRGBO(59, 59, 78, 1),
            shadowColor: Color.fromRGBO(59, 59, 78, 1),
            child: ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    items.title,
                    style: GoogleFonts.montserratAlternates(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    items.description,
                    style: GoogleFonts.mulish(
                      fontSize: 12,
                      color: Color.fromRGBO(237, 237, 255, .6),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  // Row(
                  //   mainAxisSize: MainAxisSize.min,
                  //   children: [
                  //     IconButton(
                  //         onPressed: () {
                  //           Navigator.of(context).push(MaterialPageRoute(
                  //               builder: (context) =>
                  //                   EditnotePage(notesModel: item)));
                  //         },
                  //         icon: Icon(Icons.edit)),
                  //     IconButton(
                  //         onPressed: () {
                  //           context.read<NotesCubit>().deleteNote(item);
                  //         },
                  //         icon: Icon(Icons.delete))
                  //   ],
                  // ),
                ],
              ),
              trailing: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return PopupMenuButton<SampleItem>(
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                  initialValue: selectedMenu,
                  // Callback that sets the selected popup menu item.
                  onSelected: (SampleItem item) {
                    setState(() {
                      selectedMenu = item;
                    });
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<SampleItem>>[
                    PopupMenuItem<SampleItem>(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                EditnotePage(notesModel: items)));
                        //   setState(() {
                        //
                        //   });
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) =>
                        //         EditnotePage(notesModel: item)));
                      },
                      value: SampleItem.itemOne,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      EditnotePage(notesModel: items)));
                            },
                            icon: Icon(Icons.edit),
                          ),
                          Text(
                            "Edit Note",
                            style: GoogleFonts.mulish(
                                fontSize: 12, fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                    ),
                    PopupMenuItem<SampleItem>(
                      onTap: () {
                        context.read<NotesCubit>().deleteNote(items);
                      },
                      value: SampleItem.itemTwo,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(onPressed: (){
                            context.read<NotesCubit>().deleteNote(items);
                          }, icon: Icon(Icons.delete)),
                          Text(
                            "Delete Note",
                            style: GoogleFonts.mulish(
                                fontSize: 12, fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),
          );
        });
  }
}

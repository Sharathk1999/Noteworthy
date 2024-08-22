import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:noteworthy/feature/domain/entities/note_entity.dart';
import 'package:noteworthy/feature/presentation/cubit/note/note_cubit.dart';
import 'package:noteworthy/feature/presentation/widgets/common_widget.dart';

class AddNewNotePage extends StatefulWidget {
  final String uid;
  const AddNewNotePage({super.key, required this.uid});

  @override
  State<AddNewNotePage> createState() => _AddNewNotePageState();
}

class _AddNewNotePageState extends State<AddNewNotePage> {
  final TextEditingController _noteController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldGlobalKey =
      GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _noteController.addListener(
      () {
        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _noteController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldGlobalKey,
      appBar: AppBar(
        title: const Text("Add your notes"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${DateFormat("dd MMM hh:mm a").format(DateTime.now())} | ${_noteController.text.length} Characters",
              style:
                  TextStyle(fontSize: 14, color: Colors.black.withOpacity(.5)),
            ),
            Expanded(
              child: Scrollbar(
                child: TextFormField(
                  controller: _noteController,
                  maxLines: null,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "start writing your notes 📝"),
                ),
              ),
            ),
            InkWell(
              onTap: _submitNote,
              child: Container(
                height: 45,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "Save",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitNote() {
    if (_noteController.text.isEmpty) {
      snackBarError(scaffoldState: _scaffoldGlobalKey, msg: "write a note");
      return;
    }

    BlocProvider.of<NoteCubit>(context).addNote(
      note: NoteEntity(
        note: _noteController.text,
        time: Timestamp.now(),
        uid: widget.uid,
      ),
    );

    Future.delayed(const Duration(seconds: 1), () {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    });
  }
}

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:noteworthy/app_const.dart';
import 'package:noteworthy/feature/presentation/cubit/auth/auth_cubit.dart';
import 'package:noteworthy/feature/presentation/cubit/note/note_cubit.dart';

class HomePage extends StatefulWidget {
  final String uid;
  const HomePage({super.key, required this.uid});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<NoteCubit>(context).getNotes(uid: widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              'Noteworthy',
              textStyle: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
              speed: const Duration(milliseconds: 100),
            ),
          ],
          totalRepeatCount: 2,
          pause: const Duration(milliseconds: 100),
          displayFullTextOnTap: true,
          stopPauseOnTap: true,
        ),
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<AuthCubit>(context).loggedOut();
            },
            icon: const HugeIcon(
              icon: HugeIcons.strokeRoundedLogout02,
              color: Colors.blueGrey,
              size: 30.0,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const HugeIcon(
          icon: HugeIcons.strokeRoundedTaskAdd01,
          color: Colors.blueGrey,
          size: 30.0,
        ),
        onPressed: () {
          Navigator.pushNamed(context, PageConst.addNotePage,
              arguments: widget.uid);
        },
      ),
      body: BlocBuilder<NoteCubit, NoteState>(
        builder: (context, noteState) {
          if (noteState is NoteLoaded) {
            return _bodyWidget(noteState);
          }
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.amberAccent,
          ));
        },
      ),
    );
  }

  Widget _bodyWidget(NoteLoaded noteLoadedState) {
    return Column(
      children: [
        Expanded(
          child: noteLoadedState.notes.isEmpty
              ? _noNotesYetWidget()
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 1.2),
                  itemCount: noteLoadedState.notes.length,
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, PageConst.updateNotePage,
                            arguments: noteLoadedState.notes[index]);
                      },
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Confirm delete"),
                              content: const Text(
                                  "Are you sure you want to delete this note."),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    
                                    BlocProvider.of<NoteCubit>(context).deleteNote(note: noteLoadedState.notes[index]);
                              Navigator.pop(context);
                                  },
                                  child: const Text("Yes"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "No",
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(.2),
                                  blurRadius: 2,
                                  spreadRadius: 2,
                                  offset: const Offset(0, 1.5))
                            ]),
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // AnimatedTextKit(
                            //   animatedTexts: [
                            //     TypewriterAnimatedText(
                            //       '${noteLoadedState.notes[index].note}',
                            //       textStyle: const TextStyle(
                            //         overflow: TextOverflow.ellipsis,
                            //         fontWeight: FontWeight.bold,
                            //       ),
                            //       speed: const Duration(milliseconds: 100),
                            //     ),
                            //   ],
                            //   totalRepeatCount: 2,
                            //   pause: const Duration(milliseconds: 100),
                            //   displayFullTextOnTap: true,
                            //   stopPauseOnTap: true,
                            // ),
                            
                            Text(
                              "${noteLoadedState.notes[index].note}",
                              maxLines: 6,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              DateFormat("dd MMM yyy hh:mm a").format(
                                noteLoadedState.notes[index].time!.toDate(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _noNotesYetWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 60,
            child: Image.asset("assets/note_png.png"),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text("Looks like noteworthy is empty.")
        ],
      ),
    );
  }
}

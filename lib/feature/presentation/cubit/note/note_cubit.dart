// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteworthy/feature/domain/entities/note_entity.dart';
import 'package:noteworthy/feature/domain/use_cases/add_new_note_usecase.dart';
import 'package:noteworthy/feature/domain/use_cases/delete_note_usecase.dart';
import 'package:noteworthy/feature/domain/use_cases/get_notes_usecase.dart';
import 'package:noteworthy/feature/domain/use_cases/update_note_usecase.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  final UpdateNoteUseCase updateNoteUseCase;
  final DeleteNoteUseCase deleteNoteUseCase;
  final GetNoteUseCase getNoteUseCase;
  final AddNewNoteUseCase addNewNoteUseCase;
  NoteCubit({
    required this.updateNoteUseCase,
    required this.deleteNoteUseCase,
    required this.getNoteUseCase,
    required this.addNewNoteUseCase,
  }) : super(NoteInitial());

  Future<void> addNote({required NoteEntity note}) async {
    try {
      await addNewNoteUseCase.call(note);
    } on SocketException catch (_) {
      emit(NoteFailure());
    } catch (_) {
      emit(NoteFailure());
    }
  }

  Future<void> deleteNote({required NoteEntity note}) async {
    try {
      await deleteNoteUseCase.call(note);
    } on SocketException catch (_) {
      emit(NoteFailure());
    } catch (_) {
      emit(NoteFailure());
    }
  }

  Future<void> updateNote({required NoteEntity note}) async {
    try {
      await updateNoteUseCase.call(note);
    } on SocketException catch (_) {
      emit(NoteFailure());
    } catch (_) {
      emit(NoteFailure());
    }
  }

  Future<void> getNotes({required String uid}) async {
    try {
      getNoteUseCase.call(uid).listen(
        (notes) {
          emit(NoteLoaded(notes: notes));
        },
      );
    } on SocketException catch (_) {
      emit(NoteFailure());
    } catch (_) {
      emit(NoteFailure());
    }
  }
}

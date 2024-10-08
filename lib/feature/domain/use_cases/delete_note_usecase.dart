

import 'package:noteworthy/feature/domain/entities/note_entity.dart';
import 'package:noteworthy/feature/domain/repositories/firebase_repository.dart';

class DeleteNoteUseCase {
  final FirebaseRepository repository;

  DeleteNoteUseCase({required this.repository});

  Future<void> call(NoteEntity note)async{
    return repository.deleteNote(note);
  }
}
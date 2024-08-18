import 'package:noteworthy/feature/domain/entities/note_entity.dart';
import 'package:noteworthy/feature/domain/repositories/firebase_repository.dart';

class AddNewTaskUseCase {
  final FirebaseRepository repository;

  AddNewTaskUseCase({required this.repository});

  Future<void> call(NoteEntity noteEntity)async{
    return repository.addNewNote(noteEntity);
  }
}
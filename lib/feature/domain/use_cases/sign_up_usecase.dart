import 'package:noteworthy/feature/domain/entities/user_entity.dart';
import 'package:noteworthy/feature/domain/repositories/firebase_repository.dart';

class SignUpUseCase {
  final FirebaseRepository repository;

  SignUpUseCase({required this.repository});

  Future<void> call(UserEntity user)async{
    return repository.signUp(user);
  }
}
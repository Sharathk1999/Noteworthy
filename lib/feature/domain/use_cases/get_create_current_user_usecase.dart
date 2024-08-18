


import 'package:noteworthy/feature/domain/entities/user_entity.dart';
import 'package:noteworthy/feature/domain/repositories/firebase_repository.dart';

class GetCreateCurrentUserUseCase {
  final FirebaseRepository repository;

  GetCreateCurrentUserUseCase({required this.repository});

  Future<void> call(UserEntity user)async{
    return repository.getCreateCurrentUser(user);
  }
}
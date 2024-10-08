

import 'package:noteworthy/feature/domain/repositories/firebase_repository.dart';

class GetCurrentUidUseCase {
  final FirebaseRepository repository;

  GetCurrentUidUseCase({required this.repository});

  Future<String> call()async{
    return repository.getCurrentUID();
  }
}
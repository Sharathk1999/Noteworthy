import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:noteworthy/feature/data/remote/data_source/firebase_remote_data_source.dart';
import 'package:noteworthy/feature/data/remote/data_source/firebase_remote_data_source_impl.dart';
import 'package:noteworthy/feature/data/repositories/firebase_repository_impl.dart';
import 'package:noteworthy/feature/domain/repositories/firebase_repository.dart';
import 'package:noteworthy/feature/domain/use_cases/add_new_note_usecase.dart';
import 'package:noteworthy/feature/domain/use_cases/delete_note_usecase.dart';
import 'package:noteworthy/feature/domain/use_cases/get_create_current_user_usecase.dart';
import 'package:noteworthy/feature/domain/use_cases/get_current_uid_usecase.dart';
import 'package:noteworthy/feature/domain/use_cases/get_notes_usecase.dart';
import 'package:noteworthy/feature/domain/use_cases/is_sign_in_usecase.dart';
import 'package:noteworthy/feature/domain/use_cases/sign_in_usecase.dart';
import 'package:noteworthy/feature/domain/use_cases/sign_out_usecase.dart';
import 'package:noteworthy/feature/domain/use_cases/sign_up_usecase.dart';
import 'package:noteworthy/feature/domain/use_cases/update_note_usecase.dart';
import 'package:noteworthy/feature/presentation/cubit/auth/auth_cubit.dart';
import 'package:noteworthy/feature/presentation/cubit/note/note_cubit.dart';
import 'package:noteworthy/feature/presentation/cubit/user/user_cubit.dart';

GetIt dI = GetIt.instance;

Future<void> init() async {
  //cubit
  dI.registerFactory<AuthCubit>(
    () => AuthCubit(
      getCurrentUidUseCase: dI.call(),
      isSignInUseCase: dI.call(),
      signOutUseCase: dI.call(),
    ),
  );

  dI.registerFactory<UserCubit>(
    () => UserCubit(
      signInUseCase:  dI.call(),
      signUpUseCase:  dI.call(),
      getCreateCurrentUserUseCase:  dI.call(),
    ),
  );
  
  dI.registerFactory<NoteCubit>(
    () => NoteCubit(
      updateNoteUseCase: dI.call(),
      deleteNoteUseCase: dI.call(),
      getNoteUseCase: dI.call(),
      addNewNoteUseCase: dI.call(),
    ),
  );

  //useCase
  dI.registerLazySingleton<AddNewNoteUseCase>(
    () => AddNewNoteUseCase(repository: dI.call()),
  );

  dI.registerLazySingleton<DeleteNoteUseCase>(
    () => DeleteNoteUseCase(repository: dI.call()),
  );

  dI.registerLazySingleton<GetCreateCurrentUserUseCase>(
    () => GetCreateCurrentUserUseCase(repository: dI.call()),
  );

  dI.registerLazySingleton<GetCurrentUidUseCase>(
    () => GetCurrentUidUseCase(repository: dI.call()),
  );
  dI.registerLazySingleton<GetNoteUseCase>(
    () => GetNoteUseCase(repository: dI.call()),
  );
  dI.registerLazySingleton<IsSignInUseCase>(
    () => IsSignInUseCase(repository: dI.call()),
  );
  dI.registerLazySingleton<SignInUseCase>(
    () => SignInUseCase(repository: dI.call()),
  );
  dI.registerLazySingleton<SignUpUseCase>(
    () => SignUpUseCase(repository: dI.call()),
  );
  dI.registerLazySingleton<SignOutUseCase>(
    () => SignOutUseCase(repository: dI.call()),
  );

  dI.registerLazySingleton<UpdateNoteUseCase>(
    () => UpdateNoteUseCase(repository: dI.call()),
  );

  //repository
  dI.registerLazySingleton<FirebaseRepository>(
    () => FirebaseRepositoryImpl(remoteDataSource: dI.call()),
  );

  //data source
  dI.registerLazySingleton<FirebaseRemoteDataSource>(
    () => FirebaseRemoteDataSourceImpl(auth: dI.call(), firestore: dI.call()),
  );

  //external
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  dI.registerLazySingleton(
    () => auth,
  );
  dI.registerLazySingleton(
    () => fireStore,
  );
}

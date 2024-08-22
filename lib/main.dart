import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteworthy/feature/presentation/cubit/auth/auth_cubit.dart';
import 'package:noteworthy/feature/presentation/cubit/note/note_cubit.dart';
import 'package:noteworthy/feature/presentation/cubit/user/user_cubit.dart';
import 'package:noteworthy/feature/presentation/pages/home_page.dart';
import 'package:noteworthy/feature/presentation/pages/sign_in_page.dart';
import 'package:noteworthy/on_generate_route.dart';

import 'firebase_options.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (_) => di.dI<AuthCubit>()..appStarted(),),
        BlocProvider<UserCubit>(create: (_) => di.dI<UserCubit>(),),
        BlocProvider<NoteCubit>(create: (_) => di.dI<NoteCubit>(),),
        
      ],
      child: MaterialApp(
        title: 'NoteWorthy',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
          useMaterial3: true,
        ),
        initialRoute: '/',
        onGenerateRoute:OnGenerateRoute.route ,
        routes: {
          "/": (context){
            return BlocBuilder<AuthCubit, AuthState>(builder: (context, authState) {
              if (authState is AuthenticatedState) {
                return  HomePage(uid: authState.uid,);
              }
              if (authState is UnAuthenticatedState) {
                return const SignInPage();
              }
              return const CircularProgressIndicator();
            },);
          }
        },
      ),
    );
  }
}


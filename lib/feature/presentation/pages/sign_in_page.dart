import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteworthy/app_const.dart';
import 'package:noteworthy/feature/domain/entities/user_entity.dart';
import 'package:noteworthy/feature/presentation/cubit/auth/auth_cubit.dart';
import 'package:noteworthy/feature/presentation/cubit/user/user_cubit.dart';
import 'package:noteworthy/feature/presentation/pages/home_page.dart';
import 'package:noteworthy/feature/presentation/widgets/common_widget.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldGlobalKey =
      GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldGlobalKey,
      body: BlocConsumer<UserCubit, UserState>(
        builder: (context, userState) {
          if (userState is UserSuccess) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                if (authState is AuthenticatedState) {
                  return  HomePage(uid: authState.uid,);
                } else {
                  return _bodyWidget();
                }
              },
            );
          }

          return _bodyWidget();
        },
        listener: (context, userState) {
          if (userState is UserSuccess) {
            BlocProvider.of<AuthCubit>(context).loggedIn();
          }
          if (userState is UserFailure) {
            snackBarError(
              msg: "Invalid email",
              scaffoldState: _scaffoldGlobalKey,
            );
          }
        },
      ),
    );
  }

  _bodyWidget() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 30,
          ),
          Container(
            height: 120,
            child: Image.asset("assets/note_png.png"),
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.blueGrey.withOpacity(.1),
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: 'Enter your email',
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.blueGrey.withOpacity(.1),
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                hintText: 'Enter your password',
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              submitSignIn();
            },
            child: Container(
              height: 45,
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(.5),
                borderRadius: const BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              child: const Text(
                "Login",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                PageConst.signUpPage,
                (route) => false,
              );
            },
            child: Container(
              height: 45,
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(.8),
                borderRadius: const BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              child: const Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void submitSignIn() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      BlocProvider.of<UserCubit>(context).submitSignIn(
          user: UserEntity(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      ));
    }
  }
}

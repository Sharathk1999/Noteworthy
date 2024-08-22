

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteworthy/app_const.dart';
import 'package:noteworthy/feature/domain/entities/user_entity.dart';
import 'package:noteworthy/feature/presentation/cubit/auth/auth_cubit.dart';
import 'package:noteworthy/feature/presentation/cubit/user/user_cubit.dart';
import 'package:noteworthy/feature/presentation/pages/home_page.dart';
import 'package:noteworthy/feature/presentation/widgets/common_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

   final TextEditingController _userNameController = TextEditingController();
   final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldGlobalKey = GlobalKey<ScaffoldState>();


@override
  void dispose() {
    super.dispose();
    _userNameController.dispose();
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
           GestureDetector(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(context, PageConst.signInPage, (route) => false,);
            },
            child: Container(
              height: 50,
              width: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black.withOpacity(.5)),
                shape: BoxShape.circle,
              ),
              child: const Icon(CupertinoIcons.chevron_back),
            ),
           ),
           const SizedBox(
            height: 30,
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
              controller: _userNameController,
              decoration: const InputDecoration(
                hintText: 'Your name',
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 10,),
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
                hintText: 'Enter email',
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 10,),
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
                hintText: 'Enter password',
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 20,),
          GestureDetector(
            onTap: () {
              submitSignUp();
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
                "New Account",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10,),
      
        ],
      ),
    );

  }
  
  void submitSignUp() {
    if (_userNameController.text.isNotEmpty && _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      BlocProvider.of<UserCubit>(context).submitSignUp(
          user: UserEntity(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      ));
    }
  }
}
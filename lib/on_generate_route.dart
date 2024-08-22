


import 'package:flutter/material.dart';
import 'package:noteworthy/app_const.dart';
import 'package:noteworthy/feature/domain/entities/note_entity.dart';
import 'package:noteworthy/feature/presentation/pages/add_new_note_page.dart';
import 'package:noteworthy/feature/presentation/pages/sign_in_page.dart';
import 'package:noteworthy/feature/presentation/pages/sign_up_page.dart';
import 'package:noteworthy/feature/presentation/pages/update_note_page.dart';

class OnGenerateRoute {
  static Route<dynamic> route(RouteSettings settings){
    final args =  settings.arguments;
    switch (settings.name) {
      case PageConst.signInPage:{
        return materialPageBuilder(widget:const SignInPage());
        
      }
      case PageConst.signUpPage:{
        return materialPageBuilder(widget:const SignUpPage());
        
      }
      case PageConst.addNotePage:{
       if (args is String) {
          return materialPageBuilder(widget:AddNewNotePage(uid: args,));
       }else{
        return materialPageBuilder(widget: const ErrorPage());
       }
        
      }
      case PageConst.updateNotePage:{
       if (args is NoteEntity) {
          return materialPageBuilder(widget:UpdateNotePage(noteEntity: args,));
       }else{
        return materialPageBuilder(widget: const ErrorPage());
       }
        
      }
      
      default:
      return materialPageBuilder(widget:const ErrorPage());
    }
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Oops..!"),
      ),
      body: const Center(
        child: Text("Error..."),
      ),
    );
  }
}

MaterialPageRoute materialPageBuilder({required Widget widget}){
  return MaterialPageRoute(builder: (_) => widget,);
}
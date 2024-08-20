


import 'package:flutter/material.dart';
import 'package:noteworthy/app_const.dart';

class OnGenerateRoute {
  static Route<dynamic> route(RouteSettings settings){
    switch (settings.name) {
      case PageConst.addNotePage:{
        return materialPageBuilder(widget:const ErrorPage());
        
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
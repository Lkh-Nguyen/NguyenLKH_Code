import 'package:flutter/material.dart';

PageRouteBuilder<dynamic> createSlideTransitions({required Widget newPage,required RouteSettings settings}){
  return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context,animation,secondaryAnimation) => newPage,
      transitionsBuilder: (context,animation,secondaryAnimation,child){
        const begin = Offset(1.0,0.0);
        const end = Offset(0.0,0.0);
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin,end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );

      }
  );
}
import 'package:flutter/material.dart';
import 'package:notoro/views/home/home_view.dart';

class AppConst {
  static const List<Widget> screens = [
    HomeView(),
    Center(child: Text('Trening')),
    Center(child: Text('Historia')),
    Center(child: Text('Ustawienia')),
  ];
}

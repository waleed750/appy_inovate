import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'my_app.dart';
import 'my_observer.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

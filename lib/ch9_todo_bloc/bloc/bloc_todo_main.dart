import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lab/ch9_todo_bloc/bloc/blocs/todosBloc.dart';
import 'screens/home_screen.dart';


void main() => runApp(TodosApp());

class TodosApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //add.................................
    ThemeData theme = ThemeData();
    return BlocProvider<TodosBloc>(
      create: (context) => TodosBloc(),
      child: MaterialApp(
        title: 'Todos',
        theme: theme.copyWith(colorScheme: theme.colorScheme.copyWith(
            primary: Colors.blue, secondary: Colors.red)),
        home: HomeScreen(),
      ),

    );
  }
}
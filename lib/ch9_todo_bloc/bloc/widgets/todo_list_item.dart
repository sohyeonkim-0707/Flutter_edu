import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/todosBloc.dart';
import '../events/events.dart';
import '../states/todosState.dart';

class TodoListItem extends StatelessWidget {
  final Todo todo;

  TodoListItem({required this.todo});

  @override
  Widget build(BuildContext context) {
    //add.....................
    TodosBloc todosBloc = BlocProvider.of<TodosBloc>(context);
    return BlocBuilder<TodosBloc, TodosState>(
        builder: (context, data){
          return ListTile(
            leading: Checkbox(
              value: todo.completed,
              onChanged: (bool? checked){
                //bloc 에 이벤트를 발생시킨다..
                todosBloc.add(ToggleCompletedTodoEvent(todo));
              },
            ),
            title: Text(todo.title),
            trailing: IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: (){
                //이벤트 발생..
                todosBloc.add(DeleteTodoEvent(todo));
              },
            ),
          );
        }
    );
  }
}

import 'package:bloc/bloc.dart';
import '../events/events.dart';
import '../states/todosState.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState>{
  //생성자 선언하면서 상위 생성자에 상태 초기값..
  TodosBloc(): super(TodosState([])){
    //발생한 이벤트 식별해서.. 상태 유지...
    //emit 함수는 상태 발행..
    on<AddTodoEvent>((event, emit){
      List<Todo> newTodos = List.from(state.todos)
          ..add(event.todo);
      emit(TodosState(newTodos));
    });
    on<DeleteTodoEvent>((event, emit){
      List<Todo> newTodos = List.from(state.todos)
          ..remove(event.todo);
      emit(TodosState(newTodos));
    });
    on<ToggleCompletedTodoEvent>((event, emit){
      List<Todo> newTodos = List.from(state.todos);
      int index = newTodos.indexOf(event.todo);
      newTodos[index].toggleCompleted();
      emit(TodosState(newTodos));
    });
  }

  @override
  void onTransition(Transition<TodosEvent, TodosState> transition) {
    super.onTransition(transition);
    print(transition);
  }
  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    print('$error, $stackTrace');
  }
}
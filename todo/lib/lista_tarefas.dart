import 'package:flutter/material.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/widgets/todo_list_page.dart';

class ListaTarefas extends StatefulWidget {
  ListaTarefas({Key? key}) : super(key: key);

  @override
  State<ListaTarefas> createState() => _ListaTarefasState();
}

class _ListaTarefasState extends State<ListaTarefas> {
  final TextEditingController todoController = TextEditingController();

  List<Todo> Tarefas = [];
  Todo? deletedTodo;
  int? deletedTodopos;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: todoController,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        labelText: 'Adicione uma Tarefa',
                        hintText: 'Ex. Estudar Flutter',
                        border: OutlineInputBorder()),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                ElevatedButton(
                    onPressed: () {
                      String text = todoController.text;
                      setState(() {
                        Todo NewTodo =
                            Todo(title: text, dateTime: DateTime.now());
                        Tarefas.add(NewTodo);
                      });
                      todoController.clear();
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xff00d7f3),
                        padding: EdgeInsets.all(16)),
                    child: Icon(
                      Icons.add,
                      size: 30,
                    ))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Flexible(
              child: ListView(shrinkWrap: true, children: [
                for (Todo todo in Tarefas)
                  TodoListItem(todo: todo, onDelete: onDelete)
              ]),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                    child: Text(
                        "Voce possui ${Tarefas.length} tarefas pendentes")),
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(10),
                        primary: Color(0xff00d7f3)),
                    child: Text('Limpar tudo'))
              ],
            )
          ]),
        ),
      )),
    );
  }

  void onDelete(Todo todo) {
    deletedTodo = todo;
    deletedTodopos = Tarefas.indexOf(todo);

    setState(() {
      Tarefas.remove(todo);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        "Tarefa ${todo.title} foi removida com sucesso",
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Color(0xff00d7f3),
      action: SnackBarAction(
          label: "Desfazer",
          textColor: Colors.white,
          onPressed: () {
            setState(() {
              Tarefas.insert(deletedTodopos!, deletedTodo!);
            });
          }),
      duration: Duration(seconds: 5),
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:todo/lista_tarefas.dart';
import 'package:todo/widgets/todo_list_page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ListaTarefas(),
  ));
}

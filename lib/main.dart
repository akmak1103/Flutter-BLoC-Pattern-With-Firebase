import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/book_bloc.dart';
// import 'bloc/crud_bloc.dart';
import 'homePage.dart';

void main() {
  runApp(
    MyApp(),
  );
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<BookBloc>(
      create: (context) => BookBloc()..add(LoadBooks()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bloc Pattern in Flutter',
        home: HomePage(),
      ),
    );
  }
}

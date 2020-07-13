import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_pattern/bloc/book_bloc.dart';
// import 'bloc/crud_bloc.dart';
import 'models/book.dart';
// import 'models/record.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController authorController = TextEditingController();

  bool newBook = true;
  String _id = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Bloc with Firebase'),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: titleController,
                decoration: InputDecoration(hintText: 'Book Title (Unique)'),
              ),
              TextField(
                controller: authorController,
                decoration: InputDecoration(hintText: 'Book Author'),
              ),
              MaterialButton(
                color: Colors.black,
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  newBook
                      ? BlocProvider.of<BookBloc>(context).add(AddBookEvent(
                          Book(
                              title: titleController.text,
                              author: authorController.text)))
                      : BlocProvider.of<BookBloc>(context).add(UpdateBookEvent(
                          Book(
                              title: titleController.text,
                              id: _id,
                              author: authorController.text)));
                  setState(() {
                    titleController.text = '';
                    authorController.text = '';
                    newBook = true;
                  });
                },
              ),
              BlocBuilder<BookBloc, BookState>(builder: (context, state) {
                if (state is BooksLoaded) {
                  List<Book> books = state.books;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('Title: ' + books[index].title),
                        subtitle: Text('Author: ' + books[index].author),
                        trailing: SizedBox(
                          width: 96,
                          child: Row(
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  setState(() {
                                    titleController.text = books[index].title;
                                    authorController.text = books[index].author;
                                    _id = books[index].id;
                                    newBook = false;
                                  });
                                },
                              ),
                              IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () =>
                                      BlocProvider.of<BookBloc>(context).add(
                                          DeleteBookEvent(books[index].id)))
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: books.length,
                  );
                } else
                  return CircularProgressIndicator();
              }),
            ],
          ),
        ),
      ),
    );
  }
}

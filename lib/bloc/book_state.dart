part of 'book_bloc.dart';

abstract class BookState extends Equatable {
  const BookState();
  @override
  List<Object> get props => [];
}

class BooksLoading extends BookState {
  @override
  List<Object> get props => [];
}

class BooksLoaded extends BookState {
  final List<Book> books;
  BooksLoaded(this.books);
  @override
  List<Object> get props => [books];
}

class BooksNotLoaded extends BookState{}
part of 'book_bloc.dart';

abstract class BookEvent extends Equatable {
  const BookEvent();
  @override
  @override
  List<Object> get props => [];
}

class LoadBooks extends BookEvent {}

class AddBookEvent extends BookEvent {
  final Book book;
  AddBookEvent(this.book);

  @override
  List<Object> get props => [book];
}

class UpdateBookEvent extends BookEvent {
  final Book book;
  UpdateBookEvent(this.book);

  @override
  List<Object> get props => [book];
}

class DeleteBookEvent extends BookEvent {
  final String id;
  DeleteBookEvent(this.id);

  @override
  List<Object> get props => [id];
}

class BooksUpdated extends BookEvent {
  final List<Book> books;

  BooksUpdated(this.books);
  @override
  List<Object> get props => [books];
}
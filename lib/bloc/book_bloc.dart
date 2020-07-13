import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/book.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

part 'book_event.dart';
part 'book_state.dart';

CollectionReference booksCollection = Firestore.instance.collection('books');

class BookBloc extends Bloc<BookEvent, BookState> {
  BookBloc() : super(BooksLoading());

  StreamSubscription _booksSubscription;

  @override
  Stream<BookState> mapEventToState(
    BookEvent event,
  ) async* {
    if (event is LoadBooks) {
      yield* _mapLoadBooksToState();
    } else if (event is AddBookEvent) {
      yield* _mapAddBookEventToState(event);
    } else if (event is UpdateBookEvent) {
      yield* _mapUpdateBookEventToState(event);
    } else if (event is DeleteBookEvent) {
      yield* _mapDeleteBookEventToState(event);
    } else if (event is BooksUpdated) {
      yield* _mapBooksUpdateToState(event);
    }
  }

  Stream<BookState> _mapLoadBooksToState() async* {
    _booksSubscription?.cancel();
    _booksSubscription = books().listen((books) {
      add(BooksUpdated(books));
    });
  }

  Stream<BookState> _mapAddBookEventToState(AddBookEvent event) async* {
    booksCollection.add(Book.toMap(event.book));
  }

  Stream<BookState> _mapDeleteBookEventToState(DeleteBookEvent event) async* {
    booksCollection.document(event.id).delete();
  }

  Stream<BookState> _mapUpdateBookEventToState(UpdateBookEvent event) async* {
    booksCollection
        .document(event.book.id)
        .updateData(Book.toMap(event.book));
  }

  Stream<List<Book>> books() {
    return booksCollection.snapshots().map((snapshot) { return snapshot.documents.map((doc) => Book.toModel(doc) as Book).toList();
    });
  }

  Stream<BookState> _mapBooksUpdateToState(BooksUpdated event) async* {
    yield BooksLoaded(event.books);
  }
}

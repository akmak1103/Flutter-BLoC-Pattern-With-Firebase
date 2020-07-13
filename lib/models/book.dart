import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Book extends Equatable {
  final String title;
  final String author;
  final String id;

  Book({this.title, this.author, this.id});

  @override
  List<Object> get props => [title, author];

  @override
  String toString() {
    return "Book: {title: $title, author: $author, id: $id}";
  }

  static Map<String, dynamic> toMap(Book book) {
    return {'Title': book.title, 'Author': book.author};
  }

  static toModel(DocumentSnapshot documentSnapshot) {
    return Book(
        author: documentSnapshot.data['Author'],
        id: documentSnapshot.documentID.toString(),
        title: documentSnapshot.data['Title']);
  }
}

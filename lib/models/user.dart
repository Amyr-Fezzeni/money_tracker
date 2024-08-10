// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:money_tracker/models/expense.dart';

class User {
  String id;
  String name;
  List<Expense> expenses;
  User({
    required this.id,
    required this.name,
    required this.expenses,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'name': name};
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        id: map['id'] as String, name: map['name'] as String, expenses: []);
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'User(id: $id, name: $name, expenses: $expenses)';
}

import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
enum ExpenseType { expense, income }

class Expense {
  final String id;
  String name;
  String type;
  double amount;
  DateTime date;
  Expense({
    required this.id,
    required this.name,
    required this.type,
    required this.amount,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'type': type,
      'amount': amount,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'] as String,
      name: map['name'] as String,
      type: map['type'] as String,
      amount: map['amount'] as double,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Expense.fromJson(String source) =>
      Expense.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Expense(id: $id, name: $name, type: $type, amount: $amount, date: $date)';
  }
}

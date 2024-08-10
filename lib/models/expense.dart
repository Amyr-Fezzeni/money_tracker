import 'dart:convert';
import 'dart:developer';

// ignore_for_file: public_member_api_docs, sort_constructors_first
enum ExpenseType { expense, income }

class Expense {
  final String id;
  String name;
  String type;
  String note;
  double amount;
  DateTime date;
  Expense({
    required this.id,
    required this.name,
    required this.type,
    required this.note,
    required this.amount,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'type': type,
      'note': note,
      'amount': amount,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    log(map.toString());
    return Expense(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      type: map['type'] ?? '',
      note: map['note'] ?? '',
      amount: map['amount'] ?? 0,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Expense.fromJson(String source) =>
      Expense.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Expense(id: $id, name: $name, type: $type, note: $note, amount: $amount, date: $date)';
  }
}

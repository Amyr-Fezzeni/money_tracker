import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:money_tracker/models/expense.dart';
import 'package:money_tracker/models/user.dart';
import 'package:money_tracker/service/local_data.dart';
import 'package:money_tracker/service/navigation_service.dart';
import 'package:money_tracker/service/util.dart';

class DataProvider with ChangeNotifier {
  BuildContext context = NavigationService.navigatorKey.currentContext!;
  int currentUser = 0;
  List<User> users = [];
  DateTime currentMonth = DateTime.now();

  init({bool notify = true}) {
    users = LocalData.getUsers();
    for (var i = 0; i < users.length; i++) {
      users[i].expenses = LocalData.getUserExpenses(users[i].id);
    }
    if (users.isEmpty) {
      createUser();
      init(notify: notify);
      return;
    }
    if (notify) notifyListeners();
  }

  createUser({String name = ''}) {
    User user = User(id: generateId(), name: name, expenses: []);
    LocalData.updateUser(user);
    init();
  }

  addTransaction(Expense expense) async {
    log(expense.toString());
    users[currentUser].expenses.add(expense);
    log(users[currentUser].expenses.toString());
    LocalData.updateUserExpense(
        users[currentUser].id, users[currentUser].expenses);
    init();
  }

  updateTransaction(Expense expense) {
    for (var i = 0; i < users[currentUser].expenses.length; i++) {
      if (users[currentUser].expenses[i].id == expense.id) {
        users[currentUser].expenses[i] = expense;
      }
    }
    LocalData.updateUserExpense(
        users[currentUser].id, users[currentUser].expenses);
    init();
  }

  deleteTransaction(Expense expense) {
    users[currentUser].expenses.remove(expense);
    LocalData.updateUserExpense(
        users[currentUser].id, users[currentUser].expenses);
    init();
  }

  List<Expense> getIncomes() => users[currentUser]
      .expenses
      .where((t) => t.type == ExpenseType.income.name)
      .toList();

  List<Expense> getExpenses() => users[currentUser]
      .expenses
      .where((t) => t.type == ExpenseType.expense.name)
      .toList();

  double getIncomesAmount() {
    final lst = getIncomes();
    return lst.isEmpty ? 0 : lst.map((e) => e.amount).reduce((a, b) => a + b);
  }

  double getExpensesAmount() {
    final lst = getExpenses();
    return lst.isEmpty ? 0 : lst.map((e) => e.amount).reduce((a, b) => a + b);
  }
}

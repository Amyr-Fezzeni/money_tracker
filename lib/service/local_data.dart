import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:money_tracker/models/expense.dart';
import 'package:money_tracker/models/theme.dart';
import 'package:money_tracker/models/user.dart';
import 'package:path_provider/path_provider.dart';

/// Remarque: Assurez-vous d'appeler `LocalData.init()` avant d'utiliser d'autres méthodes.
class LocalData {
  static late final Box _box;

  /// Initialise Hive et ouvre la boîte 'myData' pour stocker les données.
  static Future<void> init() async {
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    await Hive.openBox('db');
    _box = Hive.box('db');
    _box.clear();
  }

  static List<User> getUsers() {
    final users = List<User>.from(_box.get('users', defaultValue: []).map(
        (data) => User.fromMap(Map<String, dynamic>.from(data))));
    return users;
  }

  static void updateUser(User user) {
    List<User> users = getUsers();
    if (!users.map((u) => u.id).contains(user.id)) {
      users.add(user);
      _box.put('users', users.map((u) => u.toMap()).toList());
      updateUserExpense(user.id, []);
    }
    _box.put(user.id, user.expenses.map((e) => e.toMap()).toList());
  }

  static List<Expense> getUserExpenses(String userId) {
    return List<Expense>.from(_box.get(userId, defaultValue: []).map(
        (data) => Expense.fromMap(Map<String, dynamic>.from(data))));
  }

  static void updateUserExpense(String userId, List<Expense> expenses) {
    _box.put(userId, expenses.map((e) => e.toMap()).toList());
  }

  static saveAppTheme(AppThemeModel value) {
    _box.put('appTheme', value.name);
  }

  static AppThemeModel getAppTheme() {
    return getAppThemeFromString(
        _box.get('appTheme', defaultValue: AppThemeModel.system.name));
  }
}

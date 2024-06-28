import 'package:hive/hive.dart';
import 'package:money_tracker/models/expense.dart';
import 'package:money_tracker/models/theme.dart';
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
  }

  static List<Expense> getExpenses() {
    return List<Expense>.from(_box.get('expenses', defaultValue: []).map(
        (data) => Expense.fromMap(Map<String, dynamic>.from(data))));
  }

  static void saveExpense(Expense expense) {
    List<Expense> expenses = getExpenses();
    expenses.add(expense);
    _box.put('expenses', expenses.map((e) => e.toMap()).toList());
  }

  static void updateExpense(Expense expense) {
    List<Expense> expenses = getExpenses();
    int index = expenses.indexWhere((e) => e.id == expense.id);
    expenses.removeAt(index);
    expenses.insert(index, expense);
    _box.put('expenses', expenses.map((e) => e.toMap()).toList());
  }

  static void deleteExpense(Expense expense) {
    List<Expense> expenses = getExpenses();
    expenses.removeWhere((e) => e.id == expense.id);
    _box.put('expenses', expenses.map((e) => e.toMap()).toList());
  }

  /// Sauvegarde le thème de l'application sélectionné dans le stockage local.
  static saveAppTheme(AppThemeModel value) {
    _box.put('appTheme', value.name);
  }

  /// Récupère le thème de l'application actuellement sélectionné à partir du stockage local.
  static AppThemeModel getAppTheme() {
    return getAppThemeFromString(
        _box.get('appTheme', defaultValue: AppThemeModel.system.name));
  }
}

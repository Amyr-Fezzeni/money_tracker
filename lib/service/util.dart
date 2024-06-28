import 'package:crossplat_objectid/crossplat_objectid.dart';

String generateId() {
  ObjectId id1 = ObjectId();
  return id1.toHexString();
}
/// Capitalise la première lettre d'une chaîne de caractères et met le reste en minuscules.
///
/// Retourne une chaîne vide si [text] est nul ou vide.
String capitalize(String? text) {
  if (text == null || text.isEmpty) return '';
  return "${text[0].toUpperCase()}${text.substring(1).toLowerCase()}";
}

/// Renvoie le chemin d'accès à l'icône météo dans les ressources.
///
/// Utilise [icon] pour construire le chemin d'accès à l'icône dans le dossier 'assets/weather icons'.
String getAssetIcon(String icon) => "assets/weather icons/$icon.png";

/// Calcule la moyenne des nombres dans [numbers].
///
/// Renvoie 0 si [numbers] est vide.
int getAverageNumber(List<int> numbers) {
  if (numbers.isEmpty) return 0;
  int sum = numbers.reduce((a, b) => a + b);
  return sum ~/ numbers.length;
}

/// Renvoie les détails de la date sous forme de map pour une [date] donnée.
///
/// Le jour est étiqueté comme 'Today', 'Tomorrow' ou le nom du jour de la semaine.
Map<String, dynamic> getDateDetails(DateTime date) {
  List<String> dayNames = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];
  DateTime today = DateTime.now();
  DateTime tomorrow = today.add(const Duration(days: 1));

  String dayName;

  if (date.year == today.year &&
      date.month == today.month &&
      date.day == today.day) {
    dayName = 'Today';
  } else if (date.year == tomorrow.year &&
      date.month == tomorrow.month &&
      date.day == tomorrow.day) {
    dayName = 'Tomorrow';
  } else {
    dayName = dayNames[date.weekday % 7];
  }
  return {
    'date': "${date.month}/${date.day}",
    'day': date.day,
    'month': date.month,
    'dayName': dayName
  };
}



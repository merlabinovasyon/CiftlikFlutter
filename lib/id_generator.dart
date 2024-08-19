import 'dart:math';

String generateNewUniqueId(String text, Set<String> existingIds) {
  if (text.length >= 3) {
    String firstThree = text.substring(0, 3);
    String newId;

    do {
      int randomNumber = Random().nextInt(90000) + 10000; // 5 haneli sayı üretimi
      newId = '$firstThree$randomNumber';
    } while (existingIds.contains(newId)); // ID daha önce oluşturulmuş mu kontrol et

    return newId;
  } else {
    return 'Yazı çok kısa';
  }
}

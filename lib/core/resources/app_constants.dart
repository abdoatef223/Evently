import 'package:evently_c19/core/resources/assets_manager.dart';

abstract class AppConstants {
  static const String emailRegex = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  static Map<String,String> lightEventTypeImage = {
    "sport":AssetsManager.sport_light,
    "birthday":AssetsManager.birthday_light,
    "book":AssetsManager.book_light,
    "meeting":AssetsManager.meeting_light,
    "exhibition":AssetsManager.exhibition_light,
  };
  static Map<String,String> darkEventTypeImage = {
    "sport":AssetsManager.sport_dark,
    "birthday":AssetsManager.birthday_dark,
    "book":AssetsManager.book_dark,
    "meeting":AssetsManager.meeting_dark,
    "exhibition":AssetsManager.exhibition_dark,
  };

  static List<String> eventTypes = ["sport","birthday","book","exhibition","meeting"];

}
import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:crypto/crypto.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:lib_x/lib_x.dart';

bool isUrl(String url) => Uri.parse(url).host.isNotEmpty;
bool isAsset(String path) => path.startsWith('assets/');
bool isSVG(String path) => path.contains('.svg');

// returns if system is in dark mode
bool isDarkMode() =>
    SchedulerBinding.instance.platformDispatcher.platformBrightness ==
    Brightness.dark;
// returns the system themeMode
ThemeMode get sysThemeMode => isDarkMode() ? ThemeMode.dark : ThemeMode.light;

// returns the int value of now timestamp in seconds
int get now => DateTime.now().millisecondsSinceEpoch ~/ 1000;

// to formate timestamp to human format
String formatTimestamp(int timestamp) {
  late String d12;
  if (timestamp != 0) {
    final DateTime now = DateTime.now();
    final DateTime dt = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

    final int diffdays = dt.day - now.day;
    final int diffYears = dt.year - now.year;

    if (diffdays == 0) {
      d12 = DateFormat('hh:mm a').format(dt);
    } else if (diffdays == -1) {
      d12 = 'Yesterday';
    } else {
      if (diffYears == 0) {
        d12 = DateFormat('MMMM d').format(dt);
      } else {
        d12 = DateFormat('MMMM d, yyyy').format(dt);
      }
    }
  } else {
    d12 = 'Now';
  }

  return d12.shortMonth();
}

// letters string
const String chars =
    '_AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz0123456789';
// numbers string
const String numbers = '0123456789';

// if a string is a number
bool isNumeric(String str) {
  final RegExp numeric = RegExp(r'^-?[0-9]+$');
  return numeric.hasMatch(str);
}

// to generate random string with default length value of 16
String genString({int length = 16}) {
  final String randomString = List.generate(
    length,
    (_) => chars[Random().nextInt(chars.length)],
  ).join();

  return randomString;
}

// to generate random number with default length value of 16
String genNum({int length = 16}) {
  final String randomString = List.generate(
    length,
    (_) => numbers[Random().nextInt(numbers.length)],
  ).join();

  return randomString;
}

// to generate timestamp based id string
String genId({int length = 16}) => genString(length: length) + now.toString();

// to convert string to SHA256
String stringToSHA256(String string) {
  final bytes = utf8.encode(string);
  final digest = sha256.convert(bytes);
  return digest.toString();
}

// needs mime package installed
// checks if a file path or url is mp4 || mov
// bool isVideo(String url) {
//   if (isUrl(url)) {
//     return url.contains('.mp4');
//   } else {
//     String fileMime = lookupMimeType(url)!;
//     return fileMime == "video/mp4" || fileMime == "video/mov";
//   }
// }

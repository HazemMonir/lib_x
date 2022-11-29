import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:crypto/crypto.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:lib_x/lib_x.dart';

bool isUrl(String url) => Uri.parse(url).host.isNotEmpty;
bool isAsset(String path) => path.startsWith('assets/');
bool isSVG(String path) => path.contains('.svg');

bool isDarkMode() =>
    SchedulerBinding.instance.platformDispatcher.platformBrightness ==
    Brightness.dark;

ThemeMode get sysThemeMode => isDarkMode() ? ThemeMode.dark : ThemeMode.light;

int get now => DateTime.now().millisecondsSinceEpoch ~/ 1000;

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

const String chars =
    '_AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz0123456789';
const String numbers = '0123456789';

bool isNumeric(String str) {
  final RegExp numeric = RegExp(r'^-?[0-9]+$');
  return numeric.hasMatch(str);
}

String genString({int length = 16}) {
  final String randomString = List.generate(
    length,
    (_) => chars[Random().nextInt(chars.length)],
  ).join();

  return randomString;
}

String genNum({int length = 16}) {
  final String randomString = List.generate(
    length,
    (_) => numbers[Random().nextInt(numbers.length)],
  ).join();

  return randomString;
}

String genId({int length = 16}) => genString(length: length) + now.toString();

String stringToSHA256(String string) {
  final bytes = utf8.encode(string);
  final digest = sha256.convert(bytes);
  return digest.toString();
}

// checks for mp4 & mov only
bool isVideo(String url) {
  if (isUrl(url)) {
    return url.contains('.mp4');
  } else {
    String fileMime = lookupMimeType(url)!;
    return fileMime == "video/mp4" || fileMime == "video/mov";
  }
}

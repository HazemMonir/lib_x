import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

// example theme_data

final Brightness platformBrightness =
    SchedulerBinding.instance.window.platformBrightness;

const Color black = Colors.black;
const Color white = Colors.white;
const Color red = Color.fromARGB(255, 255, 37, 21);
const Color blue = Color.fromARGB(255, 20, 149, 255);
const Color green = Color.fromARGB(255, 30, 255, 37);
const Color transparent = Colors.transparent;

BorderRadius borderRadius(double r) => BorderRadius.circular(r);

import 'dart:async';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'audio.dart';
import 'package:intl/intl.dart';
import 'package:flutter/widgets.dart';
import 'main.dart';

//These are the global variables for both screens which will update the time
int clockNumber = 8;
int clockMinutes = 1;
int clockNumberTimer;
int clockMinutesTimer;
int currentHour;
int clockHourSaved;
int clockMinuteSaved;
Timer timer;
AnimationController controller;
String secondPageTime;
const simplePeriodicTask = "simplePeriodicTask";
int seconds;
//this was added in for github

//* This is linked with localTime above
var anotherDt =
    DateTime.now().add(Duration(hours: clockNumber, minutes: clockMinutes));

String formatOfDate = new DateFormat.jm().format(anotherDt);

String get timerString {
  Duration duration = controller.duration * controller.value;
  return '${(duration.inHours).toString().padLeft(
        2,
      )}h';
}

String get timerStringMinute {
  Duration duration = controller.duration * controller.value;
  return '${(duration.inMinutes % 60).toString().padLeft(
        2,
      )}min';
}

// String get timerString {
//   Duration duration = controller.duration * controller.value;
//   return '${duration.inHours}h${(duration.inMinutes % 60).toString().padLeft(
//     2,
//   )}min';
// }
// void startTimer() {
//   timer = Timer.periodic(Duration(seconds: 1), (timer) {
//     setState(() {
//       if (clockMinutesTimer > 0) {
//         clockMinutesTimer--;
//         print('The timer counted down $clockMinutesTimer');
//       }
//       if (clockNumberTimer > 0) {
//         clockNumberTimer--;
//         print('The timer counted down $clockNumberTimer');
//       } else {
//         timer.cancel();
//
//         print('The timer has reached 0');
//       }
//     });
//   });
// }

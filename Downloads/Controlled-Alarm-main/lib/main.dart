import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'constants.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/widgets.dart';
import 'brain.dart';
import 'audio.dart';
import 'secondscreen.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:workmanager/workmanager.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //Work manager is related to background functioning of my app
  Workmanager.initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode:
          true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
      );
  Workmanager.registerOneOffTask("1", "simpleTask");
  runApp(MyApp());
  // // Than we setup preferred orientations,
  // // and only after it finished we run our app
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  //     .then((value) => runApp(MyApp()));
}

void callbackDispatcher() {
  Workmanager.executeTask((task, inputData) async {
    switch (task) {
      case simplePeriodicTask:
        print("$simplePeriodicTask was executed");
        break;
      case Workmanager.iOSBackgroundTask:
        print("The iOS background fetch was triggered");
        Directory tempDir = await getTemporaryDirectory();
        String tempPath = tempDir.path;
        print(
            "You can access other plugins in the background, for example Directory.getTemporaryDirectory(): $tempPath");
        break;
    }

    return Future.value(true);
  });
}

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  MyAppState createState() => MyAppState();
}

enum PlayerState {
  playing,
}
AudioCache cache;
//* This is linked with formatOfDate
DateTime localTime = new DateTime.now();

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Builder(
      builder: (context) => Home(),
    ));
  }
}

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var anotherDt =
        DateTime.now().add(Duration(hours: clockNumber, minutes: clockMinutes));
    String formatOfDate = new DateFormat.jm().format(anotherDt);

    return Scaffold(
      backgroundColor: Color(0xFF232323),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Clock(
                colour: Color(0xFF232323),
                cardChild: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      HighlightedTimes(
                        onPress: () {
                          setState(() {
                            selectedTime = ClockTime.hours;
                          });
                        },
                        colour: selectedTime == ClockTime.hours
                            ? kActiveCardColor
                            : kInactiveCardColor,
                        cardChild: Text('$clockNumber Hours',
                            style: TextStyle(
                              fontSize: 35.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                      ),
                      HighlightedTimes(
                        onPress: () {
                          setState(() {
                            selectedTime = ClockTime.minutes;
                          });
                        },
                        colour: selectedTime == ClockTime.minutes
                            ? kActiveCardColor
                            : kInactiveCardColor,
                        cardChild: Text('$clockMinutes Min',
                            style: TextStyle(
                              fontSize: 35.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RoundIconButton(
                    icon: FontAwesomeIcons.minus,
                    onPressed: () {
                      setState(() {
                        if (selectedTime == ClockTime.minutes) {
                          clockMinutes--;
                          if (clockMinutes == -1) {
                            clockMinutes = 0;
                          }
                        } else if (selectedTime == ClockTime.hours) {
                          clockNumber--;
                          if (clockNumber == -1) {
                            clockNumber = 0;
                          }
                        }
                      });
                    },
                  ),
                  Container(
                    child: StartButton(onTap: () {
                      Workmanager.registerPeriodicTask(
                        "3",
                        simplePeriodicTask,
                        initialDelay: Duration(seconds: 10),
                      );
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CountDownTimer();
                      }));

                      setState(() {
                        secondPageTime = formatOfDate;

                        print("The timer has begun");
                      });
                    }),
                  ),
                  RoundIconButton(
                    icon: FontAwesomeIcons.plus,
                    onPressed: () {
                      setState(() {
                        if (selectedTime == ClockTime.minutes) {
                          clockMinutes++;

                          if (clockMinutes == 60) {
                            clockMinutes = 59;
                          }
                        } else if (selectedTime == ClockTime.hours) {
                          clockNumber++;
                          if (clockNumber == 10) {
                            clockNumber = 9;
                          }
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
            Container(
              child: Text(
                'Time to wake up: $formatOfDate',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: FittedBox(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      PresetButton(
                        onTap: () {
                          setState(() {
                            clockNumber = 1;
                          });
                        },
                        cardChild: Text(
                          '1',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0,
                          ),
                        ),
                      ),
                      PresetButton(
                        onTap: () {
                          setState(() {
                            clockNumber = 3;
                          });
                        },
                        cardChild: Text(
                          '3',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0,
                          ),
                        ),
                      ),
                      PresetButton(
                        onTap: () {
                          setState(() {
                            clockNumber = 6;
                          });
                        },
                        cardChild: Text(
                          '6',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0,
                          ),
                        ),
                      ),
                      PresetButton(
                        onTap: () {
                          setState(() {
                            clockNumber = 9;
                          });
                        },
                        cardChild: Text(
                          '9',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            FittedBox(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    stop();
                    clockNumber = 8;
                    clockMinutes = 1;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.only(bottom: 5.0),
                  width: 100,
                  height: 40,
                  child: Center(
                    child: Text(
                      'Reset',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'sizeconfig.dart';

const kActiveCardColor = Colors.black12;
const kCardColor = Color(0xFF232323);
const kInactiveCardColor = Color(0xFF232323);
const kBorder = BoxDecoration(boxShadow: [
  BoxShadow(
    color: Colors.lightGreenAccent,
    spreadRadius: 5,
    blurRadius: 7,
    offset: Offset(0, 3),
  ),
]);

enum ClockTime {
  hours,
  minutes,
}
var selectedTime;

class RoundIconButton extends StatelessWidget {
  RoundIconButton({@required this.icon, @required this.onPressed});

  final IconData icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(icon),
      onPressed: onPressed,
      elevation: 6.0,
      constraints: BoxConstraints.tightFor(
        width: 56.0,
        height: 56.0,
      ),
      shape: CircleBorder(),
      fillColor: Colors.grey,
    );
  }
}

class Clock extends StatelessWidget {
  Clock({@required this.colour, this.cardChild});

  final Color colour;
  final Widget cardChild;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: displayWidth(context) * 0.80,
      height: displayHeight(context) * 0.45,
      // height: 295,
      // width: 295,
      child: cardChild,
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.lightGreenAccent.withOpacity(0.5),
            spreadRadius: 10,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        color: colour,
        borderRadius: BorderRadius.circular(300.0),
      ),
    );
  }
}

class StartButton extends StatelessWidget {
  StartButton({
    @required this.onTap,
  });

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.lightGreenAccent,
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: EdgeInsets.only(bottom: 5.0),
          width: 100,
          height: 40,
          child: Center(
            child: Text(
              'START',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PresetButton extends StatelessWidget {
  PresetButton({
    @required this.onTap,
    @required this.cardChild,
  });

  final Function onTap;
  final Widget cardChild;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.lightGreenAccent,
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: EdgeInsets.only(bottom: 5.0),
          width: 70,
          height: 40,
          child: Center(
            child: cardChild,
          ),
        ),
      ),
    );
  }
}

class HighlightedTimes extends StatelessWidget {
  HighlightedTimes({@required this.colour, this.cardChild, this.onPress});

  final Color colour;
  final Widget cardChild;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        child: cardChild, //Text(clockNumber.toString())
        margin: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.lightGreenAccent.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          color: colour,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}

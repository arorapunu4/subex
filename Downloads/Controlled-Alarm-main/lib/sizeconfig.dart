import 'package:flutter/material.dart';

//This is where sizing configuration is done in order to set constraints and ratios across all devices

Size displaySize(BuildContext context) {
  // debugPrint('Size = ' + MediaQuery.of(context).size.toString());
  return MediaQuery.of(context).size;
}

double displayHeight(BuildContext context) {
  // debugPrint('Height = ' + displaySize(context).height.toString());
  return displaySize(context).height;
}

double displayWidth(BuildContext context) {
  // debugPrint('Width = ' + displaySize(context).width.toString());
  return displaySize(context).width;
}

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             Container(
//               color: Colors.red,
//               width: displayWidth(context) * 0.50,
//               height: displayHeight(context) * 0.30,
//               child: Text(
//                 'Box width 25% of screen width and text size 3% of screen width',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: displayWidth(context) * 0.03),
//               ),
//             ),
//             Container(
//               color: Colors.green,
//               width: displayWidth(context) * 0.5,
//               child: Text(
//                 'Box width 50% of screen width and text size 6% of screen width',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: displayWidth(context) * 0.06),
//               ),
//             ),
// test

//             Container(
//               color: Colors.blue,
//               width: displayWidth(context),
//               child: Text(
//                 'Box width equal to screen width and text size 10% of screen width',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: displayWidth(context) * 0.1),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

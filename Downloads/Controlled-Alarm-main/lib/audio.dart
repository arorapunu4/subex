import 'dart:async';
import 'dart:io';
import 'package:fileaudioplayer/fileaudioplayer.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

//Global Variables and Functions for playing the Audio

FileAudioPlayer player = new FileAudioPlayer();
Future<void> start() async {
  final ByteData data = await rootBundle.load('assets/quietime.mp3');
  Directory tempDir = await getApplicationDocumentsDirectory();
  File tempFile = File('${tempDir.path}/quietime.mp3');
  await tempFile.writeAsBytes(data.buffer.asUint8List(), flush: true);
  String mp3Uri = tempFile.uri.toString();
  await player.start(mp3Uri);
  print("end");
}

Future<void> stop() async {
  await player.stop();
}

Future<void> pause() async {
  await player.pause();
}

Future<void> resume() async {
  await player.resume();
}

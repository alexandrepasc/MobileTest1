import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<String> readFile() async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/userGsr.dat');
    print("${directory.path}");
    String text = await file.readAsString();
    print(text);
    return text;
  } catch (e) {
    print("Couldn't read file");
    return null;
  }
}

saveFile(String data) async {
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/userGsr.dat');
  final text = data;
  await file.writeAsString(text);
  print('saved');
}

deleteFile() async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/userGsr.dat');
    await file.delete();
    print('logout');
  } catch (e) {
    print("Couldn't logout");
  }
}
import 'dart:io';

String fixtureReader(String filePath) =>
    File('test/fixture/$filePath').readAsStringSync();

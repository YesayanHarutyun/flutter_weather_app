import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void initSQFLite() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
}
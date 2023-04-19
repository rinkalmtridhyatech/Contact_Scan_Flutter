import 'package:contact_scan/utils/utility.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/attendee_details_response.dart';

class SQLService {
  static final _databaseName = "contacts.db";
  static final _databaseVersion = 1;

  static final table = "contacts";

  static final columnId = 'id';
  static final columnAttendeeId = 'attendeeID';
  static final columnFirstName = 'userFirst';
  static final columnLastName = 'userLast';
  static final columnMobile = 'userMobile';
  static final columnPhone = 'userPhone';
  static final columnEmail = 'userEmail';
  static final columnGUID = 'userGUID';
  static final columnAddress = 'userAddress';
  static final columnCity = 'userCity';
  static final columnState = 'userState';
  static final columnCountry = 'userCountry';
  static final columnZip = 'userZip';
  static final columnWebsite = 'userWebsite';
  static final columnPosition = 'userPosition';
  static final columnCompany = 'userCompany';
  static final columnTimeStamp = 'timeStampUserAdded';
  static final columnNotes = 'notes';
  static final columnEventId = 'eventID';

  SQLService._privateConstructor();

  static final SQLService instance = SQLService._privateConstructor();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            $columnAttendeeId TEXT NOT NULL,
            $columnGUID TEXT NOT NULL,
            $columnFirstName TEXT NOT NULL,
            $columnLastName TEXT NOT NULL,
            $columnMobile TEXT NOT NULL,
            $columnPhone TEXT NOT NULL,
            $columnWebsite TEXT NOT NULL,
            $columnEmail TEXT NOT NULL,
            $columnAddress TEXT NOT NULL,
            $columnCity TEXT NOT NULL,
            $columnZip TEXT NOT NULL,
            $columnState TEXT NOT NULL,
            $columnCountry TEXT NOT NULL,
            $columnPosition TEXT NOT NULL,
            $columnCompany TEXT NOT NULL,
            $columnTimeStamp TEXT NOT NULL,
            $columnNotes TEXT NOT NULL,
            $columnEventId TEXT NOT NULL
          )
          ''');
  }

  Future<bool> tableIsEmpty() async {
    Database? db = await instance.database;
    int? count = Sqflite.firstIntValue(
        await db!.rawQuery('SELECT COUNT(*) FROM $table'));
    return count! <= 0 ? true : false;
  }

  Future<int> insert(AttendeeDetailsResponse contacts) async {
    Database? db = await instance.database;
    var res = await db!.insert(table, contacts.toMap());
    return res;
  }

  Future<int> update(AttendeeDetailsResponse data) async {
    Database? db = await instance.database;
    var result = await db!.update(table, data.toMap(),
        where: '$columnAttendeeId = ?', whereArgs: [data.attendeeID]);
    return result;
  }

  Future<Map<String, dynamic>> refresh() async {
    Database? db = await instance.database;
    var res = await db!.query(table, orderBy: "$columnId DESC");
    return res.first;
  }

  Future<List<Map<String, dynamic>>> queryAllRows(String eventID) async {
    Database? db = await instance.database;
    var res = await db!.query(table,
        where: '$columnEventId = ?',
        whereArgs: [eventID],
        orderBy: "$columnTimeStamp DESC");
    return res;
  }

  Future<bool> isAlreadySaved(String attendeeID) async {
    Database? db = await instance.database;
    var res = await db!
        .query(table, where: '$columnAttendeeId = ?', whereArgs: [attendeeID]);
    return res.isNotEmpty ? true : false;
  }

  Future<int> delete(String id) async {
    Database? db = await instance.database;
    return await db!.delete(table, where: '$columnGUID = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> clearTable() async {
    Database? db = await instance.database;
    return await db!.rawQuery("DELETE FROM $table");
  }

  updateNotes(data, id) async {
    Database? db = await instance.database;
    Map<String, dynamic> row = {columnNotes: data};
    int updateCount =
        await db!.update(table, row, where: '$columnGUID = ?', whereArgs: [id]);
  }
}

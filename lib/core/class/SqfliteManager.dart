import 'package:auto_mechanic/core/class/model/requestType.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteManager {
  static final SqfliteManager _instance = SqfliteManager._internal();

  Database? _database;

  SqfliteManager._internal();

  factory SqfliteManager() => _instance;

  Future<Database> get db async {
    if (_database != null) return _database!;

    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'mechanic.db');
    _database = await openDatabase(path, version: 1, onCreate: (Database db, int version) async {
      await db.execute(
        '''
        CREATE TABLE RequestType (
          id INTEGER PRIMARY KEY,
          oilName VARCHAR(50),
          startKmTimingBelt VARCHAR(7),
          endKmTimingBelt VARCHAR(7),
          startKmMotorOil VARCHAR(7),
          endKmMotorOil VARCHAR(7),
          replaceType VARCHAR(7),
          startKmGearOil VARCHAR(7),
          endKmGearOil VARCHAR(7),
          startKmHydraulicOil VARCHAR(7),
          endKmHydraulicOil VARCHAR(7),
          startKmOilFilter VARCHAR(7),
          endKmOilFilter VARCHAR(7),
          startKmAirFilter VARCHAR(7),
          endKmAirFilter VARCHAR(7),
          saveDate VARCHAR(11)
        )
        ''',
      );
    });

    return _database!;
  }

  Future<void> addNewService({
    required String oilName,
    required String startKmTimingBelt,
    required String endKmTimingBelt,
    required String startKmMotorOil,
    required String endKmMotorOil,
    required String replaceType,
    required String startKmGearOil,
    required String endKmGearOil,
    required String startKmHydraulicOil,
    required String endKmHydraulicOil,
    required String startKmOilFilter,
    required String endKmOilFilter,
    required String startKmAirFilter,
    required String endKmAirFilter,
    required String saveDate,
  }) async {
    final Database database = await db;

    await database.insert('RequestType', {
      'oilName': oilName,
      'startKmTimingBelt': startKmTimingBelt,
      'endKmTimingBelt': endKmTimingBelt,
      'startKmMotorOil': startKmMotorOil,
      'endKmMotorOil': endKmMotorOil,
      'replaceType': replaceType,
      'startKmGearOil': startKmGearOil,
      'endKmGearOil': endKmGearOil,
      'startKmHydraulicOil': startKmHydraulicOil,
      'endKmHydraulicOil': endKmHydraulicOil,
      'startKmOilFilter': startKmOilFilter,
      'endKmOilFilter': endKmOilFilter,
      'startKmAirFilter': startKmAirFilter,
      'endKmAirFilter': endKmAirFilter,
      'saveDate': saveDate,
    });
  }

  Future<void> updateService({
    required int id,
    required String oilName,
    required String startKmTimingBelt,
    required String endKmTimingBelt,
    required String startKmMotorOil,
    required String endKmMotorOil,
    required String replaceType,
    required String startKmGearOil,
    required String endKmGearOil,
    required String startKmHydraulicOil,
    required String endKmHydraulicOil,
    required String startKmOilFilter,
    required String endKmOilFilter,
    required String startKmAirFilter,
    required String endKmAirFilter,
    required String saveDate,
  }) async {
    final Database database = await db;

    await database.update(
      'RequestType',
      {
        'oilName': oilName,
        'startKmTimingBelt': startKmTimingBelt,
        'endKmTimingBelt': endKmTimingBelt,
        'startKmMotorOil': startKmMotorOil,
        'endKmMotorOil': endKmMotorOil,
        'replaceType': replaceType,
        'startKmGearOil': startKmGearOil,
        'endKmGearOil': endKmGearOil,
        'startKmHydraulicOil': startKmHydraulicOil,
        'endKmHydraulicOil': endKmHydraulicOil,
        'startKmOilFilter': startKmOilFilter,
        'endKmOilFilter': endKmOilFilter,
        'startKmAirFilter': startKmAirFilter,
        'endKmAirFilter': endKmAirFilter,
        'saveDate': saveDate,
      },
      where: 'id=?',
      whereArgs: [id],
    );
  }

  Future<void> deleteService({required int id}) async {
    final Database database = await db;
    await database.delete('RequestType', where: 'id=?', whereArgs: [id]);
  }

  Future<List<RequestType>> getAllService() async {
    final Database database = await db;
    List<Map<String, dynamic>> data = await database.query('RequestType', orderBy: 'saveDate DESC');
    if (data.isNotEmpty) {
      return data
          .map(
            (service) => RequestType(
              id: service['id'],
              oilName: service['oilName'],
              startKmTimingBelt: service['startKmTimingBelt'],
              endKmTimingBelt: service['endKmTimingBelt'],
              startKmMotorOil: service['startKmMotorOil'],
              endKmMotorOil: service['endKmMotorOil'],
              replaceType: service['replaceType'],
              startKmGearOil: service['startKmGearOil'],
              endKmGearOil: service['endKmGearOil'],
              startKmHydraulicOil: service['startKmHydraulicOil'],
              endKmHydraulicOil: service['endKmHydraulicOil'],
              startKmOilFilter: service['startKmOilFilter'],
              endKmOilFilter: service['endKmOilFilter'],
              startKmAirFilter: service['startKmAirFilter'],
              endKmAirFilter: service['endKmAirFilter'],
              saveDate: service['saveDate'],
            ),
          )
          .toList();
    }
    return [];
  }

  Future<RequestType?> getServiceById({required int id}) async {
    final Database database = await db;
    List<Map<String, dynamic>> data = await database.query('RequestType', where: 'id=?', whereArgs: [id]);
    if (data.isNotEmpty) {
      return RequestType(
        id: data[0]['id'],
        oilName: data[0]['oilName'],
        startKmTimingBelt: data[0]['startKmTimingBelt'],
        endKmTimingBelt: data[0]['endKmTimingBelt'],
        startKmMotorOil: data[0]['startKmMotorOil'],
        endKmMotorOil: data[0]['endKmMotorOil'],
        replaceType: data[0]['replaceType'],
        startKmGearOil: data[0]['startKmGearOil'],
        endKmGearOil: data[0]['endKmGearOil'],
        startKmHydraulicOil: data[0]['startKmHydraulicOil'],
        endKmHydraulicOil: data[0]['endKmHydraulicOil'],
        startKmOilFilter: data[0]['startKmOilFilter'],
        endKmOilFilter: data[0]['endKmOilFilter'],
        startKmAirFilter: data[0]['startKmAirFilter'],
        endKmAirFilter: data[0]['endKmAirFilter'],
        saveDate: data[0]['saveDate'],
      );
    }
    return null;
  }
}

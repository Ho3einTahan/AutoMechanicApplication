class RequestType {
  int id;
  String oilName;
  String startKmTimingBelt;
  String endKmTimingBelt;
  String startKmMotorOil;
  String endKmMotorOil;
  String replaceType;
  String startKmGearOil;
  String endKmGearOil;
  String startKmHydraulicOil;
  String endKmHydraulicOil;
  String startKmOilFilter;
  String endKmOilFilter;
  String startKmAirFilter;
  String endKmAirFilter;
  String saveDate;

  RequestType({
    required this.id,
    required this.oilName,
    required this.startKmTimingBelt,
    required this.endKmTimingBelt,
    required this.startKmMotorOil,
    required this.endKmMotorOil,
    required this.replaceType,
    required this.startKmGearOil,
    required this.endKmGearOil,
    required this.startKmHydraulicOil,
    required this.endKmHydraulicOil,
    required this.startKmOilFilter,
    required this.endKmOilFilter,
    required this.startKmAirFilter,
    required this.endKmAirFilter,
    required this.saveDate,
  });
}

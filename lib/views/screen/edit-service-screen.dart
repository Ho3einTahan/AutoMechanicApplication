import 'package:auto_mechanic/core/class/SqfliteManager.dart';
import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class EditServiceScreen extends StatefulWidget {
  final int serviceId;

  const EditServiceScreen({super.key, required this.serviceId});

  @override
  State<EditServiceScreen> createState() => _EditServiceScreenState();
}

class _EditServiceScreenState extends State<EditServiceScreen> {
  String? replaceType;
  final TextEditingController _oilNameController = TextEditingController();
  final TextEditingController _startKmMotorOilController = TextEditingController();
  final TextEditingController _endKmMotorOilController = TextEditingController();
  final TextEditingController _startKmGearOilController = TextEditingController();
  final TextEditingController _endKmGearOilController = TextEditingController();
  final TextEditingController _startKmHydraulicOilController = TextEditingController();
  final TextEditingController _endKmHydraulicOilController = TextEditingController();
  final TextEditingController _startKmOilFilterController = TextEditingController();
  final TextEditingController _endKmOilFilterController = TextEditingController();
  final TextEditingController _startKmAirFilterController = TextEditingController();
  final TextEditingController _endKmAirFilterController = TextEditingController();
  final TextEditingController _startKmTimingBelController = TextEditingController();
  final TextEditingController _endKmTimingBelController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final SqfliteManager _sqfliteManager = SqfliteManager();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadServiceData();
  }

  Future<void> _loadServiceData() async {
    var service = await _sqfliteManager.getServiceById(id: widget.serviceId);
    if (service != null) {
      setState(() {
        _oilNameController.text = service.oilName;
        _startKmMotorOilController.text = service.startKmMotorOil;
        _endKmMotorOilController.text = service.endKmMotorOil;
        _startKmGearOilController.text = service.startKmGearOil;
        _endKmGearOilController.text = service.endKmGearOil;
        _startKmHydraulicOilController.text = service.startKmHydraulicOil;
        _endKmHydraulicOilController.text = service.endKmHydraulicOil;
        _startKmOilFilterController.text = service.startKmOilFilter;
        _endKmOilFilterController.text = service.endKmOilFilter;
        _startKmAirFilterController.text = service.startKmAirFilter;
        _endKmAirFilterController.text = service.endKmAirFilter;
        _startKmTimingBelController.text = service.startKmTimingBelt;
        _endKmTimingBelController.text = service.endKmTimingBelt;
        _dateController.text = service.saveDate;
        replaceType = service.replaceType;
      });
    }
  }

  Widget _buildDateField() {
    return GestureDetector(
      onTap: () async {
        Jalali? picked = await showPersianDatePicker(
          context: context,
          initialDate: Jalali.now(),
          firstDate: Jalali(1300, 1, 1),
          lastDate: Jalali(1450, 12, 29),
        );
        if (picked != null) {
          setState(() {
            _dateController.text = picked.formatCompactDate();
          });
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        child: AbsorbPointer(
          child: TextFormField(
            controller: _dateController,
            decoration: InputDecoration(labelText: 'تاریخ سرویس', border: OutlineInputBorder(), suffixIcon: Icon(Icons.calendar_today)),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'لطفاً تاریخ سرویس را انتخاب کنید';
              }
              return null;
            },
          ),
        ),
      ),
    );
  }

  void _validateAndUpdate() async {
    if (_formKey.currentState!.validate() && replaceType != null) {
      String oilName = _oilNameController.text; // مقدار نام روغن
      String startKmTimingBelt = _startKmTimingBelController.text;
      String endKmTimingBelt = _endKmTimingBelController.text;
      String startKmMotorOil = _startKmMotorOilController.text;
      String endKmMotorOil = _endKmMotorOilController.text;
      String startKmGearOil = _startKmGearOilController.text;
      String endKmGearOil = _endKmGearOilController.text;
      String startKmHydraulicOil = _startKmHydraulicOilController.text;
      String endKmHydraulicOil = _endKmHydraulicOilController.text;
      String startKmOilFilter = _startKmOilFilterController.text;
      String endKmOilFilter = _endKmOilFilterController.text;
      String startKmAirFilter = _startKmAirFilterController.text;
      String endKmAirFilter = _endKmAirFilterController.text;
      String saveDate = _dateController.text;

      await _sqfliteManager.updateService(
        id: widget.serviceId,
        oilName: oilName,
        startKmTimingBelt: startKmTimingBelt,
        endKmTimingBelt: endKmTimingBelt,
        startKmMotorOil: startKmMotorOil,
        endKmMotorOil: endKmMotorOil,
        replaceType: replaceType!,
        startKmGearOil: startKmGearOil,
        endKmGearOil: endKmGearOil,
        startKmHydraulicOil: startKmHydraulicOil,
        endKmHydraulicOil: endKmHydraulicOil,
        startKmOilFilter: startKmOilFilter,
        endKmOilFilter: endKmOilFilter,
        startKmAirFilter: startKmAirFilter,
        endKmAirFilter: endKmAirFilter,
        saveDate: saveDate,
      );
      Navigator.pop(context, true);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('اطلاعات با موفقیت به‌روزرسانی شد.')));
    } else if (replaceType == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('لطفاً نوع تعویض را انتخاب کنید.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildHeader(),
                    _buildOilNameField(),
                    _buildServiceSection('روغن موتور', _startKmMotorOilController, _endKmMotorOilController),
                    _buildServiceSection('روغن گیربکس', _startKmGearOilController, _endKmGearOilController),
                    _buildServiceSection('روغن هیدرولیک', _startKmHydraulicOilController, _endKmHydraulicOilController),
                    _buildServiceSection('فیلتر روغن', _startKmOilFilterController, _endKmOilFilterController),
                    _buildServiceSection('فیلتر هوا', _startKmAirFilterController, _endKmAirFilterController),
                    _buildServiceSection('تسمه تایم', _startKmTimingBelController, _endKmTimingBelController),
                    _buildDateField(),
                    _buildDropdown(),
                    _buildSubmitButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 60,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 16),
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.yellow[700],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.5), offset: Offset(2, 4), blurRadius: 8)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('ویرایش سرویس', style: TextStyle(color: Colors.black, fontSize: 26, fontWeight: FontWeight.bold)),
          IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black, size: 28)),
        ],
      ),
    );
  }

  Widget _buildServiceSection(String label, TextEditingController startController, TextEditingController endController) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.yellow[100],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
          Divider(color: Colors.yellow[700]),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: startController,
                  decoration: InputDecoration(
                    prefixText: 'km',
                    labelText: 'کیلومتر فعلی',
                    border: InputBorder.none,
                    labelStyle: TextStyle(color: Colors.grey[700]),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'لطفاً کیلومتر فعلی را وارد کنید';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  controller: endController,
                  decoration: InputDecoration(
                    prefixText: 'km',
                    labelText: 'کیلومتر بعدی',
                    border: InputBorder.none,
                    labelStyle: TextStyle(color: Colors.grey[700]),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'لطفاً کیلومتر بعدی را وارد کنید';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown() {
    return Container(
      height: 55,
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.yellow[100],
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.27), offset: Offset(0, 2), blurRadius: 15)],
      ),
      child: Row(
        children: [
          Text('نوع تعویض: ', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
          DropdownButton(
            items: [
              DropdownMenuItem(child: Text('ساکشن'), value: 'ساکشن'),
              DropdownMenuItem(child: Text('دستی'), value: 'دستی'),
            ],
            dropdownColor: Colors.yellow[100],
            style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
            underline: SizedBox(),
            hint: Text('نوع تعویض را انتخاب کنید', style: TextStyle(color: Colors.black)),
            icon: Icon(Icons.find_replace_rounded, color: Colors.black),
            iconSize: 34,
            value: replaceType,
            onChanged: (value) {
              setState(() {
                replaceType = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(200, 50),
          backgroundColor: Colors.yellow[700],
          elevation: 10,
          shadowColor: Colors.black,
        ),
        onPressed: _validateAndUpdate,
        child: Icon(Icons.check, color: Colors.black, size: 34),
      ),
    );
  }

  Widget _buildOilNameField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.yellow[100],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 5)],
      ),
      child: TextFormField(
        controller: _oilNameController,
        decoration: InputDecoration(labelText: 'نام روغن', border: InputBorder.none, labelStyle: TextStyle(color: Colors.grey[700])),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'لطفاً نام روغن را وارد کنید';
          }
          return null;
        },
      ),
    );
  }
}

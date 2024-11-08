import 'package:auto_mechanic/core/class/SqfliteManager.dart';
import 'package:flutter/material.dart';

import '../../core/class/model/requestType.dart';
import 'edit-service-screen.dart';

class ServiceDetailScreen extends StatefulWidget {
  ServiceDetailScreen({super.key, required this.isAdmin});

  bool isAdmin;

  @override
  State<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  late List<RequestType> requestList = [];
  final SqfliteManager _sqfliteManager = SqfliteManager();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRequests();
  }

  Future<void> _loadRequests() async {
    requestList = await _sqfliteManager.getAllService();
    isLoading = false;
    setState(() {});
  }

  Future<void> _deleteService(int id) async {
    await _sqfliteManager.deleteService(id: id);
    setState(() {
      requestList.removeWhere((item) => item.id == id);
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('سرویس با موفقیت حذف شد')));
  }

  void _showDeleteDialog(int id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: Text('حذف سرویس', style: TextStyle(color: Colors.yellow)),
          content: Text('آیا مطمئن هستید که می‌خواهید این سرویس را حذف کنید؟', style: TextStyle(color: Colors.white)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('لغو', style: TextStyle(color: Colors.yellow)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _deleteService(id);
              },
              child: Text('حذف', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (requestList.isEmpty && isLoading) {
      return Scaffold(
        body: SafeArea(child: Center(child: CircularProgressIndicator(color: Colors.yellow))),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('جزئیات سرویس‌ها'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: requestList.length,
          itemBuilder: (context, index) {
            final request = requestList[index];
            return GestureDetector(
              onLongPress: () => widget.isAdmin ? _showDeleteDialog(request.id) : null,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Card(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  elevation: 6,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTitle('اطلاعات سرویس', requestList[index].saveDate, requestList[index].id),
                          Divider(color: Colors.yellow, thickness: 1.5),
                          _buildDetailRow('نام روغن:', request.oilName, Icons.oil_barrel, Colors.yellow),
                          _buildDetailRow('نوع تعویض:', request.replaceType, Icons.swap_horiz, Colors.yellow),
                          _buildGroupedCompactRows('تسمه تایم', request.startKmTimingBelt, request.endKmTimingBelt),
                          _buildGroupedCompactRows('روغن موتور', request.startKmMotorOil, request.endKmMotorOil),
                          _buildGroupedCompactRows('روغن گیربکس', request.startKmGearOil, request.endKmGearOil),
                          _buildGroupedCompactRows('روغن هیدرولیک', request.startKmHydraulicOil, request.endKmHydraulicOil),
                          _buildGroupedCompactRows('فیلتر روغن', request.startKmOilFilter, request.endKmOilFilter),
                          _buildGroupedCompactRows('فیلتر هوا', request.startKmAirFilter, request.endKmAirFilter),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTitle(String title, String date, int serviceId) {
    return Row(
      children: [
        widget.isAdmin
            ? IconButton(
                onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditServiceScreen(serviceId: serviceId)),
                    ).then((value) {
                      print(value);
                      if (value == true) {
                        _loadRequests();
                      }
                    }),
                icon: Icon(Icons.edit, color: Colors.yellow, size: 25))
            : Icon(Icons.settings, color: Colors.yellow, size: 25),
        SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.yellow),
        ),
        Spacer(),
        Text(date, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.yellow)),
      ],
    );
  }

  Widget _buildDetailRow(String title, String value, IconData icon, Color iconColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 20),
          SizedBox(width: 8),
          Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.yellow)),
          Spacer(),
          Flexible(
            child: Text(value, style: TextStyle(fontSize: 17, color: Colors.white), overflow: TextOverflow.ellipsis, textAlign: TextAlign.left),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupedCompactRows(String itemName, String currentKm, String nextKm) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                itemName,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.yellow),
              ),
            ],
          ),
        ),
        SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildCompactDetail('فعلی:', currentKm),
            _buildCompactDetail('بعدی:', nextKm),
          ],
        ),
        Divider(color: Colors.yellow),
      ],
    );
  }

  Widget _buildCompactDetail(String title, String value) {
    return Flexible(
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.yellow),
          ),
          SizedBox(width: 4),
          Flexible(
            child: Text(
              value,
              style: TextStyle(fontSize: 17, color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

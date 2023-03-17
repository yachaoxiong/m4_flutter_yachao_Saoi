import 'package:clinic_flutter_p1/screens/patient_details.dart';
import 'package:clinic_flutter_p1/theme.dart';
import 'package:flutter/material.dart';

import '../widget/patient_card.dart';
import '../services/patient_services.dart';

class PatientsScreen extends StatefulWidget {
  const PatientsScreen({Key? key}) : super(key: key);

  @override
  _PatientsScreenState createState() => _PatientsScreenState();
}

// run the function to get the list of patient
class _PatientsScreenState extends State<PatientsScreen> {
  TextEditingController _searchController = TextEditingController();
  bool _isCriticalSelected = false;
  bool _isNormalSelected = false;
  bool _isAllSelected = true;
  List _patientList = [];

  Future<void> _getPatientList() async {
    List<dynamic> patients = await getPatientList();

    setState(() {
      _patientList = patients;
    });

    print('patients: $patients');
    // Do something with the list of patients
  }

  void _searchPatient(String searchQuery) {
    if (searchQuery.isNotEmpty) {
      List<dynamic> filteredList = _patientList
          .where((patient) =>
              patient['firstName'].toLowerCase().contains(searchQuery) ||
              patient['lastName'].toLowerCase().contains(searchQuery))
          .toList();
      setState(() {
        _patientList = filteredList;
      });
    } else {
      _getPatientList();
    }
  }

  void _findStatusPatients(String searchQuery) {
    List<dynamic> filteredList = [];

    if (searchQuery == 'all') {
      _getPatientList();
      setState(() {
        _isAllSelected = searchQuery == 'all';
        _isCriticalSelected = searchQuery == 'critical';
        _isNormalSelected = searchQuery == 'normal';
      });
      return;
    }

    filteredList = _patientList
        .where((patient) => patient['status'] == searchQuery)
        .toList();

    setState(() {
      _patientList = filteredList;
      _isAllSelected = searchQuery == 'all';
      _isCriticalSelected = searchQuery == 'critical';
      _isNormalSelected = searchQuery == 'normal';
    });
  }

  @override
  void initState() {
    super.initState();
    _getPatientList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      backgroundColor: backgroundColorGrey,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 36),
            // title
            Text(
              'Patients',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                suffixIcon: IconButton(
                  onPressed: () {
                    _searchPatient(_searchController.text.toLowerCase());
                  },
                  icon: Icon(Icons.search),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 26),
            Row(
              children: [
                Radio(
                  value: true,
                  groupValue: _isAllSelected,
                  onChanged: (value) {
                    _findStatusPatients('all');
                  },
                ),
                Text('All'),
                SizedBox(width: 38),
                Radio(
                  value: true,
                  groupValue: _isCriticalSelected,
                  onChanged: (value) {
                    _findStatusPatients('critical');
                  },
                ),
                Text('Critical'),
                SizedBox(width: 38),
                Radio(
                  value: true,
                  groupValue: _isNormalSelected,
                  onChanged: (value) {
                    _findStatusPatients('normal');
                  },
                ),
                Text('Normal'),
              ],
            ),
            //list of patients
            _patientList.length > 0
                ? Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: _patientList.length,
                          itemBuilder: (context, index) {
                            return PatientCard(
                              title: _patientList[index]['firstName'] ?? '',
                              department:
                                  _patientList[index]['department'] ?? '',
                              subtitle: _patientList[index]['gender'] +
                                      ',' +
                                      _patientList[index]['age'].toString() ??
                                  '',
                              dateCreated:
                                  _patientList[index]['createdAt'] ?? '',
                              status: _patientList[index]['status'] ?? '',
                              statusColor:
                                  _patientList[index]['status'] == 'critical'
                                      ? Colors.red
                                      : Colors.green,
                              icon: Icons.person,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PatientDetails(
                                        patientId: _patientList[index]['_id']),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  )
                : Center(
                    //show no patient found
                    child: Text('No patient found'),
                  ),
          ],
        ),
      ),
    );
  }
}

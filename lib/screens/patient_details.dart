import 'package:clinic_flutter_p1/screens/edit_patient.dart';
import 'package:clinic_flutter_p1/screens/home_screen.dart';
import 'package:clinic_flutter_p1/theme.dart';
import 'package:clinic_flutter_p1/widget/bmi_card.dart';
import 'package:clinic_flutter_p1/widget/button_primary.dart';
import 'package:clinic_flutter_p1/widget/test_card.dart';
import 'package:flutter/material.dart';

import '../widget/patient_details_card.dart';
import '../widget/time_line.dart';
import '../model/patient.dart';
import '../services/patient_services.dart';
import '../widget/add_record.dart';

class PatientDetails extends StatefulWidget {
  final String patientId;

  const PatientDetails({Key? key, required this.patientId}) : super(key: key);

  @override
  _PatientDetailsState createState() => _PatientDetailsState();
}

class _PatientDetailsState extends State<PatientDetails> {
  // initialize patient details with empty values
  Patient patient = Patient.empty();
  List<dynamic> tests = [];
  List<dynamic> histories = [];

  // fetch patient details, tests and histories from the database using patientId
  Future<void> fetchPatientDetailsTestsAndHistories() async {
    await fetchPatientDetails();
    await fetchPatientTests();
    await fetchPatientHistories();
  }

  // fetch patient details from the database using patientId
  Future<void> fetchPatientDetails() async {
    print('patientId: ${widget.patientId}');
    // add print statement
    var _patient = await getPatientById(widget.patientId);
    print('_patient: $_patient');
    // assign the patient details to the patient variable
    patient.id = _patient['_id'];
    patient.age = _patient['age'];
    patient.department = _patient['department'];
    patient.firstName = _patient['firstName'];
    patient.lastName = _patient['lastName'];
    patient.phone = _patient['phone'];
    patient.gender = _patient['gender'];
    patient.address = _patient['address'];
    patient.email = _patient['email'];
    patient.height = double.tryParse(_patient['height'].toString()) ?? 0.0;
    patient.weight = double.tryParse(_patient['weight'].toString()) ?? 0.0;
    patient.doctor = _patient['doctor']['username'];
    patient.status = _patient['status'];

    //convert to date
    patient.birthDate = DateTime.parse(_patient['birthDate']);

    setState(() {
      this.patient = patient;
    });
  }

  Future<void> fetchPatientTests() async {
    tests = await getPatientTests(widget.patientId);
    setState(() {
      this.tests = tests;
    });
  }

  Future<void> fetchPatientHistories() async {
    histories = await getPatientHistories(widget.patientId);
    setState(() {
      this.histories = histories;
    });
  }

  String _selectedTab = 'Info';

  @override
  void initState() {
    super.initState();
    fetchPatientDetailsTestsAndHistories(); // fetch patient details when the widget is initialized
  }

  Future<void> _deletePatient(String id) async {
    await deletePatient(id);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    if (patient == null) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      backgroundColor: backgroundColorGrey,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 32),
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(width: 16),
                Text(
                  'Patient Information',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  patient.firstName ?? '',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AddRecordModal(
                          patientId: widget.patientId,
                          onRecordAdded: () {
                            // Refresh the test and history data when a new test is added.
                            fetchPatientTests();
                            fetchPatientHistories();
                          },
                        );
                      },
                    );
                  },
                  child: Text('Add Record'),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  patient.department ?? '',
                  style: TextStyle(fontSize: 16, color: greyColor),
                ),
                Text(
                  patient.doctor ?? '',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          SizedBox(height: 32),
          // gray line
          Container(
            height: 1,
            color: Colors.grey[300],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTabButton('Info'),
                _buildTabButton('Records'),
                _buildTabButton('History'),
              ],
            ),
          ),

          Expanded(
            // show it
            child: _buildSelectedTab(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String text) {
    final isActive = text == _selectedTab;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = text;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.black,
            fontSize: 16,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedTab() {
    switch (_selectedTab) {
      case 'Info':
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              PatientDetailsCard(
                name: patient.firstName ?? '' + ' ',
                age: patient.age ?? 0,
                gender: patient.gender ?? '',
                dateOfBirth:
                    patient.birthDate.toString().substring(0, 10) ?? '',
                phone: patient.phone.toString() ?? '',
                email: patient.email ?? '',
                address: patient.address ?? '',
              ),
              BmiCard(
                  bmiValue: 25.0,
                  heightValue: double.parse(patient.height.toString()),
                  weightValue: double.parse(patient.weight.toString())),
              ButtonPrimary(
                  text: 'Update Patient',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              EditPatientScreen(patient: patient)),
                    );
                  }),
              SizedBox(height: 16),
              ButtonPrimary(
                  text: 'Delete',
                  onTap: () {
                    // navigate to edit patient screen
                    _deletePatient(widget.patientId);
                  },
                  color: Colors.red),
            ],
          ),
        );
      case 'Records':
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: tests.length,
                itemBuilder: (context, index) {
                  var test = tests[index];
                  return TestResultCard(
                    icon: Icons.accessibility,
                    type: test['category'],
                    value: test['reading'],
                    dateCreated: test['createdAt'].substring(0, 10),
                    testType: test['category'],
                    testStatus: test['isCritical'] ? "Critical" : "Normal",
                  );
                },
              ),
            ),
          ],
        );
      case 'History':
        return TimelineWidget(
          events: histories.map((history) {
            return TimelineEvent(
              time: history['createdAt'].substring(0, 10),
              action: history['description'],
            );
          }).toList(),
          dotColor: Colors.blue,
          dotSize: 16,
        );
      default:
        return Container();
    }
  }
}

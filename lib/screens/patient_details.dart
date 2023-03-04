import 'package:clinic_flutter_p1/screens/edit_patient.dart';
import 'package:clinic_flutter_p1/theme.dart';
import 'package:clinic_flutter_p1/widget/bmi_card.dart';
import 'package:clinic_flutter_p1/widget/button_primary.dart';
import 'package:clinic_flutter_p1/widget/test_card.dart';
import 'package:flutter/material.dart';

import '../widget/patient_details_card.dart';
import '../widget/time_line.dart';

class PatientDetails extends StatefulWidget {
  final String patientId;

  const PatientDetails({Key? key, required this.patientId}) : super(key: key);

  @override
  _PatientDetailsState createState() => _PatientDetailsState();
}

class _PatientDetailsState extends State<PatientDetails> {
  // initialize patient details with empty values
  String _name = '';
  int _age = 0;
  String _gender = '';
  String _address = '';
  final List<TimelineEvent> events = [
    TimelineEvent(time: "2022-01-01", action: "Add new test"),
    TimelineEvent(time: "2022-01-01", action: "Edit test"),
  ];
  // fetch patient details from the database using patientId
  Future<void> fetchPatientDetails() async {
    // here you can write code to fetch patient details from the database using patientId
    // for example, you can use a package like http to make an API request to the server
    // and get the patient details as a JSON response
    // then you can parse the JSON response and set the patient details in the state
    // for simplicity, we'll just use hardcoded values here

    // simulate network delay for 2 seconds
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _name = 'John Doe';
      _age = 30;
      _gender = 'Male';
      _address = '123 Main St, Anytown USA';
    });
  }

  String _selectedTab = 'Info';

  @override
  void initState() {
    super.initState();
    fetchPatientDetails(); // fetch patient details when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
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
                  'Patient Name',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: () {
                    // handle add drug button press
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
                  'Emergency',
                  style: TextStyle(fontSize: 16, color: greyColor),
                ),
                Text(
                  'Tyler',
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
          SizedBox(height: 12),

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
                name: 'John Doe',
                age: 30,
                gender: 'Male',
                dateOfBirth: '01/01/1991',
                phone: '555-555-5555',
                email: 'johndoe@example.com',
                address: '123 Main St, Anytown USA',
              ),
              BmiCard(bmiValue: 25.0, heightValue: 170.0, weightValue: 70.0),
              ButtonPrimary(
                  text: 'Update Patient',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditPatientScreen()),
                    );
                  }),
              SizedBox(height: 16),
              ButtonPrimary(
                  text: 'Delete',
                  onTap: () {
                    // navigate to edit patient screen
                  },
                  color: Colors.red),
            ],
          ),
        );
      case 'Records':
        return SingleChildScrollView(
            child: Column(
          children: [
            TestResultCard(
              icon: Icons.accessibility,
              type: "Blood Pressure(X/Y MMHG",
              value: "121/90",
              dateCreated: "2022-01-02",
              testType: "Blood Pressure(X/Y MMHG)",
              testStatus: "Normal",
            ),
          ],
        ));
      case 'History':
        return TimelineWidget(
            events: events, dotColor: Colors.blue, dotSize: 16);
      default:
        return Container();
    }
  }
}

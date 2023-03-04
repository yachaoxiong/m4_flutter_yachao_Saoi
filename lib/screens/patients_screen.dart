import 'package:clinic_flutter_p1/screens/patient_details.dart';
import 'package:clinic_flutter_p1/theme.dart';
import 'package:flutter/material.dart';

import '../widget/patient_card.dart';

class PatientsScreen extends StatefulWidget {
  const PatientsScreen({Key? key}) : super(key: key);

  @override
  _PatientsScreenState createState() => _PatientsScreenState();
}

// show the list of patients

class _PatientsScreenState extends State<PatientsScreen> {
  TextEditingController _searchController = TextEditingController();
  bool _isCriticalSelected = false;
  bool _isNormalSelected = false;
  bool _isAllSelected = true;

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
                suffixIcon: Icon(Icons.search),
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
                    setState(() {
                      _isAllSelected = value!;
                      _isNormalSelected = false;
                      _isCriticalSelected = false;
                    });
                  },
                ),
                Text('All'),
                SizedBox(width: 38),
                Radio(
                  value: true,
                  groupValue: _isCriticalSelected,
                  onChanged: (value) {
                    setState(() {
                      _isCriticalSelected = value!;
                      _isNormalSelected = false;
                      _isAllSelected = false;
                    });
                  },
                ),
                Text('Critical'),
                SizedBox(width: 38),
                Radio(
                  value: true,
                  groupValue: _isNormalSelected,
                  onChanged: (value) {
                    setState(() {
                      _isNormalSelected = value!;
                      _isCriticalSelected = false;
                      _isAllSelected = false;
                    });
                  },
                ),
                Text('Normal'),
              ],
            ),
            //list of patients
            SizedBox(height: 16),

            PatientCard(
                title: 'John Doe',
                department: 'Emergency',
                subtitle: 'Male, 25',
                dateCreated: '2021-09-01',
                status: 'Critical',
                statusColor: Colors.red,
                icon: Icons.person,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PatientDetails(patientId: "23")),
                  );
                })
          ],
        ),
      ),
    );
  }
}

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';
import 'package:clinic_flutter_p1/model/patient.dart';
import 'package:clinic_flutter_p1/model/test.dart';
import '../lib/services/patient_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('Patient Service Test', () {
    WidgetsFlutterBinding.ensureInitialized();
    test('Get Patient List Test', () async {
      print('Get Patient List Test----->');
      final patientList = await getPatientList();

      expect(patientList, isInstanceOf<List>());
    });

    test('Get Patient By Id Test', () async {
      final patient = await getPatientById('6414f036d2ebe8ca4487fe95');
      expect(patient, isInstanceOf<Map<String, dynamic>>());
    });

    test('Add New Patient Test', () async {
      final patientData = Patient.empty();
      patientData.firstName = 'John';
      patientData.lastName = 'Doe';
      final isAdded = await addPatient(patientData);
      expect(isAdded, true);
    });

    test('Update Patient Test', () async {
      final patientData = Patient.empty();
      patientData.id = '6414f036d2ebe8ca4487fe95';
      patientData.firstName = 'John';
      patientData.lastName = 'Doe';
      final isUpdated =
          await updatePatient('6414f036d2ebe8ca4487fe95', patientData);
      expect(isUpdated, true);
    });

    test('Delete Patient Test', () async {
      final isDeleted = await deletePatient('6414f036d2ebe8ca4487fe95');
      expect(isDeleted, true);
    });

    test('Add Patient Test Test', () async {
      final testData = Test(
        category: 'blood pressure',
        reading: '120/80',
        patientId: '6414f036d2ebe8ca4487fe95',
        isCritical: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      final isAdded =
          await addPatientTest('6414f036d2ebe8ca4487fe95', testData);
      expect(isAdded, true);
    });

    test('Get Patient Tests Test', () async {
      final testList = await getPatientTests('6414f036d2ebe8ca4487fe95');
      expect(testList, isInstanceOf<List>());
    });

    test('Get Patient Histories Test', () async {
      final historyList = await getPatientHistories('6414f036d2ebe8ca4487fe95');
      expect(historyList, isInstanceOf<List>());
    });
  });
}

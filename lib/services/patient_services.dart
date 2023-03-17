import 'package:clinic_flutter_p1/model/patient.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../services/patient_services.dart';

Future<List<dynamic>> getPatientList() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token') ?? '';

  // Get the list of patients from the API with bearer token
  final response = await http.get(
    Uri.parse('http://localhost:3000/api/patients'),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );
  try {
    if (response.statusCode == 200) {
      var jsonString = response.body;
      var jsonMap = json.decode(jsonString);
      return jsonMap;
    } else {
      throw Exception('Failed to get patients from the API');
    }
  } catch (error) {
    throw Exception('Error: $error');
  }
}

// get patient by id

Future<dynamic> getPatientById(String id) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token') ?? '';

  // Get the patient from the API with bearer token
  final response = await http.get(
    Uri.parse('http://localhost:3000/api/patients/$id'),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );
  try {
    if (response.statusCode == 200) {
      var jsonString = response.body;
      var jsonMap = json.decode(jsonString);
      return jsonMap;
    } else {
      throw Exception('Failed to get patient from the API');
    }
  } catch (error) {
    throw Exception('Error: $error');
  }
}

// add new patient
// add new patient
Future<bool> addPatient(Patient patientData) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token') ?? '';

  print('Patient data before encoding: $patientData');
  final patientMap = patientData.toMap();
  print('Patient data as Map: $patientMap');
  final encodedData = json.encode(patientMap);
  print('Patient data after encoding: $encodedData');

  // Add the new patient to the API with bearer token
  final response = await http.post(
    Uri.parse('http://localhost:3000/api/patients'),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
    body: encodedData,
  );
  try {
    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to add patient to the API');
    }
  } catch (error) {
    throw Exception('Error: $error');
  }
}

// add delete patient

Future<bool> deletePatient(String id) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token') ?? '';

  // Delete the patient from the API with bearer token
  final response = await http.delete(
    Uri.parse('http://localhost:3000/api/patients/$id'),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );
  try {
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to delete patient from the API');
    }
  } catch (error) {
    throw Exception('Error: $error');
  }
}

// update patient

// update patient

Future<bool> updatePatient(String id, Patient patientData) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token') ?? '';

  print('Patient data before encoding: $patientData');
  final patientMap = patientData.toMap();
  print('Patient data as Map: $patientMap');
  final encodedData = json.encode(patientMap);
  print('Patient data after encoding: $encodedData');

  final response = await http.put(
    Uri.parse('http://localhost:3000/api/patients/$id'),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
    body: encodedData,
  );

  try {
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to update patient in the API');
    }
  } catch (error) {
    throw Exception('Error: $error');
  }
}

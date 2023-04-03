import 'package:flutter/material.dart';
import '../model/patient.dart';
import '../services/patient_services.dart';
import 'home_screen.dart';
import 'patient_details.dart';

class EditPatientScreen extends StatefulWidget {
  final Patient patient;

  const EditPatientScreen({Key? key, required this.patient}) : super(key: key);

  @override
  _EditPatientScreenState createState() => _EditPatientScreenState();
}

class _EditPatientScreenState extends State<EditPatientScreen> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  TextEditingController _statusController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize the text controllers with the patient data
    _firstNameController.text = widget.patient.firstName!;
    _lastNameController.text = widget.patient.lastName!;
    _ageController.text = widget.patient.age.toString();
    _genderController.text = widget.patient.gender!;
    _dobController.text = widget.patient.birthDate.toString();
    _emailController.text = widget.patient.email.toString();
    _phoneNumberController.text = widget.patient.phone.toString();
    _addressController.text = widget.patient.address.toString();
    _heightController.text = widget.patient.height.toString();
    _weightController.text = widget.patient.weight.toString();
    _statusController.text = widget.patient.status.toString();
  }

  void _submitForm() async {
    // get data from controllers
    String firstName = _firstNameController.text;
    String lastName = _lastNameController.text;
    int age = int.tryParse(_ageController.text) ?? 0;
    String gender = _genderController.text;
    String dob = _dobController.text;
    String email = _emailController.text;
    String phone = _phoneNumberController.text;
    String address = _addressController.text;
    double height = double.tryParse(_heightController.text) ?? 0.0;
    double weight = double.tryParse(_weightController.text) ?? 0.0;
    print('firstName: $firstName');
    print('lastName: $lastName');
    print('age: $age');
    print('dob: $dob');
    print('email: $email');
    print('phone: $phone');
    print('address: $address');
    print('height: $height');
    print('weight: $weight');

    // create patient object
    Patient updatedPatient = Patient(
      id: '',
      firstName: firstName,
      lastName: lastName,
      age: age,
      gender: gender,
      birthDate: DateTime.parse(dob),
      email: email,
      phone: phone,
      address: address,
      height: height,
      weight: weight,
    );

    // convert patient object to json
    print('patient:function: ');
    // submit patient to service
    await updatePatient(widget.patient.id.toString(), updatedPatient);

    // navigate back to home screen
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              PatientDetails(patientId: widget.patient.id.toString())),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0, // removes the box shadow
        backgroundColor: Colors.transparent, // removes the background
        iconTheme: IconThemeData(
          color: Colors.black, // sets the color of the icon to black
        ),
        textTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.black, // sets the color of the text to black
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        title: Text(
          'Edit Patient',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Patient Information',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 16),
              AppInput(
                controller: _firstNameController,
                hintText: 'First Name',
              ),
              SizedBox(height: 16),
              AppInput(
                controller: _lastNameController,
                hintText: 'Last Name',
              ),
              SizedBox(height: 16),
              AppInput(
                controller: _ageController,
                hintText: 'Age',
              ),
              SizedBox(height: 16),
              AppInput(
                controller: _genderController,
                hintText: 'Gender',
              ),
              SizedBox(height: 16),
              AppInput(
                controller: _dobController,
                hintText: 'Date of Birth',
              ),
              SizedBox(height: 16),
              AppInput(
                controller: _emailController,
                hintText: 'Email',
              ),
              SizedBox(height: 16),
              AppInput(
                controller: _phoneNumberController,
                hintText: 'Phone Number',
              ),
              SizedBox(height: 16),
              AppInput(
                controller: _addressController,
                hintText: 'Address',
              ),
              SizedBox(height: 16),
              AppInput(
                controller: _heightController,
                hintText: 'Height',
              ),
              SizedBox(height: 16),
              AppInput(
                controller: _weightController,
                hintText: 'Weight',
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _statusController.text,
                onChanged: (String? newValue) {
                  setState(() {
                    _statusController.text = newValue!;
                  });
                },
                items: <String>['critical', 'normal']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: "Status",
                  hintText: "Select Patient Status",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
              SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Implement patient information update logic
                    _submitForm();
                  },
                  child: Text('Update'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const AppInput({
    Key? key,
    required this.controller,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}

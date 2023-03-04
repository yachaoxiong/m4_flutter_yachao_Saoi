import 'package:flutter/material.dart';

class EditPatientScreen extends StatefulWidget {
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
              SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Implement patient information update logic
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

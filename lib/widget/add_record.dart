import 'package:flutter/material.dart';
import '../model/test.dart';
import '../services/patient_services.dart';

class AddRecordModal extends StatefulWidget {
  final String patientId;
  final VoidCallback onRecordAdded;

  const AddRecordModal({
    Key? key,
    required this.patientId,
    required this.onRecordAdded,
  }) : super(key: key);

  @override
  _AddRecordModalState createState() => _AddRecordModalState();
}

class _AddRecordModalState extends State<AddRecordModal> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Test test = Test();
  bool isCritical = false;
  String? _selectedCategory;

  List<String> _categories = [
    'blood pressure',
    'blood oxygen',
    'heart rate',
    'respiratory rate',
  ];

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      var testToAdd = Test(
        category: _selectedCategory,
        reading: test.reading,
        isCritical: isCritical,
      );
      await addPatientTest(widget.patientId, testToAdd);
      Navigator.of(context).pop();
      widget
          .onRecordAdded(); // Call the callback function when a new test is added.
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        title: Text('Add Record'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Category'),
                items: _categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a category';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Reading'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a reading';
                  }
                  return null;
                },
                onSaved: (value) {
                  test.reading = value;
                },
              ),
              Row(
                children: [
                  Checkbox(
                    value: isCritical,
                    onChanged: (bool? value) {
                      setState(() {
                        isCritical = value!;
                      });
                    },
                  ),
                  Text('Is Critical?'),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: _submit,
            child: Text('Add'),
          ),
        ],
      ),
    );
  }
}

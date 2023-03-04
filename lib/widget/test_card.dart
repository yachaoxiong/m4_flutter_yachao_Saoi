import 'package:flutter/material.dart';

class TestResultCard extends StatelessWidget {
  final IconData icon;
  final String type;
  final String value;
  final String dateCreated;
  final String testType;
  final String testStatus;

  const TestResultCard({
    Key? key,
    required this.icon,
    required this.type,
    required this.value,
    required this.dateCreated,
    required this.testType,
    required this.testStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 3.6,
      margin: EdgeInsets.all(22.0),
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // make icon center
            Icon(icon, size: 32),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(testType),
                  SizedBox(height: 4),
                  Text(dateCreated),
                ],
              ),
            ),
            SizedBox(width: 16),
            if (testStatus.toLowerCase() == 'critical')
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.red,
                ),
                child: Text(
                  testStatus,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

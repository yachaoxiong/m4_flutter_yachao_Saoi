import 'package:clinic_flutter_p1/theme.dart';
import 'package:flutter/material.dart';

class BmiCard extends StatelessWidget {
  final double bmiValue;
  final double heightValue;
  final double weightValue;

  const BmiCard({
    Key? key,
    required this.bmiValue,
    required this.heightValue,
    required this.weightValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue,
      elevation: 3.6,
      margin: EdgeInsets.all(22.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Normal',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.all(26),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Text(
                    bmiValue.toStringAsFixed(1),
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
            Container(
              height: 170,
              child: VerticalDivider(color: Colors.white, width: 2),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //icon people
                Icon(
                  Icons.accessibility,
                  size: 80,
                  color: Colors.white,
                ),
                SizedBox(height: 16),
                Text(
                  'Height: ${heightValue.toStringAsFixed(0)} cm',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                SizedBox(height: 8),
                Text(
                  'Weight: ${weightValue.toStringAsFixed(0)} kg',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

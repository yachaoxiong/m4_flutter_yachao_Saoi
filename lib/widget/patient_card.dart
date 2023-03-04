import 'package:clinic_flutter_p1/theme.dart';
import 'package:flutter/material.dart';

// left side has big icon and text below, right side has title and  text and status with background color
class PatientCard extends StatelessWidget {
  final String title;
  final String department;
  final String dateCreated;
  final String subtitle;
  final String status;
  final Color statusColor;
  final IconData icon;
  final Function onTap;

  const PatientCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.department,
    required this.dateCreated,
    required this.status,
    required this.statusColor,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        // gray line
        child: Row(
          children: [
            Container(
              width: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 80,
                  ),
                  Text(
                    department,
                    style: TextStyle(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(subtitle,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: greyLightColor)),
                    Text(dateCreated,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: greyLightColor)),
                    SizedBox(
                      height: 10,
                    ),
                    //add background color to status
                    Container(
                      // right and left padding

                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.2),
                      ),
                      child: Text(
                        // uppercase
                        status.toUpperCase(),
                        style: TextStyle(
                          color: statusColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

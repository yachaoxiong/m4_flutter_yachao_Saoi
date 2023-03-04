import 'package:flutter/material.dart';

class TimelineEvent {
  final String time;
  final String action;
  final IconData? icon;

  TimelineEvent({required this.time, required this.action, this.icon});
}

class TimelineWidget extends StatefulWidget {
  final List<TimelineEvent> events;
  final Color dotColor;
  final double dotSize;
  final Color lineColor;
  final double lineWidth;

  TimelineWidget({
    required this.events,
    this.dotColor = Colors.blue,
    this.dotSize = 22,
    this.lineColor = Colors.grey,
    this.lineWidth = 2,
  });

  @override
  _TimelineWidgetState createState() => _TimelineWidgetState();
}

class _TimelineWidgetState extends State<TimelineWidget> {
  int _selectedEventIndex = -1;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: widget.events.length,
      itemBuilder: (context, index) {
        final event = widget.events[index];
        final isSelected = index == _selectedEventIndex;
        return InkWell(
          onTap: () => setState(() => _selectedEventIndex = index),
          child: Padding(
            //padding left
            padding: const EdgeInsets.only(left: 80, right: 20, top: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Stack(
                    children: [
                      Container(
                        width: widget.dotSize,
                        height: widget.dotSize,
                        decoration: BoxDecoration(
                          color: isSelected ? widget.dotColor : Colors.white,
                          border: Border.all(
                            color: widget.dotColor,
                            width: isSelected ? 0 : widget.lineWidth,
                          ),
                          borderRadius:
                              BorderRadius.circular(widget.dotSize / 2),
                        ),
                        child: Icon(
                          event.icon ?? Icons.circle,
                          color: isSelected ? Colors.white : widget.dotColor,
                          size: widget.dotSize / 2,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event.time,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isSelected ? widget.dotColor : Colors.grey,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          event.action,
                          style: TextStyle(
                            color: isSelected ? Colors.black : Colors.grey,
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
      },
    );
  }
}

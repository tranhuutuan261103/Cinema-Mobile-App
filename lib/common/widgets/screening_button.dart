import 'package:flutter/material.dart';

import '../models/screening.dart';

class ScreeningButton extends StatelessWidget {
  final Screening screening;
  final Function onPressed;

  const ScreeningButton(
      {super.key, required this.screening, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        width: 120,
        height: 70,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[300]!, // Border color
            width: 2.0, // Border width
          ),
          borderRadius: BorderRadius.circular(
              8.0), // Optional: Add a border radius if you want rounded corners
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${screening.startTime.hour.toString().padLeft(2, '0')}:${screening.startTime.minute.toString().padLeft(2, '0')}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    ' ~${screening.endTime.hour.toString().padLeft(2, '0')}:${screening.endTime.minute.toString().padLeft(2, '0')}',
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(6.0),
                  bottomRight: Radius.circular(6.0),
                ),
                border: Border.all(
                  color: Colors.grey[300]!, // Border color
                  width: 2.0, // Border width
                ),
                color: Colors.grey[300],
              ),
              child: Text(
                'Còn ${screening.seatsAvailable}/${screening.seatsTotal}',
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

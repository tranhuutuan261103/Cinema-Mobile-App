import 'package:flutter/material.dart';

import '../../models/seat.dart';
import '../../constants/colors.dart';

class SeatBooking extends StatelessWidget {
  final Seat? seat;
  final double seatSize;

  const SeatBooking({
    super.key,
    required this.seat,
    required this.seatSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: seatSize,
      height: seatSize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: colorPrimary,
      ),
      child: Center(
        child: seat != null
            ? Text(
                '${String.fromCharCode(65 + seat!.row)}${seat!.number + 1}',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              )
            : const SizedBox(),
      ),
    );
  }
}

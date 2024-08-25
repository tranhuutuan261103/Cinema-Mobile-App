import 'package:flutter/material.dart';

import '../../models/seat.dart';

class SeatNormal extends StatelessWidget {
  final Seat? seat;
  final double seatSize;

  const SeatNormal({
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
        color: const Color.fromRGBO(239, 219, 254, 1),
      ),
      child: Center(
        child: seat != null
            ? Text(
                '${String.fromCharCode(65 + seat!.row)}${seat!.number + 1}',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color.fromRGBO(114, 61, 179, 1),
                  fontWeight: FontWeight.w600,
                ),
              )
            : const SizedBox(),
      ),
    );
  }
}

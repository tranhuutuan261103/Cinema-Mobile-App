import 'package:flutter/material.dart';

import '../../models/seat.dart';

class SeatVip extends StatelessWidget {
  final Seat? seat;
  final double seatSize;

  const SeatVip({
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
        color: const Color.fromRGBO(254, 205, 201, 1),
      ),
      child: Center(
        child: seat != null
            ? Text(
                '${String.fromCharCode(65 + seat!.row)}${seat!.number + 1}',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color.fromRGBO(211, 56, 60, 1),
                  fontWeight: FontWeight.w600,
                ),
              )
            : const SizedBox(),
      ),
    );
  }
}

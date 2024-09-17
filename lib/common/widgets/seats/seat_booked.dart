import 'package:flutter/material.dart';

import '../../models/seat.dart';

class SeatBooked extends StatelessWidget {
  final Seat? seat;
  final double seatSize;

  const SeatBooked({
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
        border: Border.all(
          color: const Color.fromRGBO(203, 203, 203, 1),
          width: 2,
        ),
        color: const Color.fromRGBO(229, 229, 229, 1),
      ),
      child: Center(
        child: Icon(
          Icons.close,
          color: const Color.fromRGBO(203, 203, 203, 1),
          size: seatSize - 5,
        ),
      ),
    );
  }
}

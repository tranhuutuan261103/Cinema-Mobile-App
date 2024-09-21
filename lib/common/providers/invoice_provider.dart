import 'package:flutter/material.dart';

import '../models/seat.dart';

class InvoiceProvider extends ChangeNotifier {
  final List<Seat> _seats = [];

  void addSeat(Seat seat) {
    _seats.add(seat);
    notifyListeners();
  }

  void removeSeat(Seat seat) {
    _seats.remove(seat);
    notifyListeners();
  }

  List<Seat> get getSeats => _seats;

  void clear() {
    _seats.clear();
  }
}
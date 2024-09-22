import 'package:cinema_mobile_app/common/models/screening.dart';
import 'package:flutter/material.dart';

import '../models/seat.dart';
import '../models/product_combo.dart';

class InvoiceProvider extends ChangeNotifier {
  Screening? _screening;
  final List<Seat> _seats = [];
  final List<Map<ProductCombo, int>> _productCombos = [];

  void setScreening(Screening screening) {
    _screening = screening;
    notifyListeners();
  }

  Screening? get getScreening => _screening;

  void addSeat(Seat seat) {
    _seats.add(seat);
    notifyListeners();
  }

  void removeSeat(Seat seat) {
    _seats.remove(seat);
    notifyListeners();
  }

  void addProductCombo(ProductCombo productCombo) {
    final index = _productCombos
        .indexWhere((element) => element.keys.first.id == productCombo.id);

    if (index != -1) {
      final productComboFound = _productCombos[index].keys.first;

      _productCombos[index][productComboFound] =
          _productCombos[index][productComboFound]! + 1;
    } else {
      _productCombos.add({productCombo: 1});
    }
    notifyListeners();
  }

  void removeProductCombo(ProductCombo productCombo) {
    final index = _productCombos
        .indexWhere((element) => element.keys.first.id == productCombo.id);

    if (index != -1) {
      final productComboFound = _productCombos[index].keys.first;
      if (_productCombos[index][productComboFound]! > 1) {
        _productCombos[index][productComboFound] =
            _productCombos[index][productComboFound]! - 1;
      } else {
        _productCombos.removeAt(index);
      }
    }
    notifyListeners();
  }

  List<Seat> get getSeats => _seats;
  List<Map<ProductCombo, int>> get getProductCombos => _productCombos;

  double get getTotalProductPrice {
    double totalPrice = 0;

    for (final productCombo in _productCombos) {
      totalPrice += productCombo.keys.first.price * productCombo.values.first;
    }

    return totalPrice;
  }


  double get getTotalPrice {
    double totalPrice = 0;

    for (final productCombo in _productCombos) {
      totalPrice += productCombo.keys.first.price * productCombo.values.first;
    }

    for (final seat in _seats) {
      totalPrice += seat.seatPrices.first.price;
    }

    return totalPrice;
  }

  void clear() {
    _seats.clear();
  }
}

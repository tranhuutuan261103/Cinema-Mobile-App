import 'package:flutter/material.dart';
import '../services/province_service.dart';
import '../models/province.dart';

class ProvinceProvider extends ChangeNotifier {
  List<Province> _provinces = [];
  List<Province> get provinces => _provinces;

  Province? _selectedProvince;
  Province? get selectedProvince => _selectedProvince;
  int? get selectedProvinceId => _selectedProvince?.id;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getProvinces() async {
    _isLoading = true;
    notifyListeners();

    try {
      _provinces = await ProvinceService().getProvinces();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setSelectedProvince(Province province) {
    _selectedProvince = province;
    notifyListeners();
  }
}
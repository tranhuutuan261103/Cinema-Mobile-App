import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  ProvinceProvider () {
    _getProvinces().then(
      (_) => _loadProvince(
    ));
  }

  Future<void> _loadProvince() async {
    final prefs = await SharedPreferences.getInstance();
    final provinceId = prefs.getInt('provinceId');
    final provinceName = prefs.getString('provinceName');
    if (provinceId != null && provinceName != null) {
      _selectedProvince = Province(id: provinceId, name: provinceName);
    } else {
      _selectedProvince = Province(id: 1, name: "Hà Nội");
    }
    notifyListeners();
  }

  Future<void> _getProvinces() async {
    _isLoading = true;
    notifyListeners();

    try {
      _provinces = await ProvinceService().getProvinces();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> setSelectedProvince(Province province) async {
    _selectedProvince = province;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('provinceId', province.id);
    await prefs.setString('provinceName', province.name);
    notifyListeners();
  }
}
import 'package:cinema_mobile_app/models/province.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import '../providers/province_provider.dart';

class ProvinceSelectionScreen extends StatefulWidget {
  const ProvinceSelectionScreen({super.key});

  @override
  State<ProvinceSelectionScreen> createState() => _ProvinceSelectionScreenState();
}

class _ProvinceSelectionScreenState extends State<ProvinceSelectionScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<Province> _provinces = [];

  @override
  void initState() {
    super.initState();
    // Initialize the list with all provinces
    _provinces = Provider.of<ProvinceProvider>(context, listen: false).provinces;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: colorPrimary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  // Update the state with filtered provinces
                  setState(() {
                    final allProvinces = Provider.of<ProvinceProvider>(context, listen: false).provinces;
                    _provinces = allProvinces.where((province) {
                      return province.name.toLowerCase().contains(value.toLowerCase());
                    }).toList();
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Nhập tên tỉnh/thành phố',
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        elevation: 0,
        toolbarHeight: 60,
        leading: null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: SizedBox(
            width: double.infinity,
            child: Consumer<ProvinceProvider>(
              builder: (context, provinceProvider, child) {
                if (provinceProvider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  // If there are search results, use them; otherwise, use the original province list
                  final provinces = _provinces.isNotEmpty || _searchController.text.isNotEmpty
                      ? _provinces
                      : provinceProvider.provinces;

                  if (provinces.isEmpty) {
                    return const Center(
                      child: Text(
                        'Không tìm thấy tỉnh/thành phố',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }
                  
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 16.0,
                        ),
                        child: Column(
                          children: provinces.map((province) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context, province);
                                },
                                child: _buildProvinceItem(province.name),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProvinceItem(String city) {
    return SizedBox(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(
            Icons.location_city,
            color: Colors.black,
          ),
          const SizedBox(width: 16),
          Text(
            city,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

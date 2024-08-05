import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import '../providers/province_provider.dart';

class ProvinceSelectionScreen extends StatefulWidget {
  final String title;

  const ProvinceSelectionScreen({super.key, required this.title});

  @override
  _ProvinceSelectionScreenState createState() =>
      _ProvinceSelectionScreenState();
}

class _ProvinceSelectionScreenState extends State<ProvinceSelectionScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch provinces when the widget initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProvinceProvider>(context, listen: false).getProvinces();
    });
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
            const Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Nhập tên tỉnh/thành phố',
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                ),
                style: TextStyle(color: Colors.white),
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
                  return const SizedBox(
                    width: double.infinity,
                    child: LinearProgressIndicator(),
                  );
                } else {
                  final provinces = provinceProvider.provinces;
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: provinces.map((province) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: InkWell(
                                onTap: () {
                                  provinceProvider.setSelectedProvince(province);
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
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(
            Icons.location_city,
            color: Colors.black,
          ),
          const SizedBox(width: 8),
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

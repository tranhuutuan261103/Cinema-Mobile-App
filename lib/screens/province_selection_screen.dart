import 'package:flutter/material.dart';

import '../constants/colors.dart'; // Ensure you import the color constants
import '../models/province.dart'; // Import the model to represent provinces
import '../services/province_service.dart'; // Import the service to fetch provinces

class ProvinceSelectionScreen extends StatefulWidget {
  final String title;

  const ProvinceSelectionScreen({super.key, required this.title});

  @override
  State<ProvinceSelectionScreen> createState() => _ProvinceSelectionState();
}

class _ProvinceSelectionState extends State<ProvinceSelectionScreen> {
  late Future<List<Province>> _provincesFuture;

  @override
  void initState() {
    super.initState();
    _provincesFuture = ProvinceService().getProvinces();
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
                // Handle cancel button press
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
        elevation: 0, // Optional: Remove shadow from AppBar
        toolbarHeight: 60, // Optional: Adjust height of AppBar
        leading: null, // Remove the default back button
      ),
      body: Expanded(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FutureBuilder(
                        future: _provincesFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const SizedBox(
                              width: double.infinity,
                              child: LinearProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Text("Error: ${snapshot.error}");
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Text("No provinces available");
                          } else {
                            final provinces = snapshot.data!;
                            return Column(
                              children: provinces.map((province) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: InkWell(
                                    onTap: () {
                                      // Handle province selection
                                      Navigator.pop(context, province);
                                    },
                                    child: _buildProvinceItem(province.name),
                                  ),
                                );
                              }).toList(),
                            );
                          }
                        },
                      ),
                    )),
              ),
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

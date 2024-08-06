import 'package:cinema_mobile_app/providers/province_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../models/cinema.dart';
import '../services/cinema_service.dart';

class AuditoriumSelectionScreen extends StatefulWidget {
  final String title;

  // ignore: use_super_parameters
  const AuditoriumSelectionScreen({Key? key, required this.title})
      : super(key: key);

  @override
  State<AuditoriumSelectionScreen> createState() =>
      _AuditoriumSelectionScreenState();
}

class _AuditoriumSelectionScreenState extends State<AuditoriumSelectionScreen> {
  late Future<List<Cinema>> _cinemasFuture;

  @override
  void initState() {
    super.initState();
    _cinemasFuture = CinemaService().getCinemas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.title,
                style: const TextStyle(
                  color: Colors.white,
                )),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/city');
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white, // Text color
                backgroundColor:
                    const Color.fromARGB(255, 168, 68, 225), // Background color
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 8), // Adjust padding as needed
              ),
              child: Row(
                mainAxisSize: MainAxisSize
                    .min, // Ensures the button size fits the content
                children: [
                  Consumer<ProvinceProvider>(
                      builder: (context, ProvinceProvider provider, child) {
                    return Text(
                        provider.selectedProvince?.name ?? "Chọn tỉnh thành");
                  }), // Text
                  const SizedBox(width: 8), // Space between text and icon
                  const Icon(Icons.location_city, color: Colors.white), // Icon
                ],
              ),
            )
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FutureBuilder(
              future: _cinemasFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(
                    width: double.infinity,
                    child: LinearProgressIndicator(),
                  );
                } else {
                  final cinemas = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        width: double.infinity,
                        child: Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                  children: cinemas.map((cinema) {
                                return _buildCinemaItem(cinema);
                              }).toList()),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
              }),
          const Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Text(
              "Danh sách phòng chiếu",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          FutureBuilder(
              future: _cinemasFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(
                    width: double.infinity,
                    child: LinearProgressIndicator(),
                  );
                } else {
                  final cinemas = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        width: double.infinity,
                        child: Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Column(
                                  children:
                                      cinemas[0].auditoriums.map((auditorium) {
                                return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Image.network(
                                                  cinemas[0].logoUrl,
                                                  width: 50,
                                                  height: 50,
                                                  fit: BoxFit.cover,
                                                ),
                                                const SizedBox(width: 8),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          auditorium.name,
                                                          style: const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          "${auditorium.latitude} ${auditorium.longitude}",
                                                          style: const TextStyle(
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const Icon(Icons
                                                        .arrow_forward_ios_rounded),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 200,
                                          child: Text(
                                            auditorium.address,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ));
                              }).toList()),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
              })
        ],
      ),
    );
  }

  Widget _buildCinemaItem(Cinema cinema) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey, // Border color
                width: 2.0, // Border width
              ),
              borderRadius: BorderRadius.circular(
                  8.0), // Optional: Add a border radius if you want rounded corners
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                  8.0), // Optional: Apply the same radius if you use a border radius
              child: Image.network(
                cinema.logoUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            cinema.name,
          ),
        ],
      ),
    );
  }
}

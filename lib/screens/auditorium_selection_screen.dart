import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../screens/province_selection_screen.dart';
import '../widgets/cinema_button.dart';
import '../widgets/not_found_container.dart';
import '../providers/province_provider.dart';
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
  Cinema? _selectedCinema; // Biến lưu cinema đã chọn

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchCinemas();
  }

  @override
  void initState() {
    super.initState();
    _fetchCinemas();
  }

  void _fetchCinemas() {
    final provinceId = Provider.of<ProvinceProvider>(context, listen: false)
        .selectedProvinceId;
    if (provinceId != null) {
      setState(() {
        _cinemasFuture = CinemaService().getCinemas(provinceId: provinceId);
        _cinemasFuture.then((cinemas) {
          if (cinemas.isNotEmpty) {
            setState(() {
              _selectedCinema = cinemas[0];
            });
          }
        });
      });
    } else {
      setState(() {
        _cinemasFuture = CinemaService().getCinemas();
        _cinemasFuture.then((cinemas) {
          if (cinemas.isNotEmpty) {
            setState(() {
              _selectedCinema = cinemas[0];
            });
          }
        });
      });
    }
  }

  void _showProvinceSelectionScreen(BuildContext context) async {
    final selectedProvince = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return const FractionallySizedBox(
          heightFactor: 0.8,
          child: ProvinceSelectionScreen(),
        );
      },
    );

    if (selectedProvince != null) {
      Provider.of<ProvinceProvider>(context, listen: false)
          .setSelectedProvince(selectedProvince);
      _fetchCinemas();
    }
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
                _showProvinceSelectionScreen(context);
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
                        provider.selectedProvince?.name ?? "Tỉnh/thành");
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
                  return const Expanded(
                      child: Center(child: CircularProgressIndicator()));
                } else if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    // Nếu không có dữ liệu cinema thì không hiển thị gì cả
                    return const Padding(
                      padding:
                          EdgeInsets.only(top: 64.0, left: 16.0, right: 16.0),
                      child: NotFoundContainer(
                        message:
                            "Úi, hình như tụi mình chưa kết nối với rạp này.",
                        subMessage: "Bạn hãy thử tìm rạp khác nhé!",
                        icon: Icons.location_city,
                      ),
                    );
                  }

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
                                return CinemaButton(
                                  cinema: cinema,
                                  isSelected: _selectedCinema == cinema,
                                  onPressed: () {
                                    setState(() {
                                      _selectedCinema = cinema;
                                    });
                                  },
                                );
                              }).toList()),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              }),
          FutureBuilder(
              future: _cinemasFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    return const SizedBox.shrink();
                  }

                  return const Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text(
                      "Danh sách phòng chiếu",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              }),
          FutureBuilder(
              future: _cinemasFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox.shrink();
                } else if (snapshot.hasData) {
                  final cinemas = snapshot.data!;
                  if (cinemas.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  final auditoriums = _selectedCinema != null
                      ? _selectedCinema!.auditoriums
                      : cinemas[0].auditoriums;

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
                            child: Column(
                                children: auditoriums.map((auditorium) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Image.network(
                                        _selectedCinema?.logoUrl ??
                                            cinemas[0].logoUrl,
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
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
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    auditorium.address,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  if (auditorium != auditoriums.last)
                                    const Divider(),
                                ],
                              );
                            }).toList()),
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return const Text('Không có dữ liệu auditorium.');
                }
              }),
        ],
      ),
    );
  }
}

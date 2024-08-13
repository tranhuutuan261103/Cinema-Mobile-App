import 'package:cinema_mobile_app/widgets/screening_button.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../models/cinema.dart';
import '../../models/movie.dart';
import '../../widgets/cinema_button.dart';
import '../../widgets/not_found_container.dart';
import '../../services/screening_service.dart';
import '../../utils/datetime_helper.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  late final List<DateTime> _days;
  DateTime _selectedDate = DateTime.now();

  late Future<List<Cinema>> _cinemasFuture;
  Cinema? _selectedCinema;

  @override
  void initState() {
    super.initState();
    _days = List.generate(14, (index) {
      final date = DateTime.now().add(Duration(days: index));
      return date;
    });
    _fetchCinemas();
  }

  void _fetchCinemas() {
    setState(() {
      _cinemasFuture = ScreeningService().getScreenings(provinceId: 1);
      if (_selectedCinema == null) {
        _cinemasFuture.then((cinemas) {
          if (cinemas.isNotEmpty) {
            setState(() {
              _selectedCinema = cinemas[0];
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: Column(
        children: [
          // Date selection
          Container(
            width: double.infinity,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            child: Column(
              children: [
                SizedBox(
                  height: 70,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _days.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          setState(() {
                            _selectedDate = _days[index];
                            _cinemasFuture = ScreeningService().getScreenings(
                                provinceId: 1, startDate: _selectedDate);
                            _cinemasFuture.then((cinemas) {
                              if (cinemas.isNotEmpty) {
                                setState(() {
                                  _selectedCinema = cinemas[0];
                                });
                              }
                            });
                          });
                        },
                        child: Container(
                          width: 42,
                          margin: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: _days[index].day == _selectedDate.day
                                  ? colorPrimary
                                  : Colors.grey[300]!,
                              width: 1,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: Text(
                                  DatetimeHelper.getFormattedWeekDay(
                                      _days[index].weekday),
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: _days[index].day == _selectedDate.day
                                        ? colorPrimary
                                        : Colors.black,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: _days[index].day == _selectedDate.day
                                        ? colorPrimary
                                        : Colors.grey[300]!,
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(7),
                                      bottomRight: Radius.circular(7),
                                    ),
                                    border: Border.all(
                                      color:
                                          _days[index].day == _selectedDate.day
                                              ? colorPrimary
                                              : Colors.grey[300]!,
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    _days[index].day.toString(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          _days[index].day == _selectedDate.day
                                              ? Colors.white
                                              : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  FutureBuilder<List<Cinema>>(
                    future: _cinemasFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasData) {
                        if (snapshot.data!.isEmpty) {
                          return const Padding(
                            padding: EdgeInsets.only(
                                top: 64.0, left: 16.0, right: 16.0),
                            child: NotFoundContainer(
                              message:
                                  "Úi, hình như tụi mình chưa kết nối với rạp này.",
                              subMessage: "Bạn hãy thử tìm rạp khác nhé!",
                              icon: Icons.location_city,
                            ),
                          );
                        }

                        final cinemas = snapshot.data!;
                        return SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                color: Colors.white,
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
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                  FutureBuilder<List<Cinema>>(
                      future: _cinemasFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SizedBox.shrink();
                        }

                        if (snapshot.hasData) {
                          final cinemas = snapshot.data!;
                          if (cinemas.isEmpty) {
                            return const SizedBox.shrink();
                          }
                        }

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: [
                              _selectedCinema != null
                                  ? Text(
                                      '${_selectedCinema!.name} (${_selectedCinema!.auditoriums.length})',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ))
                                  : const SizedBox.shrink(),
                            ],
                          ),
                        );
                      }),
                  FutureBuilder<List<Cinema>>(
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
                            child: Container(
                              color: Colors.white,
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
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                    const SizedBox(height: 8),
                                    GridView.builder(
                                      shrinkWrap:
                                          true, // Ensures the GridView only takes up necessary space
                                      physics:
                                          const NeverScrollableScrollPhysics(), // Disable scrolling for this GridView
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount:
                                            3, // Adjust this number based on your design
                                        crossAxisSpacing:
                                            8.0, // Spacing between columns
                                        mainAxisSpacing:
                                            8.0, // Spacing between rows
                                        childAspectRatio:
                                            1.5, // Adjust the ratio to match your button design
                                      ),
                                      itemCount: auditorium.screenings.length,
                                      itemBuilder: (context, index) {
                                        final screening =
                                            auditorium.screenings[index];
                                        return ScreeningButton(
                                          screening: screening,
                                          onPressed: () {},
                                        );
                                      },
                                    ),
                                    if (auditorium != auditoriums.last)
                                      const Divider(),
                                  ],
                                );
                              }).toList()),
                            ),
                          ),
                        );
                      } else {
                        return const Text('Không có dữ liệu auditorium.');
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

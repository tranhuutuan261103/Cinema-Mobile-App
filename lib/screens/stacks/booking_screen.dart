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
  Cinema? _selectedCinema; // Biến lưu cinema đã chọn

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
                        // blur when tapped
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          setState(() {
                            _selectedDate = _days[index];
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
          Padding(
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
          ),
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
                                  const SizedBox(height: 8),
                                  Column(
                                    children:
                                        auditorium.screenings.map((screening) {
                                      return Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                screening.startTime.toString(),
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                screening.id.toString(),
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                        ],
                                      );
                                    }).toList(),
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

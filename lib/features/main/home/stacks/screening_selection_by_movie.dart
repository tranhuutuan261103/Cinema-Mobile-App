import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../common/providers/province_provider.dart';

import '../../../../common/constants/colors.dart';
import '../../../../common/models/cinema.dart';
import '../../../../common/models/movie.dart';
import '../../../../common/services/screening_service.dart';
import '../../../../common/routes/routes.dart';
import '../../../../common/utils/datetime_helper.dart';
import '../../../../common/widgets/cinema_button.dart';
import '../../../../common/widgets/not_found_container.dart';
import '../../../../common/widgets/screening_button.dart';

import '../../../stacks/province_selection_screen.dart';

class ScreeningSelectionByMovie extends StatefulWidget {
  final Movie movie;
  const ScreeningSelectionByMovie({super.key, required this.movie});

  @override
  State<ScreeningSelectionByMovie> createState() => _ScreeningSelectionByMovieState();
}

class _ScreeningSelectionByMovieState extends State<ScreeningSelectionByMovie> {
  late final List<DateTime> _days;
  DateTime _selectedDate = DateTime.now();

  late Future<List<Cinema>> _cinemasFuture;
  Cinema? _selectedCinema;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchCinemas();
  }

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
    int provinceId = Provider.of<ProvinceProvider>(context, listen: false)
        .selectedProvince!
        .id;
    setState(() {
      _cinemasFuture = ScreeningService().getScreeningsByMovieId(
          movieId: widget.movie.id,
          provinceId: provinceId,
          startDate: _selectedDate);
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        title: Text(widget.movie.title),
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
                            int provinceId = Provider.of<ProvinceProvider>(
                                    context,
                                    listen: false)
                                .selectedProvince!
                                .id;
                            _selectedDate = _days[index];
                            _cinemasFuture = ScreeningService()
                                .getScreeningsByMovieId(
                                    movieId: widget.movie.id,
                                    provinceId: provinceId,
                                    startDate: _selectedDate);
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
              child: FutureBuilder<List<Cinema>>(
                future: _cinemasFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
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
                    final selectedCinema = _selectedCinema ?? cinemas[0];
                    final auditoriums = selectedCinema.auditoriums;

                    return Column(
                      children: [
                        SizedBox(
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
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${selectedCinema.name} (${selectedCinema.auditoriums.length})',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  _showProvinceSelectionScreen(context);
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: colorPrimary, // Text color
                                  backgroundColor:
                                      Colors.transparent, // Background color
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8), // Adjust padding as needed
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  side: const BorderSide(
                                    color: colorPrimary,
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize
                                      .min, // Ensures the button size fits the content
                                  children: [
                                    // Space between text and icon
                                    const Icon(Icons.center_focus_weak,
                                        color: colorPrimary), // Icon
                                    const SizedBox(width: 8),
                                    Consumer<ProvinceProvider>(builder:
                                        (context, ProvinceProvider provider,
                                            child) {
                                      return Text(
                                          provider.selectedProvince?.name ??
                                              "Tỉnh/thành");
                                    }), // Text
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              color: Colors.white,
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: auditoriums.map((auditorium) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Image.network(
                                            selectedCinema.logoUrl,
                                            width: 50,
                                            height: 50,
                                            fit: BoxFit.cover,
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                context,
                                                Routes.seatSelectionScreen,
                                                arguments: [
                                                  auditorium,
                                                  screening,
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),
                                      if (auditorium != auditoriums.last)
                                        const Divider(),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
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
}

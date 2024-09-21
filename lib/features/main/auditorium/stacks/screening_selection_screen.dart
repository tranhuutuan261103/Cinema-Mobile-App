import 'package:flutter/material.dart';

import '../../../../common/constants/colors.dart';
import '../../../../common/models/movie.dart';
import '../../../../common/models/auditorium.dart';
import '../../../../common/services/screening_service.dart';
import '../../../../common/routes/routes.dart';
import '../../../../common/utils/datetime_helper.dart';
import '../../../../common/widgets/screening_button.dart';
import '../../../../common/widgets/not_found_container.dart';
import '../../../main/home/stacks/movie_detail_screen.dart';

class ScreeningSelectionScreen extends StatefulWidget {
  final Auditorium auditorium;
  const ScreeningSelectionScreen({super.key, required this.auditorium});

  @override
  State<ScreeningSelectionScreen> createState() =>
      _ScreeningSelectionScreenState();
}

class _ScreeningSelectionScreenState extends State<ScreeningSelectionScreen> {
  late final List<DateTime> _days;
  DateTime _selectedDate = DateTime.now();

  late Future<List<Movie>> _moviesFuture;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchMovies();
  }

  @override
  void initState() {
    super.initState();
    _days = List.generate(14, (index) {
      final date = DateTime.now().add(Duration(days: index));
      return date;
    });
    _fetchMovies();
  }

  void _fetchMovies() {
    setState(() {
      _moviesFuture = ScreeningService().getScreeningsByAuditoriumId(
          auditoriumId: widget.auditorium.id, startDate: _selectedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        title: Text(widget.auditorium.name),
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
                            _moviesFuture = ScreeningService()
                                .getScreeningsByAuditoriumId(
                                    auditoriumId: widget.auditorium.id,
                                    startDate: _selectedDate);
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
              child: FutureBuilder<List<Movie>>(
                future: _moviesFuture,
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

                    final movies = snapshot.data!;

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              color: Colors.white,
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: movies.map((movie) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              movie.title,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 24),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      MovieDetailScreen(
                                                          movie: movie),
                                                ),
                                              );
                                            },
                                            style: TextButton.styleFrom(
                                              padding: EdgeInsets
                                                  .zero, // Loại bỏ padding để trông giống liên kết hơn
                                              minimumSize: const Size(0,
                                                  0), // Loại bỏ kích thước tối thiểu
                                              tapTargetSize: MaterialTapTargetSize
                                                  .shrinkWrap, // Thu nhỏ vùng nhấn
                                              visualDensity: VisualDensity
                                                  .compact, // Giảm mật độ hiển thị
                                              enableFeedback:
                                                  false, // Tắt hiệu ứng khi nhấn
                                            ),
                                            child: const Text(
                                              'Chi tiết',
                                              style: TextStyle(
                                                color: colorPrimary,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        '${movie.categories.map((e) => e.name).join(", ")} | ${movie.language} | ${movie.duration} phút',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.network(
                                              movie.imageUrl,
                                              width: 100,
                                              height: 100 * 1.5,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: GridView.builder(
                                              shrinkWrap:
                                                  true, // Ensures the GridView only takes up necessary space
                                              physics:
                                                  const NeverScrollableScrollPhysics(), // Disable scrolling for this GridView
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount:
                                                    2, // Adjust this number based on your design
                                                crossAxisSpacing:
                                                    8.0, // Spacing between columns
                                                mainAxisSpacing:
                                                    8.0, // Spacing between rows
                                                childAspectRatio:
                                                    1.5, // Adjust the ratio to match your button design
                                              ),
                                              itemCount:
                                                  movie.screenings.length,
                                              itemBuilder: (context, index) {
                                                final screening =
                                                    movie.screenings[index];
                                                return ScreeningButton(
                                                  screening: screening,
                                                  onPressed: () {
                                                    Navigator.pushNamed(
                                                      context,
                                                      Routes
                                                          .seatSelectionScreen,
                                                      arguments: [
                                                        widget.auditorium,
                                                        screening,
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      if (movie != movies.last) const Divider(),
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
}

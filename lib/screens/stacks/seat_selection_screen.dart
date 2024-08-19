import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../models/screening.dart';
import '../../services/screening_service.dart';
import '../../utils/datetime_helper.dart';

class SeatSelectionScreen extends StatefulWidget {
  final int screeningId;
  final double offset = 10.0;
  final double seatSize = 30.0;
  final double spacing = 10.0; // Khoảng cách giữa các ghế

  const SeatSelectionScreen({super.key, required this.screeningId});

  @override
  State<SeatSelectionScreen> createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  late Future<Screening> _futureScreening;

  @override
  void initState() {
    super.initState();
    _futureScreening = fetchScreening();
  }

  Future<Screening> fetchScreening() async {
    // Get screening data from API by screening.id
    return ScreeningService().getScreening(widget.screeningId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        title: FutureBuilder<Screening>(
          future: _futureScreening,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final screening = snapshot.data!;
              return Text(screening.auditorium!.name);
            }
          },
        ),
      ),
      body: FutureBuilder<Screening>(
        future: _futureScreening,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final screening = snapshot.data!;
            return Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 40,
                  color: Colors.white,
                  child: const Text(
                    'Màn hình',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Container(
                        width: widget.seatSize * 12 +
                            widget.spacing * 11 +
                            widget.offset,
                        height: widget.seatSize * 12 +
                            widget.spacing * 11 +
                            widget.offset,
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(12, (row) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(12, (column) {
                                final seat = screening.seats!.firstWhere(
                                  (seat) =>
                                      seat.row == row + 1 &&
                                      seat.number == column + 1,
                                );
                                return Padding(
                                  padding: EdgeInsets.only(
                                      right: column != 11
                                          ? widget.spacing
                                          : 0, // Thêm khoảng cách bên phải trừ ghế cuối cùng
                                      bottom: row != 11
                                          ? widget.spacing
                                          : 0), // Thêm khoảng cách bên dưới trừ hàng cuối cùng
                                  child: Container(
                                    width: widget.seatSize,
                                    height: widget.seatSize,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black,
                                      ),
                                      color: seat.seatStatus.isAvailable
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${String.fromCharCode(65 + row)}${column + 1}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        color: Colors.green,
                      ),
                      const Text('Available'),
                      Container(
                        width: 20,
                        height: 20,
                        color: Colors.red,
                      ),
                      const Text('Booked'),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  height: 190,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              screening.movie!.title,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                // Change screening action
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets
                                    .zero, // Loại bỏ padding để trông giống liên kết hơn
                                minimumSize: const Size(
                                    0, 0), // Loại bỏ kích thước tối thiểu
                                tapTargetSize: MaterialTapTargetSize
                                    .shrinkWrap, // Thu nhỏ vùng nhấn
                                visualDensity: VisualDensity
                                    .compact, // Giảm mật độ hiển thị
                              ),
                              child: const Text(
                                'Đổi suất',
                                style: TextStyle(
                                  color: colorPrimary,
                                ),
                              )),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            '${screening.startTime.hour.toString().padLeft(2, '0')}:${screening.startTime.minute.toString().padLeft(2, '0')}',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            ' ~ ${screening.endTime.hour.toString().padLeft(2, '0')}:${screening.endTime.minute.toString().padLeft(2, '0')}',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                              ' | ${DatetimeHelper.getFormattedWeekDay(screening.startDate.weekday)}  ${screening.startDate.day}/${screening.startDate.month}/${screening.startDate.year}',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Row(
                        children: [
                          Text(
                            'Tạm tính',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          Spacer(),
                          Text(
                            '0đ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          // Book ticket action
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Text(
                          'Đặt vé',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
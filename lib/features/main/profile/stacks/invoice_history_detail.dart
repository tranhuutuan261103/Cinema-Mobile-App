import 'package:flutter/material.dart';

import '../../../../common/constants/colors.dart';
import '../../../../common/models/invoice.dart';
import '../../../../common/utils/datetime_helper.dart';

class InvoiceHistoryDetail extends StatelessWidget {
  final Invoice invoice;
  const InvoiceHistoryDetail({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${invoice.ticket?.screening.movie?.title}'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          children: [
            const SizedBox(
              width: double.infinity,
              child: Text(
                "Chi tiết vé",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.red[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                        "Bạn ơi, vé đã mua sẽ không thể hoàn trả hoặc đổi lịch đâu nha!",
                        style: TextStyle(fontSize: 16, height: 1.2)),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 150,
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            invoice.ticket?.screening.movie?.imageUrl ?? '',
                            width: 100,
                            height: 150,
                          ),
                        ),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Image.network(
                                    invoice.ticket?.screening.auditorium?.cinema
                                            ?.logoUrl ??
                                        '',
                                    width: 24,
                                    height: 24,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                      invoice.ticket?.screening.auditorium
                                              ?.cinema?.name ??
                                          '',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      )),
                                ],
                              ),
                              Text(
                                invoice.ticket?.screening.movie?.title ?? '',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ))
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  AspectRatio(
                    aspectRatio: 2.5,
                    child: SizedBox(
                      width: double.infinity,
                      child: GridView(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2.5,
                          ),
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Thời gian:",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${invoice.ticket?.screening.startTime.hour.toString().padLeft(2, '0')}:${invoice.ticket?.screening.startTime.minute.toString().padLeft(2, '0')}',
                                      style: const TextStyle(
                                        color: colorPrimary,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      ' ~ ${invoice.ticket?.screening.startTime.hour.toString().padLeft(2, '0')}:${invoice.ticket?.screening.startTime.minute.toString().padLeft(2, '0')}',
                                      style: const TextStyle(
                                        color: colorPrimary,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                    '${DatetimeHelper.getFormattedWeekDay(invoice.ticket!.screening.startDate.weekday)}  ${invoice.ticket!.screening.startDate.day}/${invoice.ticket!.screening.startDate.month}/${invoice.ticket!.screening.startDate.year}',
                                    style: const TextStyle(
                                      color: colorPrimary,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Ngôn ngữ:",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  invoice.ticket!.screening.movie!.language,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: colorPrimary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Phòng chiếu:",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  invoice.ticket!.screening.auditorium!.name,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: colorPrimary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Số ghế:",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  invoice.ticket!.seats
                                      .map((seat) => seat.seatName)
                                      .join(", "),
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: colorPrimary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

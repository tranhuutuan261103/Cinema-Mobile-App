import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/providers/invoice_provider.dart';

import '../../common/constants/colors.dart';
import '../../common/utils/datetime_helper.dart';

class PaymentInfo extends StatefulWidget {
  const PaymentInfo({super.key});

  @override
  State<PaymentInfo> createState() => _PaymentInfoState();
}

class _PaymentInfoState extends State<PaymentInfo> {
  @override
  Widget build(BuildContext context) {
    final invoiceProvider = Provider.of<InvoiceProvider>(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: colorPrimary,
          title: const Text("Thông tin thanh toán"),
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Thông tin đặt vé",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                      const SizedBox(height: 8),
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
                                      invoiceProvider
                                          .getScreening!.movie!.imageUrl,
                                      width: 100,
                                      height: 150,
                                    ),
                                  ),
                                  Expanded(
                                      child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Image.network(
                                              invoiceProvider.getScreening!
                                                  .auditorium!.cinema!.logoUrl,
                                              width: 24,
                                              height: 24,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                                invoiceProvider.getScreening!
                                                    .auditorium!.cinema!.name,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey,
                                                )),
                                          ],
                                        ),
                                        Text(
                                          invoiceProvider
                                              .getScreening!.movie!.title,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                '${invoiceProvider.getScreening!.startTime.hour.toString().padLeft(2, '0')}:${invoiceProvider.getScreening!.startTime.minute.toString().padLeft(2, '0')}',
                                                style: const TextStyle(
                                                  color: colorPrimary,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                ' ~ ${invoiceProvider.getScreening!.endTime.hour.toString().padLeft(2, '0')}:${invoiceProvider.getScreening!.endTime.minute.toString().padLeft(2, '0')}',
                                                style: const TextStyle(
                                                  color: colorPrimary,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                              '${DatetimeHelper.getFormattedWeekDay(invoiceProvider.getScreening!.startDate.weekday)}  ${invoiceProvider.getScreening!.startDate.day}/${invoiceProvider.getScreening!.startDate.month}/${invoiceProvider.getScreening!.startDate.year}',
                                              style: const TextStyle(
                                                color: colorPrimary,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Ngôn ngữ:",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Text(
                                            invoiceProvider
                                                .getScreening!.movie!.language,
                                            style: const TextStyle(
                                              fontSize: 13,
                                              color: colorPrimary,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Phòng chiếu:",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Text(
                                            invoiceProvider
                                                .getScreening!.auditorium!.name,
                                            style: const TextStyle(
                                              fontSize: 13,
                                              color: colorPrimary,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Số ghế:",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Text(
                                            invoiceProvider.getSeats
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
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        'Tạm tính',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${invoiceProvider.getTotalPrice} đ',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(
                      'Tiếp tục',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

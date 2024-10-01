import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/providers/invoice_provider.dart';

import '../../common/constants/colors.dart';
import '../../common/widgets/buttons/custom_elevated_button.dart';

class Payment extends StatelessWidget {
  const Payment({super.key});

  @override
  Widget build(BuildContext context) {
    final invoiceProvider = Provider.of<InvoiceProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        title: const Text("Thanh toán"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Chi tiết giao dịch",
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
                          _buildItem(
                              "Phim",
                              invoiceProvider.getScreening?.movie?.title ??
                                  "N/A"),
                          _buildItem(
                              "Suất chiếu",
                              invoiceProvider.getScreening?.startDate.day
                                      .toString() ??
                                  "N/A"),
                          _buildItem(
                              "Rạp",
                              invoiceProvider
                                      .getScreening?.auditorium?.cinema?.name ??
                                  "N/A"),
                          _buildItem(
                              "Phòng chiếu",
                              invoiceProvider.getScreening?.auditorium?.name ??
                                  "N/A"),
                          _buildItem(
                              "Ghế",
                              invoiceProvider.getSeats
                                  .map((e) => e.seatName)
                                  .join(", ")),
                          _buildItem("Giá vé",
                              "${invoiceProvider.getTotalSeattPrice} đ"),
                          _buildItem(
                              "Combo",
                              invoiceProvider.getProductCombos
                                  .map((e) =>
                                      "${e.keys.first.name} x ${e.values.first}")
                                  .join(", ")),
                          _buildItem("Giá combo",
                              "${invoiceProvider.getTotalProductPrice} đ"),
                          _buildItem(
                              "Tổng tiền", "${invoiceProvider.getTotalPrice} đ",
                              isLast: true),
                        ],
                      ),
                    ),
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
                      'Tổng cộng',
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
                CustomElevatedButton(
                    text: "Thanh toán",
                    onPressed: () {
                    })
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildItem(String title, String value, {bool isLast = false}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  height: 1.2,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ),
        if (!isLast) const Divider(),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/providers/auth_provider.dart';
import '../../common/providers/invoice_provider.dart';

import '../../common/constants/colors.dart';
import '../../common/services/invoice_service.dart';
import '../../common/routes/routes.dart';
import '../../common/widgets/buttons/custom_elevated_button.dart';

class Payment extends StatelessWidget {
  const Payment({super.key});

  Future<void> _pay(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (!authProvider.isAuthenticated) {
      Navigator.of(context).pushNamed(Routes.login);
      return;
    }

    final invoiceProvider =
        Provider.of<InvoiceProvider>(context, listen: false);

    if (invoiceProvider.getScreening == null ||
        invoiceProvider.getSeats.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Vui lòng chọn ghế trước khi thanh toán"),
        ),
      );
      return;
    }

    final invoiceService = InvoiceService();

    try {
      final invoice = await invoiceService.createInvoice(authProvider.token,
          invoiceProvider.getScreening!, invoiceProvider.getSeats);
      Navigator.of(context).pushNamed(Routes.invoiceHistoryDetail, arguments: invoice);
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Thanh toán thất bại"),
        ),
      );
    }
  }

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
                  onPressed: () => _pay(context),
                ),
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

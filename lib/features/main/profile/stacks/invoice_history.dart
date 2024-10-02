import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../common/providers/auth_provider.dart';

import '../../../../common/constants/colors.dart';
import '../../../../common/models/invoice.dart';
import '../../../../common/services/invoice_service.dart';

class InvoiceHistory extends StatefulWidget {
  const InvoiceHistory({super.key});

  @override
  State<InvoiceHistory> createState() => _InvoiceHistoryState();
}

class _InvoiceHistoryState extends State<InvoiceHistory> {
  late Future<List<Invoice>> futureInvoices;

  @override
  void initState() {
    super.initState();
    String token = Provider.of<AuthProvider>(context, listen: false).getToken;
    setState(() {
      futureInvoices = InvoiceService().getInvoices(token);
    });
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vé đã mua'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 8.0,
        ),
        color: Colors.white,
        child: FutureBuilder<List<Invoice>>(
          future: futureInvoices,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('Bạn chưa mua vé nào'),
                );
              }

              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return _buildInvoiceCard(snapshot.data![index]);
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget _buildInvoiceCard(Invoice invoice) {
    return Card(
      child: SizedBox(
        width: double.infinity,
        height: 100,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                invoice.ticket!.screening.movie?.imageUrl ?? '',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${invoice.ticket!.screening.movie?.title}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Ngày mua: '),
                        Text(invoice.dateOfPurchaseFormatted,
                            style: const TextStyle(color: colorPrimary)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Tổng tiền: '),
                        Text(
                          '${invoice.sumPrice} đ',
                          style: const TextStyle(
                            color: colorPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

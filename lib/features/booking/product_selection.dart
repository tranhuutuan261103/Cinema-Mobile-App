import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/providers/invoice_provider.dart';

import '../../common/constants/colors.dart';
import '../../common/models/product_combo.dart';
import '../../common/services/product_combo_service.dart';
import '../../common/routes/routes.dart';

class ProductSelection extends StatefulWidget {
  const ProductSelection({super.key});

  @override
  State<ProductSelection> createState() => _ProductSelectionState();
}

class _ProductSelectionState extends State<ProductSelection> {
  late Future<List<ProductCombo>> _productCombosFuture;

  @override
  void initState() {
    super.initState();
    _productCombosFuture = ProductComboService().getProductCombos();
  }

  @override
  Widget build(BuildContext context) {
    final invoiceProvider = Provider.of<InvoiceProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        title: const Text("Combo - Bắp nước"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Danh sách bắp nước',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Bắp thơm nước ngọt mời bạn xơi nha!",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: FutureBuilder<List<ProductCombo>>(
                      future: _productCombosFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        }

                        return SingleChildScrollView(
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: snapshot.data!
                                  .map((productCombo) => Column(
                                        children: [
                                          _buildProductCombo(productCombo),
                                          if (productCombo !=
                                              snapshot.data!.last)
                                            const Divider(),
                                        ],
                                      ))
                                  .toList(),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
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
                      '${invoiceProvider.getTotalProductPrice} đ',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.paymentInfo);
                  },
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
      ),
    );
  }

  Widget _buildProductCombo(ProductCombo productCombo) {
    final invoiceProvider = Provider.of<InvoiceProvider>(context);

    // find quantity of product combo by id
    final quantity = invoiceProvider.getProductCombos
        .firstWhere((element) => element.keys.first.id == productCombo.id,
            orElse: () => {productCombo: 0})
        .values
        .first;

    return SizedBox(
      height: 100,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(productCombo.imageUrl,
                width: 100, height: 100, fit: BoxFit.cover),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productCombo.name,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    '${productCombo.price}đ',
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold, height: 1.2),
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () =>
                              invoiceProvider.removeProductCombo(productCombo),
                          icon: const Icon(Icons.remove)),
                      Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            quantity.toString(),
                            style: const TextStyle(fontSize: 16),
                          )),
                      IconButton(
                          onPressed: () =>
                              invoiceProvider.addProductCombo(productCombo),
                          icon: const Icon(Icons.add)),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

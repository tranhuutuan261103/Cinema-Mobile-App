import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/providers/auth_provider.dart';
import '../../common/providers/invoice_provider.dart';

import '../../common/constants/colors.dart';
import '../../common/utils/datetime_helper.dart';
import '../../common/models/product_combo.dart';
import '../../common/services/product_combo_service.dart';
import '../../common/routes/routes.dart';
import '../../common/widgets/buttons/custom_elevated_button.dart';
import '../../common/widgets/buttons/trailer_button.dart';
import '../stacks/movie_trailer.dart';

class PaymentInfo extends StatefulWidget {
  const PaymentInfo({super.key});

  @override
  State<PaymentInfo> createState() => _PaymentInfoState();
}

class _PaymentInfoState extends State<PaymentInfo> {
  late Future<List<ProductCombo>> futureProductCombos;

  @override
  void initState() {
    super.initState();
    futureProductCombos = ProductComboService().getProductCombos();
  }

  @override
  Widget build(BuildContext context) {
    final invoiceProvider = Provider.of<InvoiceProvider>(context);
    final userProvider = Provider.of<AuthProvider>(context);

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
                                        Text(
                                          invoiceProvider
                                              .getScreening!.movie!.categories
                                              .map((e) => e.name)
                                              .join(", "),
                                          style: const TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        const Spacer(),
                                        TrailerButton(
                                          onPressed: () => {
                                            showMovieTrailer(
                                                context,
                                                invoiceProvider.getScreening!
                                                    .movie!.trailerUrl)
                                          },
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
                      ),
                      const SizedBox(height: 16),
                      const Text("Combo bắp nước",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                      const SizedBox(height: 8),
                      FutureBuilder<List<ProductCombo>>(
                          future: futureProductCombos,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: snapshot.data!
                                      .map(
                                        (productCombo) => Row(children: [
                                          _buildProductCombo(productCombo),
                                          if (productCombo !=
                                              snapshot.data!.last)
                                            const SizedBox(width: 16),
                                        ]),
                                      )
                                      .toList(),
                                ),
                              );
                            } else {
                              return const SizedBox(
                                width: double.infinity,
                                height: 100,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                          }),
                      const SizedBox(height: 16),
                      const Text("Thông tin khách hàng",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                      const SizedBox(height: 8),
                      userProvider.user != null
                          ? Container(
                              width: double.infinity,
                              height: 60,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          '${Provider.of<AuthProvider>(context).user!.firstName} ${Provider.of<AuthProvider>(context).user!.lastName}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          )),
                                      Text(Provider.of<AuthProvider>(context)
                                          .user!
                                          .email),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () => {
                                      Navigator.pushNamed(
                                          context, Routes.editProfile)
                                    },
                                    icon: const Icon(Icons.edit,
                                        color: colorPrimary),
                                  ),
                                ],
                              ))
                          : MaterialButton(
                              onPressed: () {
                                Navigator.pushNamed(context, Routes.login);
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.all(0),
                              elevation: 0,
                              height: 60,
                              color: Colors.white,
                              child: const Center(
                                child: Text(
                                    "Vui lòng đăng nhập để tiếp tục mua vé"),
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
                  CustomElevatedButton(
                    text: "Tiếp tục",
                    onPressed: () => {
                      if (userProvider.user != null)
                        {Navigator.pushNamed(context, Routes.payment)}
                      else
                        {Navigator.pushNamed(context, Routes.login)}
                    },
                  )
                ],
              ),
            )
          ],
        ));
  }

  Widget _buildProductCombo(ProductCombo productCombo) {
    final invoiceProvider = Provider.of<InvoiceProvider>(context);

    final quantity = invoiceProvider.getProductCombos
        .firstWhere((element) => element.keys.first.id == productCombo.id,
            orElse: () => {productCombo: 0})
        .values
        .first;

    return Container(
      width: 300,
      height: 100,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              productCombo.imageUrl,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                productCombo.name,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${productCombo.price} đ',
                    style: const TextStyle(
                      fontSize: 12,
                      color: colorPrimary,
                      fontWeight: FontWeight.bold,
                    ),
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
              )
            ],
          )
        ],
      ),
    );
  }
}

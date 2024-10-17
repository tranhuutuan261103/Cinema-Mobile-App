import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import './features/main/main_page.dart';

import '../common/routes/routes.dart';

import '../common/providers/invoice_provider.dart';
import '../common/providers/province_provider.dart';
import '../common/providers/auth_provider.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => InvoiceProvider()),
        ChangeNotifierProvider(create: (context) => ProvinceProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Provider.of<AuthProvider>(context, listen: false);
    Provider.of<ProvinceProvider>(context, listen: false);

    return MaterialApp(
      title: 'Tune Cinema',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 255, 255, 255)),
        useMaterial3: true,
      ),
      onGenerateRoute: Routes.onGenerateRoute,
      home: const MainPage(),
    );
  }
}

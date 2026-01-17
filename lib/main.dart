import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/di/di.dart';
import 'screens/home_screen.dart';
import 'providers/market_data_provider.dart';

void main() {
  runApp(const PulseNowApp());
}

class PulseNowApp extends StatelessWidget {
  const PulseNowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: DI.getProviders(),
        child: MaterialApp(
          title: 'PulseNow',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            useMaterial3: true,
          ),
          home: const HomeScreen(),
          debugShowCheckedModeBanner: false,
        ));
  }
}

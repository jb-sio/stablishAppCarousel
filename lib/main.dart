import 'package:flutter/material.dart';
import 'giving_power_page.dart';

void main() {
  runApp(const StablishCarouselApp());
}

class StablishCarouselApp extends StatelessWidget {
  const StablishCarouselApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GivingPowerPage(),
    );
  }
}

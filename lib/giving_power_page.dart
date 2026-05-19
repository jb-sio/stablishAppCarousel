import 'package:flutter/material.dart';
import 'widgets/amount_carousel.dart';
import 'widgets/page_indicator.dart';

class GivingPowerPage extends StatefulWidget {
  const GivingPowerPage({super.key});

  @override
  State<GivingPowerPage> createState() => _GivingPowerPageState();
}

class _GivingPowerPageState extends State<GivingPowerPage> {
  final PageController _controller = PageController(
    viewportFraction: 0.38,
    initialPage: 1,
  );

  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  void _onScroll() {
    final int next = _controller.page?.round() ?? _selectedIndex;
    if (next != _selectedIndex) {
      setState(() => _selectedIndex = next);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onScroll);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final item = carouselItems[_selectedIndex];

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(0, 36, 0, 32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 8),
                      // Title
                      const Text(
                        'Your GivingPower',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 6),
                      // Subtitle
                      const Text(
                        'Personalized to your budget level',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF888888),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Carousel
                      AmountCarousel(controller: _controller),
                      const SizedBox(height: 20),
                      // Label chip
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: Container(
                          key: ValueKey(item.label),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8E4F5),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Text(
                            item.label,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Dot indicator
                      PageIndicator(
                        count: carouselItems.length,
                        currentIndex: _selectedIndex,
                      ),
                      const SizedBox(height: 32),
                      // Select button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: double.infinity,
                            height: 60,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF4DD9F0),
                                  Color(0xFF29C5E6),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(32),
                              border: Border.all(
                                color: Colors.black,
                                width: 2,
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'Select',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // X close button
                Positioned(
                  top: 12,
                  left: 12,
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFFDDDDDD)),
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

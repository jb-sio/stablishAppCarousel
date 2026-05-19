import 'dart:ui';
import 'package:flutter/material.dart';

typedef CarouselItem = ({int amount, String label});

const List<CarouselItem> carouselItems = [
  (amount: 25, label: 'Best for a weekly gift'),
  (amount: 50, label: 'Best for a bi-weekly gift'),
  (amount: 100, label: 'Best for a monthly gift'),
];

class AmountCarousel extends StatelessWidget {
  const AmountCarousel({
    super.key,
    required this.controller,
  });

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: PageView.builder(
        controller: controller,
        clipBehavior: Clip.none,
        itemCount: carouselItems.length,
        itemBuilder: (context, index) {
          return AnimatedBuilder(
            animation: controller,
            builder: (context, _) {
              final double page =
                  controller.hasClients ? (controller.page ?? 1.0) : 1.0;
              final double t = (page - index).abs().clamp(0.0, 1.0);
              final double scale = lerpDouble(1.0, 0.52, t)!;
              final Color color = Color.lerp(
                Colors.black,
                const Color(0xFFCCCCCC),
                t,
              )!;
              final bool isActive = t < 0.5;

              return OverflowBox(
                maxWidth: double.infinity,
                child: Center(
                  child: Transform.scale(
                    scale: scale,
                    child: _AmountItem(
                      amount: carouselItems[index].amount,
                      color: color,
                      showPrefix: isActive,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _AmountItem extends StatelessWidget {
  const _AmountItem({
    required this.amount,
    required this.color,
    required this.showPrefix,
  });

  final int amount;
  final Color color;
  final bool showPrefix;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (showPrefix)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              '\$',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: color,
                height: 1,
              ),
            ),
          ),
        Text(
          '$amount',
          style: TextStyle(
            fontSize: 96,
            fontWeight: FontWeight.w800,
            color: color,
            height: 1,
          ),
        ),
      ],
    );
  }
}

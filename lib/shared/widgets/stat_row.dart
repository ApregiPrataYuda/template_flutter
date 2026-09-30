import 'package:flutter/material.dart';
import '../../core/constants/app_sizes.dart';
import 'stat_card.dart';

/// Menyejajarkan beberapa StatCard dengan lebar sama.
class StatRow extends StatelessWidget {
  final List<StatCard> cards;

  const StatRow({super.key, required this.cards});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < cards.length; i++) ...[
          if (i > 0) const SizedBox(width: AppSizes.sm),
          Expanded(child: cards[i]),
        ],
      ],
    );
  }
}
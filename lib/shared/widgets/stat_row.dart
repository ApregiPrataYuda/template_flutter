import 'package:flutter/material.dart';
import '../../core/constants/app_sizes.dart';

class StatRow extends StatelessWidget {
  const StatRow({
    super.key,
    required this.cards,
    this.spacing = AppSizes.sm,
  });

  final List<Widget> cards;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    // IntrinsicHeight + stretch = semua kartu ikut tinggi kartu tertinggi
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < cards.length; i++) ...[
            Expanded(child: cards[i]),
            if (i < cards.length - 1) SizedBox(width: spacing),
          ],
        ],
      ),
    );
  }
}
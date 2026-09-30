import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';

class AppToast {
  static OverlayEntry? _current;

  static void show(
    BuildContext context,
    String message, {
    Color backgroundColor = AppColors.primary,
    Color foregroundColor = Colors.white,
    IconData icon = Icons.info_outline,
    Duration duration = const Duration(seconds: 3),
  }) {
    // Tutup toast sebelumnya kalau masih tampil
    _current?.remove();
    _current = null;

    late final OverlayEntry entry;
    entry = OverlayEntry(
      builder: (_) => _TopToast(
        message: message,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        icon: icon,
        duration: duration,
        onDismissed: () {
          if (entry.mounted) entry.remove();
          if (_current == entry) _current = null;
        },
      ),
    );
    _current = entry;
    Overlay.of(context).insert(entry);
  }

  static void error(BuildContext context, String message) => show(
        context,
        message,
        backgroundColor: AppColors.errorDark,
        icon: Icons.error_outline,
      );

  static void warning(BuildContext context, String message) => show(
        context,
        message,
        backgroundColor: AppColors.warning,
        foregroundColor: AppColors.textPrimary,
        icon: Icons.warning_amber_rounded,
      );

  static void success(BuildContext context, String message) => show(
        context,
        message,
        backgroundColor: AppColors.successDark,
        icon: Icons.check_circle_outline,
      );

  static void info(BuildContext context, String message) => show(
        context,
        message,
        backgroundColor: AppColors.textPrimary,
        icon: Icons.info_outline,
      );

  /// Tutup toast yang sedang tampil secara manual
  static void dismiss() {
    _current?.remove();
    _current = null;
  }
}

class _TopToast extends StatefulWidget {
  const _TopToast({
    required this.message,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.icon,
    required this.duration,
    required this.onDismissed,
  });

  final String message;
  final Color backgroundColor;
  final Color foregroundColor;
  final IconData icon;
  final Duration duration;
  final VoidCallback onDismissed;

  @override
  State<_TopToast> createState() => _TopToastState();
}

class _TopToastState extends State<_TopToast>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 250),
  );
  late final Animation<Offset> _slide = Tween(
    begin: const Offset(0, -1.5),
    end: Offset.zero,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

  final _dismissKey = UniqueKey();
  Timer? _timer;
  bool _closed = false;

  @override
  void initState() {
    super.initState();
    _controller.forward();
    _timer = Timer(widget.duration, _dismiss);
  }

  /// Tutup dengan animasi (dipanggil timer atau tap)
  Future<void> _dismiss() async {
    if (_closed) return;
    _closed = true;
    _timer?.cancel();
    if (!mounted) return;
    await _controller.reverse();
    widget.onDismissed();
  }

  /// Tutup tanpa animasi (sudah di-swipe keluar)
  void _onSwiped() {
    if (_closed) return;
    _closed = true;
    _timer?.cancel();
    widget.onDismissed();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Positioned(
      top: topPadding + AppSizes.md,
      left: AppSizes.md,
      right: AppSizes.md,
      child: SlideTransition(
        position: _slide,
        child: Dismissible(
          key: _dismissKey,
          direction: DismissDirection.up,
          onDismissed: (_) => _onSwiped(),
          child: Material(
            elevation: 6,
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(AppSizes.radiusLg),
            child: InkWell(
              borderRadius: BorderRadius.circular(AppSizes.radiusLg),
              onTap: _dismiss,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.md,
                  vertical: AppSizes.sm + 4,
                ),
                child: Row(
                  children: [
                    Icon(widget.icon, color: widget.foregroundColor),
                    const SizedBox(width: AppSizes.sm),
                    Expanded(
                      child: Text(
                        widget.message,
                        style: TextStyle(
                          color: widget.foregroundColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
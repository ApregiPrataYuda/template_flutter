import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../shared/widgets/page_header.dart';
import '../../../shared/widgets/state_views.dart';
import '../providers/notification_provider.dart';
import '../widgets/notification_tile.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  Widget _buildBody(BuildContext context, NotificationProvider provider) {
    if (provider.isLoading && provider.items.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if (provider.error != null && provider.items.isEmpty) {
      return ErrorState(
        message: provider.error!,
        onRetry: () => provider.load(),
      );
    }
    if (provider.items.isEmpty) {
      return const EmptyState(
        message: 'No notifications yet',
        icon: Icons.notifications_off_outlined,
      );
    }

    return RefreshIndicator(
      onRefresh: () => provider.load(),
      child: ListView.separated(
        padding: const EdgeInsets.all(AppSizes.md),
        itemCount: provider.items.length,
        separatorBuilder: (_, _) => const SizedBox(height: AppSizes.sm),
        itemBuilder: (context, i) {
          final item = provider.items[i];
          return NotificationTile(
            item: item,
            onTap: () {
              provider.markAsRead(item.id);
              if (item.route != null) context.push(item.route!);
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NotificationProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PageHeader(
          title: 'Notification',
          trailing: provider.unreadCount > 0
              ? TextButton(
                  onPressed: provider.markAllAsRead,
                  child: const Text('Mark all read'),
                )
              : null,
        ),
        // Garis loading tipis saat refresh di atas data yang sudah ada
        SizedBox(
          height: 3,
          child: provider.isLoading && provider.items.isNotEmpty
              ? const LinearProgressIndicator()
              : null,
        ),
        Expanded(child: _buildBody(context, provider)),
      ],
    );
  }
}
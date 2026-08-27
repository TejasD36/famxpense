import '../../xcore.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationBloc>().add(
      const NotificationEvent.loadNotifications(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox(),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (m) => Center(child: Text(m)),
            loaded: (notifications) {
              if (notifications.isEmpty) {
                return const FinanceEmptyState(
                  icon: Icons.notifications_off_rounded,
                  title: 'No notifications yet',
                  subtitle:
                      'Partner requests, settlements, and shared expense updates will appear here.',
                );
              }
              return ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                itemCount: notifications.length,
                separatorBuilder: (_, _) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final n = notifications[index];
                  final accent = n.isRead
                      ? Theme.of(context).colorScheme.onSurfaceVariant
                      : Theme.of(context).colorScheme.primary;
                  return CompactInfoTile(
                    icon: _iconForType(n.type),
                    color: accent,
                    title: n.title,
                    subtitle:
                        '${n.message} · ${formatRelativeCalendarDate(n.createdAt)}',
                    trailing: n.isRead
                        ? null
                        : Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                    onTap: () {
                      if (!n.isRead) {
                        context.read<NotificationBloc>().add(
                          NotificationEvent.markAsRead(notificationId: n.id),
                        );
                      }
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  IconData _iconForType(NotificationType type) {
    return switch (type) {
      NotificationType.expenseAdded => Icons.shopping_bag_rounded,
      NotificationType.partnerRequest => Icons.person_add_rounded,
      NotificationType.settlementRequest => Icons.swap_horiz_rounded,
      NotificationType.settlementConfirmed => Icons.check_circle_rounded,
      NotificationType.settlementRejected => Icons.cancel_rounded,
    };
  }
}

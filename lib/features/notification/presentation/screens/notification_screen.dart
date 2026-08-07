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
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.notifications_off_rounded,
                        size: 64,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurfaceVariant.withValues(alpha: 0.3),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No notifications yet',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                itemCount: notifications.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final n = notifications[index];
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 22,
                      backgroundColor: n.isRead
                          ? Theme.of(
                              context,
                            ).colorScheme.surfaceContainerHighest
                          : Theme.of(context).colorScheme.primaryContainer,
                      child: Icon(
                        _iconForType(n.type),
                        size: 20,
                        color: n.isRead
                            ? Theme.of(context).colorScheme.onSurfaceVariant
                            : Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    title: Text(
                      n.title,
                      style: TextStyle(
                        fontWeight: n.isRead
                            ? FontWeight.normal
                            : FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      n.message,
                      style: const TextStyle(fontSize: 13),
                    ),
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

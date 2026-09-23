import '../../xcore.dart';

class PartnerTile extends StatelessWidget {
  final String nickname;

  final String email;

  final Widget? trailing;

  final VoidCallback? onTap;

  const PartnerTile({
    super.key,
    required this.nickname,
    required this.email,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,

      margin: EdgeInsets.zero,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),

      child: InkWell(
        borderRadius: BorderRadius.circular(6),

        onTap: onTap,

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),

          child: Row(
            children: [
              /// AVATAR
              CircleAvatar(
                radius: 22,

                child: Text(
                  nickname.isNotEmpty ? nickname[0].toUpperCase() : '?',

                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              /// INFO
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      '@$nickname',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 2),

                    Text(
                      email,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),

              /// ACTION
              ?trailing,
            ],
          ),
        ),
      ),
    );
  }
}

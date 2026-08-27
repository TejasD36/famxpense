import '../../../core.dart';

class FamXpenseAssets {
  static const walletLottie = 'assets/lottie/wallet_money_in_out.json';
}

class FinanceLottieAccent extends StatelessWidget {
  final double size;
  final bool repeat;

  const FinanceLottieAccent({super.key, this.size = 96, this.repeat = true});

  @override
  Widget build(BuildContext context) {
    final reduceMotion =
        MediaQuery.maybeDisableAnimationsOf(context) ??
        MediaQuery.disableAnimationsOf(context);
    if (reduceMotion) {
      return Icon(
        Icons.account_balance_wallet_rounded,
        size: size * 0.56,
        color: Theme.of(context).colorScheme.primary,
      );
    }

    return Lottie.asset(
      FamXpenseAssets.walletLottie,
      height: size,
      width: size,
      repeat: repeat,
      fit: BoxFit.contain,
      frameRate: FrameRate.max,
    );
  }
}

class GradientPatternPanel extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final BorderRadiusGeometry borderRadius;

  const GradientPatternPanel({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius = const BorderRadius.all(Radius.circular(6)),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primary = theme.colorScheme.primary;
    final secondary = theme.colorScheme.secondary;
    final surface = theme.colorScheme.surface;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  Color.alphaBlend(primary.withValues(alpha: 0.18), surface),
                  Color.alphaBlend(secondary.withValues(alpha: 0.10), surface),
                ]
              : [
                  Color.alphaBlend(primary.withValues(alpha: 0.10), surface),
                  Color.alphaBlend(secondary.withValues(alpha: 0.08), surface),
                ],
        ),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.45),
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: _SoftPatternPainter(
                color: theme.colorScheme.primary.withValues(
                  alpha: isDark ? 0.08 : 0.06,
                ),
              ),
            ),
          ),
          Padding(padding: padding, child: child),
        ],
      ),
    );
  }
}

class CompactInfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? color;

  const CompactInfoTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = color ?? theme.colorScheme.primary;

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        minVerticalPadding: 10,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
        onTap: onTap,
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: accent.withValues(alpha: 0.12),
          child: Icon(icon, color: accent, size: 21),
        ),
        title: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          subtitle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 12),
        ),
        trailing:
            trailing ??
            (onTap == null ? null : const Icon(Icons.chevron_right_rounded)),
      ),
    );
  }
}

class MoneyMetricStrip extends StatelessWidget {
  final List<MoneyMetric> metrics;

  const MoneyMetricStrip({super.key, required this.metrics});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            for (var i = 0; i < metrics.length; i++) ...[
              Expanded(child: _MoneyMetricView(metric: metrics[i])),
              if (i != metrics.length - 1)
                Container(
                  width: 1,
                  height: 34,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  color: theme.dividerColor,
                ),
            ],
          ],
        ),
      ),
    );
  }
}

class MoneyMetric {
  final String label;
  final String value;
  final Color? color;
  final IconData? icon;

  const MoneyMetric({
    required this.label,
    required this.value,
    this.color,
    this.icon,
  });
}

class _MoneyMetricView extends StatelessWidget {
  final MoneyMetric metric;

  const _MoneyMetricView({required this.metric});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = metric.color ?? theme.colorScheme.onSurface;

    return Row(
      children: [
        if (metric.icon != null) ...[
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.11),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(metric.icon, color: color, size: 17),
          ),
          const SizedBox(width: 8),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                metric.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  metric.value,
                  style: TextStyle(
                    color: color,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class FinanceEmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget? action;
  final bool showLottie;

  const FinanceEmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.action,
    this.showLottie = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showLottie)
              const FinanceLottieAccent(size: 96)
            else
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(icon, color: theme.colorScheme.primary, size: 28),
              ),
            const SizedBox(height: 14),
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            if (action != null) ...[const SizedBox(height: 16), action!],
          ],
        ),
      ),
    );
  }
}

class SheetGrabber extends StatelessWidget {
  const SheetGrabber({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: Theme.of(context).dividerColor,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}

class CompactSectionHeader extends StatelessWidget {
  final String title;
  final Widget? trailing;

  const CompactSectionHeader({super.key, required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(2, 8, 2, 8),
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const Spacer(),
          ?trailing,
        ],
      ),
    );
  }
}

class AuthBrandPanel extends StatelessWidget {
  final String title;
  final String subtitle;

  const AuthBrandPanel({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return GradientPatternPanel(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const FinanceLottieAccent(size: 78),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SoftPatternPainter extends CustomPainter {
  final Color color;

  _SoftPatternPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    const gap = 28.0;
    for (var x = -size.height; x < size.width; x += gap) {
      canvas.drawLine(
        Offset(x, size.height),
        Offset(x + size.height, 0),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _SoftPatternPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';

class WeatherIllustration extends StatelessWidget {
  final int weatherCode;
  final double size;

  const WeatherIllustration({
    super.key,
    required this.weatherCode,
    this.size = 96,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _WeatherIllustrationPainter(weatherCode: weatherCode),
      ),
    );
  }
}

class _WeatherIllustrationPainter extends CustomPainter {
  final int weatherCode;

  _WeatherIllustrationPainter({required this.weatherCode});

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final scale = width / 96.0;

    final sunGlowPaint = Paint()
      ..color = AppColors.warningSun.withValues(alpha: 0.25)
      ..style = PaintingStyle.fill;

    final sunPaint = Paint()
      ..color = AppColors.warningSun
      ..style = PaintingStyle.fill;

    // Draw Sun (offset upper right)
    final sunCenter = Offset(58 * scale, 34 * scale);
    canvas.drawCircle(sunCenter, 22 * scale, sunGlowPaint);
    canvas.drawCircle(sunCenter, 16 * scale, sunPaint);

    // If overcast or rain or cloud, draw clouds
    if (weatherCode > 0) {
      final cloudPaint = Paint()
        ..color = Colors.white.withValues(alpha: 0.95)
        ..style = PaintingStyle.fill;

      final cloudPath = Path();
      // Draw smooth cloud using rounded arcs
      final baseY = 68.0 * scale;
      cloudPath.moveTo(28 * scale, baseY);
      cloudPath.lineTo(66 * scale, baseY);
      cloudPath.arcToPoint(
        Offset(78 * scale, 56 * scale),
        radius: Radius.circular(12 * scale),
        clockwise: false,
      );
      cloudPath.arcToPoint(
        Offset(67 * scale, 44 * scale),
        radius: Radius.circular(12 * scale),
        clockwise: false,
      );
      cloudPath.arcToPoint(
        Offset(48 * scale, 29 * scale),
        radius: Radius.circular(18 * scale),
        clockwise: false,
      );
      cloudPath.arcToPoint(
        Offset(29 * scale, 48 * scale),
        radius: Radius.circular(18 * scale),
        clockwise: false,
      );
      cloudPath.arcToPoint(
        Offset(19 * scale, 61 * scale),
        radius: Radius.circular(10 * scale),
        clockwise: false,
      );
      cloudPath.arcToPoint(
        Offset(28 * scale, baseY),
        radius: Radius.circular(10 * scale),
        clockwise: false,
      );
      cloudPath.close();

      canvas.drawPath(cloudPath, cloudPaint);

      // If rain codes (51-67, 80-82), draw little rain drops
      if ((weatherCode >= 51 && weatherCode <= 67) || (weatherCode >= 80 && weatherCode <= 82)) {
        final rainPaint = Paint()
          ..color = AppColors.skyGlow
          ..strokeWidth = 2.5 * scale
          ..strokeCap = StrokeCap.round;

        canvas.drawLine(
          Offset(32 * scale, 74 * scale),
          Offset(28 * scale, 82 * scale),
          rainPaint,
        );
        canvas.drawLine(
          Offset(48 * scale, 74 * scale),
          Offset(44 * scale, 82 * scale),
          rainPaint,
        );
        canvas.drawLine(
          Offset(64 * scale, 74 * scale),
          Offset(60 * scale, 82 * scale),
          rainPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _WeatherIllustrationPainter oldDelegate) {
    return oldDelegate.weatherCode != weatherCode;
  }
}

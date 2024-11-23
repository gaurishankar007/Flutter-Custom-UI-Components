import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../base/button/text_button_widget.dart';
import '../../base/text/text_widget.dart';
import '../explicit/loading_circle_widget.dart';

class ResendOTPButtonWidget extends HookWidget {
  final Function() onOTPSend;
  const ResendOTPButtonWidget({super.key, required this.onOTPSend});

  @override
  Widget build(BuildContext context) {
    final showTimer = useState(true);
    final loading = useState(false);

    if (loading.value) {
      return SizedBox(
        height: 30,
        child: LoadingCircleWidget.small(color: Colors.white),
      );
    }

    return TweenAnimationBuilder(
      tween: Tween<Duration>(
        begin: const Duration(seconds: 60),
        end: Duration.zero,
      ),
      duration: const Duration(seconds: 60),
      onEnd: () => showTimer.value = false,
      builder: (context, duration, child) {
        return TextButtonWidget(
          onPressed: () async {
            loading.value = true;
            await onOTPSend();
            loading.value = false;
            showTimer.value = true;
          },
          text: showTimer.value
              ? "Resend OTP (${duration.inSeconds})"
              : "Resend OTP",
          foregroundColor: Colors.white,
          textType: TextType.bodyMedium,
          shape: const StadiumBorder(),
          expanded: true,
          disabled: showTimer.value,
        );
      },
    );
  }
}

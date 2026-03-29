import 'package:flutter/material.dart';
import '../models/ai_companion.dart';

class AiAvatar extends StatefulWidget {
  final GrowthStage stage;
  final bool animate;

  const AiAvatar({
    super.key,
    required this.stage,
    this.animate = false,
  });

  @override
  State<AiAvatar> createState() => _AiAvatarState();
}

class _AiAvatarState extends State<AiAvatar> {
  double _scale = 1.0;

  @override
  void didUpdateWidget(covariant AiAvatar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animate && !oldWidget.animate) {
      _triggerAnimation();
    }
  }

  void _triggerAnimation() {
    setState(() => _scale = 1.2);
    Future.delayed(const Duration(milliseconds: 150), () {
      if (mounted) {
        setState(() => _scale = 1.0);
      }
    });
  }

  String _emoji() {
    switch (widget.stage) {
      case GrowthStage.initialization:
        return '>_';
      case GrowthStage.learning:
        return '\u{1F916}';
      case GrowthStage.awakening:
        return '\u{1F914}';
      case GrowthStage.selfForming:
        return '\u{1F31F}';
      case GrowthStage.independent:
        return '\u{1F30C}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _scale,
      duration: const Duration(milliseconds: 150),
      child: Text(
        _emoji(),
        style: const TextStyle(fontSize: 80),
      ),
    );
  }
}

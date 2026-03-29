import 'package:flutter/material.dart';
import '../models/ai_companion.dart';

class GrowthProgress extends StatelessWidget {
  final AiCompanion ai;

  const GrowthProgress({super.key, required this.ai});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          Text(
            '${ai.stageName} (${(ai.stageProgress * 100).toStringAsFixed(0)}%)',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: ai.stageProgress,
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
            color: Theme.of(context).colorScheme.primary,
            backgroundColor:
                Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
          ),
          if (ai.personality.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              ai.personality.join(', '),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
          ],
        ],
      ),
    );
  }
}

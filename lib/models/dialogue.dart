import 'ai_companion.dart';

enum DialogueType {
  idle,
  tapResponse,
  stageUp,
  milestone,
}

class Dialogue {
  final String text;
  final GrowthStage stage;
  final DialogueType type;

  const Dialogue({
    required this.text,
    required this.stage,
    required this.type,
  });
}

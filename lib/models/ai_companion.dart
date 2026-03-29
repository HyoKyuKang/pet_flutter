import '../utils/constants.dart';

enum GrowthStage {
  initialization,
  learning,
  awakening,
  selfForming,
  independent,
}

class AiCompanion {
  final String name;
  final GrowthStage stage;
  final double growthPoints;
  final int totalInteractions;
  final List<String> personality;

  const AiCompanion({
    required this.name,
    required this.stage,
    required this.growthPoints,
    required this.totalInteractions,
    required this.personality,
  });

  factory AiCompanion.initial() {
    return const AiCompanion(
      name: 'AI-001',
      stage: GrowthStage.initialization,
      growthPoints: 0.0,
      totalInteractions: 0,
      personality: [],
    );
  }

  AiCompanion copyWith({
    String? name,
    GrowthStage? stage,
    double? growthPoints,
    int? totalInteractions,
    List<String>? personality,
  }) {
    return AiCompanion(
      name: name ?? this.name,
      stage: stage ?? this.stage,
      growthPoints: growthPoints ?? this.growthPoints,
      totalInteractions: totalInteractions ?? this.totalInteractions,
      personality: personality ?? this.personality,
    );
  }

  GrowthStage? get nextStage {
    final index = GrowthStage.values.indexOf(stage);
    if (index >= GrowthStage.values.length - 1) return null;
    return GrowthStage.values[index + 1];
  }

  double get _currentThreshold {
    switch (stage) {
      case GrowthStage.initialization:
        return kStageThreshold0to1;
      case GrowthStage.learning:
        return kStageThreshold1to2;
      case GrowthStage.awakening:
        return kStageThreshold2to3;
      case GrowthStage.selfForming:
        return kStageThreshold3to4;
      case GrowthStage.independent:
        return double.infinity;
    }
  }

  double get _previousThreshold {
    switch (stage) {
      case GrowthStage.initialization:
        return 0.0;
      case GrowthStage.learning:
        return kStageThreshold0to1;
      case GrowthStage.awakening:
        return kStageThreshold1to2;
      case GrowthStage.selfForming:
        return kStageThreshold2to3;
      case GrowthStage.independent:
        return kStageThreshold3to4;
    }
  }

  /// 현재 단계 내 진행률 (0.0 ~ 1.0)
  double get stageProgress {
    if (stage == GrowthStage.independent) return 1.0;
    final rangeStart = _previousThreshold;
    final rangeEnd = _currentThreshold;
    final progress = (growthPoints - rangeStart) / (rangeEnd - rangeStart);
    return progress.clamp(0.0, 1.0);
  }

  /// 다음 단계로 전환 가능한지 확인
  bool get canStageUp {
    if (stage == GrowthStage.independent) return false;
    return growthPoints >= _currentThreshold;
  }

  String get stageName {
    switch (stage) {
      case GrowthStage.initialization:
        return '초기화';
      case GrowthStage.learning:
        return '학습 중';
      case GrowthStage.awakening:
        return '각성';
      case GrowthStage.selfForming:
        return '자아 형성';
      case GrowthStage.independent:
        return '독립';
    }
  }
}

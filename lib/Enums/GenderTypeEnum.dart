enum GenderEnum {
  Man,
  Woman,
  DontWantToMention,
}

extension GenderEnumExtension on GenderEnum {
  String get value {
    switch (this) {
      case GenderEnum.Man:
        return 'Man';
      case GenderEnum.Woman:
        return 'Woman';
      case GenderEnum.DontWantToMention:
        return 'I do not want to mention';
      default:
        return '';
    }
  }
}
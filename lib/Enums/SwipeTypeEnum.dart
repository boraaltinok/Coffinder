enum SwipeTypeEnum {
  left,
  right,
  none
}

extension SwipeEnumExtension on SwipeTypeEnum {
  String get value {
    switch (this) {
      case SwipeTypeEnum.left:
        return 'left';
      case SwipeTypeEnum.right:
        return 'right';
      case SwipeTypeEnum.none:
        return 'none';
      default:
        return '';
    }
  }
}

SwipeTypeEnum getSwipeTypeEnumFromString(String value) {
  if (value == SwipeTypeEnum.left.value) {
    return SwipeTypeEnum.left;
  } else if (value == SwipeTypeEnum.right.value) {
    return SwipeTypeEnum.right;
  } else {
    // Default value or error handling
    return SwipeTypeEnum.none;

  }
}
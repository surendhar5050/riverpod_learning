extension OptionalInfixAddition<T extends num> on T? {
  T? operator +(T? other) {
    final shadow = this;

    if (shadow != null) {
      if (other != null) {
        return (shadow + other) as T; // Ensuring type safety
      }
      return shadow; // If other is null, return this value
    }
    return other; // If this is null, return other
  }
}

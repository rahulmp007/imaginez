Future<F?> retry<F>(
  Future<F> Function() future, {
  int maxCount = 5,
  Duration delay = Duration.zero,
}) async {
  try {
    return await future();
  } catch (e) {
    if (maxCount > 1) {
      return await Future.delayed(delay).then((_) => retry(
          () => future(),
          maxCount: maxCount - 1,
          delay: delay,
        ));
    } else {
      return null;
    }
  }
}

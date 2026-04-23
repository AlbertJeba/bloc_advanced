/// This is a functional programming concept. "Either" means the result will be
/// ONE of two things, never both.
///
/// - Left (L): Usually represents Failure / Error.
/// - Right (R): Usually represents Success / Data.
///
/// We use this for API calls so we are forced to handle both cases.
sealed class Either<L, R> {
  const Either();
  factory Either.left(L l) => Left(l);
  factory Either.right(R r) => Right(r);

  // "folds" the result: execute 'left' func if Left, 'right' func if Right
  T fold<T>(T Function(L) left, T Function(R) right) => switch (this) {
        Left(:final value) => left(value),
        Right(:final value) => right(value),
      };

  bool isLeft() => switch (this) {
        Left() => true,
        Right() => false,
      };
  bool isRight() => !isLeft();
}

/// Represents the Left side (Error)
class Left<L, R> extends Either<L, R> {
  final L _l;
  const Left(this._l);
  L get value => _l;
}

/// Represents the Right side (Success)
class Right<L, R> extends Either<L, R> {
  final R _r;
  const Right(this._r);
  R get value => _r;
}

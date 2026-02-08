sealed class ResultState<T> {}

class ResultLoading<T> extends ResultState<T> {}

class ResultSuccess<T> extends ResultState<T> {
  final T data;
  ResultSuccess(this.data);
}

class ResultError<T> extends ResultState<T> {
  final String message;
  ResultError(this.message);
}

class ResultNone<T> extends ResultState<T> {}

sealed class ResultState {}

class ResultLoading extends ResultState {}

class ResultNone extends ResultState {}

class ResultSuccess<T> extends ResultState {
  final T data;
  ResultSuccess({required this.data});
}

class ResultError extends ResultState {
  final String message;
  ResultError({required this.message});
}

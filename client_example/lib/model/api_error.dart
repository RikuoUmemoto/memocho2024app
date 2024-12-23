class ApiError {
  const ApiError({
    required this.code,
    required this.error,
  });

  final ERROR_CODE code;
  final dynamic error;
}

enum ERROR_CODE {
  NETWORK_ERROR,
}

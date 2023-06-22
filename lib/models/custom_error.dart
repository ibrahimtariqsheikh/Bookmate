class CustomError {
  final String message;
  final String plugin;
  final String code;

  const CustomError({
    this.message = '',
    this.plugin = '',
    this.code = '',
  });

  @override
  String toString() {
    return '$plugin: $message';
  }
}

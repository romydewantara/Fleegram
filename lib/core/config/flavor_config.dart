class FlavorConfig {
  static const bool isPaid = bool.fromEnvironment(
    'IS_PAID',
    defaultValue: false,
  );
}

/// App-wide constants: class range, nav indices, breakpoints.
class AppConstants {
  AppConstants._();

  static const int minClass = 1;
  static const int maxClass = 12;

  static const int navHome = 0;
  static const int navCreate = 1;
  static const int navAi = 2;
  static const int navLobby = 3;
  static const int navProfile = 4;

  /// Breakpoint width for tablet/desktop layout (e.g. side nav or max content width).
  static const double breakpointTablet = 600;
  static const double breakpointDesktop = 900;
  static const double maxContentWidth = 600;
}

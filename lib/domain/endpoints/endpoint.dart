class EndPoins {
  static String cities = "cities";
  static String categories = "categories";
  static String home = "home";
  static String login = "auth/login";
  static String deleteCustomer(customerId) => "customers/$customerId";
  static String register = "auth/register";
  static String user = "auth/user";
  static String sendOTP = "auth/sendOTP";
  static String forgetPass = "/api/lost_password.php";
  static String changePass = "auth/change-password";
  static String restPass = "auth/rest-password";
  static String updateUserData = "auth/update";
  static String vertfyOtp = "auth/verify-number";
  static String favourit = "favorite";
  static String favouritToggel = "favourite/toggel";

  static String booking = "booking";
  static String ads = "ads";
  static String adsByCategory(categoryId) => "category/$categoryId/ads";
  static String adsById(uid) => "ads/$uid";
  static String bookingByUid(uid) => "booking/?status=$uid";
  static String cancelBooking(uid) => "booking/$uid/cancel";
  static String rate(uid) => "vendor/$uid/write-rating";
  static String getRate(uid) => "vendor/$uid/ratings";

  static const String URL_STORE_API_PATH = '/wp-json/wc/store/';
  static const String URL_JWT_BASE = '/wp-json/jwt-auth/v1';
  static const URL_JWT_TOKEN = '/$URL_JWT_BASE/token';
  static const String DEFAULT_WC_API_PATH = "/wp-json/wc/v3/";
  static const String URL_WP_BASE = '/wp-json/wp/v2';
  static const String URL_USER_ME = '$URL_WP_BASE/users/me';
  // static const String URL_REGISTER_ENDPOINT = '$URL_WP_BASE/users/register';
}

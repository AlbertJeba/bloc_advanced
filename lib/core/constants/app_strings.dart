import 'package:get/get_utils/get_utils.dart';

/// AppStrings - Centralized String Registry
///
/// This class provides type-safe access to localized strings defined in
/// en.json, ta.json, and hi.json.
/// It uses the GetX `.tr` extension to handle translations.
///
/// Usage:
/// ```dart
/// Text(AppStrings.welcomeBack)
/// ```
class AppStrings {
  static String get appName => "APP_NAME".tr;

  static String get appSubtitle => "APP_SUBTITLE".tr;

  static String get login => "LOGIN".tr;

  static String get username => "USERNAME".tr;

  static String get password => "PASSWORD".tr;

  static String get usernameValidation => "USERNAME_VALIDATION_TEXT".tr;

  static String get passwordValidation => "PASSWORD_VALIDATION_TEXT".tr;

  static String get enterUsername => "ENTER_USERNAME".tr;

  static String get enterPassword => "ENTER_PASSWORD".tr;

  static String get welcomeBack => "WELCOME_BACK".tr;

  static String get signInContinue => "SIGN_IN_CONTINUE".tr;

  static String get logout => "LOGOUT".tr;

  static String get welcome => "WELCOME".tr;

  static String get error => "ERROR".tr;

  static String get success => "SUCCESS".tr;

  static String get info => "INFO".tr;

  static String get warning => "WARNING".tr;

  static String get retry => "RETRY".tr;

  static String get cancel => "CANCEL".tr;

  static String get sessionExpiryMsg => "SESSION_EXPIRY_MSG".tr;

  static String get noInternetMsg => "NO_INTERNET_MSG".tr;

  static String get errorOccurred => "ERROR_OCCURRED".tr;

  static String get unableToConnect => "UNABLE_TO_CONNECT".tr;

  static String get unknownError => "UNKNOWN_ERROR".tr;

  static String get myCart => "MY_CART".tr;

  static String get clearCart => "CLEAR_CART".tr;

  static String get clearCartConfirm => "CLEAR_CART_CONFIRM".tr;

  static String get clear => "CLEAR".tr;

  static String get deliveryInMins => "DELIVERY_IN_MINS".tr;

  static String get deliveryHeader => "DELIVERY_HEADER".tr;

  static String get billDetails => "BILL_DETAILS".tr;

  static String get itemTotal => "ITEM_TOTAL".tr;

  static String get deliveryFee => "DELIVERY_FEE".tr;

  static String get free => "FREE".tr;

  static String get totalSavings => "TOTAL_SAVINGS".tr;

  static String get toPay => "TO_PAY".tr;

  static String get total => "TOTAL".tr;

  static String get proceedToPay => "PROCEED_TO_PAY".tr;

  static String get yourCartEmpty => "YOUR_CART_EMPTY".tr;

  static String get cartEmptySubtitle => "CART_EMPTY_SUBTITLE".tr;

  static String get startShopping => "START_SHOPPING".tr;

  static String get viewCart => "VIEW_CART".tr;

  static String get checkout => "CHECKOUT".tr;

  static String get deliveryAddress => "DELIVERY_ADDRESS".tr;

  static String get change => "CHANGE".tr;

  static String get addAddress => "ADD_ADDRESS".tr;

  static String get addNewAddress => "ADD_NEW_ADDRESS".tr;

  static String get deliveryInstructions => "DELIVERY_INSTRUCTIONS".tr;

  static String get instructionsHint => "INSTRUCTIONS_HINT".tr;

  static String get paymentMethod => "PAYMENT_METHOD".tr;

  static String get cashOnDelivery => "CASH_ON_DELIVERY".tr;

  static String get cashOnDeliverySub => "CASH_ON_DELIVERY_SUB".tr;

  static String get upiInstant => "UPI_INSTANT".tr;

  static String get upiInstantSub => "UPI_INSTANT_SUB".tr;

  static String get cardPayment => "CARD_PAYMENT".tr;

  static String get cardPaymentSub => "CARD_PAYMENT_SUB".tr;

  static String get billSummary => "BILL_SUMMARY".tr;

  static String get taxesCharges => "TAXES_CHARGES".tr;

  static String get placeOrder => "PLACE_ORDER".tr;

  static String get selectDeliveryAddress => "SELECT_DELIVERY_ADDRESS".tr;

  static String get newAddress => "NEW_ADDRESS".tr;

  static String get saveAddress => "SAVE_ADDRESS".tr;

  static String get houseStreet => "HOUSE_STREET".tr;

  static String get areaColony => "AREA_COLONY".tr;

  static String get city => "CITY".tr;

  static String get state => "STATE".tr;

  static String get pinCode => "PIN_CODE".tr;

  static String get phoneNumber => "PHONE_NUMBER".tr;

  static String get type => "TYPE".tr;

  static String get home => "HOME".tr;

  static String get work => "WORK".tr;

  static String get other => "OTHER".tr;

  static String get orderSuccessTitle => "ORDER_SUCCESS_TITLE".tr;

  static String get orderSuccessSubtitle => "ORDER_SUCCESS_SUBTITLE".tr;

  static String get orderNumber => "ORDER_NUMBER".tr;

  static String get estimatedDelivery => "ESTIMATED_DELIVERY".tr;

  static String get totalPaid => "TOTAL_PAID".tr;

  static String get paymentMode => "PAYMENT_MODE".tr;

  static String get backToHome => "BACK_TO_HOME".tr;

  static String get myWishlist => "MY_WISHLIST".tr;

  static String get wishlistEmpty => "WISHLIST_EMPTY".tr;

  static String get wishlistEmptySubtitle => "WISHLIST_EMPTY_SUBTITLE".tr;

  static String get browseProducts => "BROWSE_PRODUCTS".tr;

  static String get noProductsInCategory => "NO_PRODUCTS_IN_CATEGORY".tr;

  static String get add => "ADD".tr;

  static String get productDetails => "PRODUCT_DETAILS".tr;

  static String get nutritionalInformation => "NUTRITIONAL_INFORMATION".tr;

  static String get calories => "CALORIES".tr;

  static String get carbs => "CARBS".tr;

  static String get fat => "FAT".tr;

  static String get protein => "PROTEIN".tr;

  static String get totalToPay => "TOTAL_TO_PAY".tr;

  static String get noDeliveryAddressSaved => "NO_DELIVERY_ADDRESS_SAVED".tr;

  static String get landmark => "LANDMARK".tr;

  static String get phone => "PHONE".tr;

  static String get off => "OFF".tr;

  static String get mrp => "MRP".tr;

  static String get reviews => "REVIEWS".tr;

  static String get myOrders => "MY_ORDERS".tr;

  static String get myProfile => "MY_PROFILE".tr;

  static String get shareApp => "SHARE_APP".tr;

  static String get shareAppMessage => "SHARE_APP_MESSAGE".tr;

  static String get appVersion => "APP_VERSION".tr;

  static String get noOrdersYet => "NO_ORDERS_YET".tr;

  static String get noOrdersSubtitle => "NO_ORDERS_SUBTITLE".tr;

  static String get trackOrder => "TRACK_ORDER".tr;

  static String get deliveryPartner => "DELIVERY_PARTNER".tr;

  static String get items => "ITEMS".tr;

  static String get orderTimeline => "ORDER_TIMELINE".tr;

  static String get confirmLogout => "CONFIRM_LOGOUT".tr;

  static String get yesLogout => "YES_LOGOUT".tr;

  static String get editProfile => "EDIT_PROFILE".tr;

  static String get saveChanges => "SAVE_CHANGES".tr;

  static String get personalInformation => "PERSONAL_INFORMATION".tr;

  static String get profileUpdatedSuccess => "PROFILE_UPDATED_SUCCESS".tr;

  static String get fullName => "FULL_NAME".tr;

  static String get emailAddress => "EMAIL_ADDRESS".tr;

  static String get verified => "VERIFIED".tr;

  static String get enterName => "ENTER_NAME".tr;

  static String get enterPhone => "ENTER_PHONE".tr;

  static String get enterEmail => "ENTER_EMAIL".tr;

  static String get signUp => "SIGN_UP".tr;

  static String get createAccount => "CREATE_ACCOUNT".tr;

  static String get createAccountSub => "CREATE_ACCOUNT_SUB".tr;

  static String get dontHaveAccount => "DONT_HAVE_ACCOUNT".tr;

  static String get alreadyHaveAccount => "ALREADY_HAVE_ACCOUNT".tr;

  static String get signIn => "SIGN_IN".tr;

  static String get nameValidation => "NAME_VALIDATION".tr;

  static String get emailValidation => "EMAIL_VALIDATION".tr;

  static String get passwordLengthValidation => "PASSWORD_LENGTH_VALIDATION".tr;

  static String get registrationSuccess => "REGISTRATION_SUCCESS".tr;

  static String get changeLanguage => "CHANGE_LANGUAGE".tr;

  static String get selectLanguage => "SELECT_LANGUAGE".tr;

  static String get chooseLanguageSub => "CHOOSE_LANGUAGE_SUB".tr;
}

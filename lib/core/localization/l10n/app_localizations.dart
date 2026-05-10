import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Rise Now'**
  String get appName;

  /// No description provided for @unexpectedError.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred. Please try again.'**
  String get unexpectedError;

  /// No description provided for @unauthorizedUserException.
  ///
  /// In en, this message translates to:
  /// **'Unauthorized user. Please log in again.'**
  String get unauthorizedUserException;

  /// No description provided for @failToLoad.
  ///
  /// In en, this message translates to:
  /// **'Failed to load. Please try again.'**
  String get failToLoad;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get somethingWentWrong;

  /// No description provided for @noInternetConnection.
  ///
  /// In en, this message translates to:
  /// **'No internet connection available.'**
  String get noInternetConnection;

  /// No description provided for @connectionIssueTryLater.
  ///
  /// In en, this message translates to:
  /// **'There was a connection issue. Please try again later.'**
  String get connectionIssueTryLater;

  /// No description provided for @noInternetFound.
  ///
  /// In en, this message translates to:
  /// **'No internet found, check your connection'**
  String get noInternetFound;

  /// No description provided for @unAuthenticatedMessage.
  ///
  /// In en, this message translates to:
  /// **'Your session has expired, please log in again'**
  String get unAuthenticatedMessage;

  /// No description provided for @saturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get saturday;

  /// No description provided for @sunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get sunday;

  /// No description provided for @monday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get monday;

  /// No description provided for @tuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get tuesday;

  /// No description provided for @wednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get wednesday;

  /// No description provided for @thursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get thursday;

  /// No description provided for @friday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get friday;

  /// No description provided for @storeUpdaterTitle.
  ///
  /// In en, this message translates to:
  /// **'Update Available'**
  String get storeUpdaterTitle;

  /// No description provided for @storeUpdaterMessage.
  ///
  /// In en, this message translates to:
  /// **'A new version of the app is available. Please update to continue.'**
  String get storeUpdaterMessage;

  /// No description provided for @storeUpdaterBtnLabel.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get storeUpdaterBtnLabel;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @deleteAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Do you want to delete the account?'**
  String get deleteAccountTitle;

  /// No description provided for @deleteAccountDescription.
  ///
  /// In en, this message translates to:
  /// **'Make sure to save any changes you\'ve made or finish the tasks you\'re working on before continuing to avoid data loss.'**
  String get deleteAccountDescription;

  /// No description provided for @deleteAccountSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Your account has been deleted successfully.'**
  String get deleteAccountSuccessMessage;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logOut;

  /// No description provided for @logOutTitle.
  ///
  /// In en, this message translates to:
  /// **'Do you want to log out?'**
  String get logOutTitle;

  /// No description provided for @logoutDescription.
  ///
  /// In en, this message translates to:
  /// **'Make sure to save any changes you\'ve made or finish the tasks you\'re working on before continuing to avoid data loss.'**
  String get logoutDescription;

  /// No description provided for @riyal.
  ///
  /// In en, this message translates to:
  /// **'Riyal'**
  String get riyal;

  /// No description provided for @pickImageFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get pickImageFromGallery;

  /// No description provided for @pickImageFromCamera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get pickImageFromCamera;

  /// No description provided for @pickVideoFromCamera.
  ///
  /// In en, this message translates to:
  /// **'Pick Video From Camera'**
  String get pickVideoFromCamera;

  /// No description provided for @pickVideoFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Pick Video From Gallery'**
  String get pickVideoFromGallery;

  /// No description provided for @cantOpenLink.
  ///
  /// In en, this message translates to:
  /// **'Cannot open link, make sure it\'s valid.'**
  String get cantOpenLink;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get changeLanguage;

  /// No description provided for @changeLanguageDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose the language you want to use in the app'**
  String get changeLanguageDescription;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @aboutUs.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get aboutUs;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms and Conditions'**
  String get termsAndConditions;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @instructions.
  ///
  /// In en, this message translates to:
  /// **'Instructions'**
  String get instructions;

  /// No description provided for @noCitiesFound.
  ///
  /// In en, this message translates to:
  /// **'No cities found'**
  String get noCitiesFound;

  /// No description provided for @verificationCode.
  ///
  /// In en, this message translates to:
  /// **'Verification Code'**
  String get verificationCode;

  /// No description provided for @changeDataSuccessMessageTitle.
  ///
  /// In en, this message translates to:
  /// **'Data changed successfully'**
  String get changeDataSuccessMessageTitle;

  /// No description provided for @changeDataSuccessMessageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your data has been successfully changed, and the changes have been saved to your account. You can now enjoy a more accurate and convenient experience.'**
  String get changeDataSuccessMessageSubtitle;

  /// No description provided for @showMore.
  ///
  /// In en, this message translates to:
  /// **'Show more'**
  String get showMore;

  /// No description provided for @failedToGetLocationDetails.
  ///
  /// In en, this message translates to:
  /// **'Failed to get location details'**
  String get failedToGetLocationDetails;

  /// No description provided for @addressDetails.
  ///
  /// In en, this message translates to:
  /// **'Address details'**
  String get addressDetails;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @searchForAddres.
  ///
  /// In en, this message translates to:
  /// **'Search for address'**
  String get searchForAddres;

  /// No description provided for @maps.
  ///
  /// In en, this message translates to:
  /// **'Maps'**
  String get maps;

  /// No description provided for @payment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get payment;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @chat.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get chat;

  /// No description provided for @typeMessage.
  ///
  /// In en, this message translates to:
  /// **'Type a message...'**
  String get typeMessage;

  /// No description provided for @noMessagesYet.
  ///
  /// In en, this message translates to:
  /// **'No messages yet. Start the conversation.'**
  String get noMessagesYet;

  /// No description provided for @continue_.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continue_;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @upload.
  ///
  /// In en, this message translates to:
  /// **'Upload'**
  String get upload;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @startNow.
  ///
  /// In en, this message translates to:
  /// **'Start now'**
  String get startNow;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @agree.
  ///
  /// In en, this message translates to:
  /// **'Agree'**
  String get agree;

  /// No description provided for @change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get change;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @failed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get failed;

  /// No description provided for @disagree.
  ///
  /// In en, this message translates to:
  /// **'Disagree'**
  String get disagree;

  /// No description provided for @search_.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search_;

  /// No description provided for @pay.
  ///
  /// In en, this message translates to:
  /// **'Pay'**
  String get pay;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @createNewAccount.
  ///
  /// In en, this message translates to:
  /// **'Create new account?'**
  String get createNewAccount;

  /// No description provided for @fieldRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required.'**
  String get fieldRequired;

  /// No description provided for @fieldMustNotHaveSpaces.
  ///
  /// In en, this message translates to:
  /// **'This field must not have spaces.'**
  String get fieldMustNotHaveSpaces;

  /// No description provided for @invalidIban.
  ///
  /// In en, this message translates to:
  /// **'The IBAN must contain only letters and numbers, and be between 15 and 34 characters long.'**
  String get invalidIban;

  /// No description provided for @nameTooShort.
  ///
  /// In en, this message translates to:
  /// **'Name is too short.'**
  String get nameTooShort;

  /// No description provided for @invalidEnglishName.
  ///
  /// In en, this message translates to:
  /// **'Invalid English Name'**
  String get invalidEnglishName;

  /// No description provided for @invalidArabicName.
  ///
  /// In en, this message translates to:
  /// **'Invalid Arabic Name'**
  String get invalidArabicName;

  /// No description provided for @invalidEmailFormat.
  ///
  /// In en, this message translates to:
  /// **'Invalid email address format.'**
  String get invalidEmailFormat;

  /// No description provided for @passwordRequirements.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters long, include capital letters, at least one lowercase letter and special character.'**
  String get passwordRequirements;

  /// No description provided for @passwordConfirmValidation.
  ///
  /// In en, this message translates to:
  /// **'Password confirmation is not same'**
  String get passwordConfirmValidation;

  /// No description provided for @urlValidateMessage.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid URL'**
  String get urlValidateMessage;

  /// No description provided for @invalidDateFormat.
  ///
  /// In en, this message translates to:
  /// **'Invalid Date Format'**
  String get invalidDateFormat;

  /// No description provided for @dateMustBeAfter.
  ///
  /// In en, this message translates to:
  /// **'Date Must Be After'**
  String get dateMustBeAfter;

  /// No description provided for @phoneFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Mobile number'**
  String get phoneFieldHint;

  /// No description provided for @profileImageValidation.
  ///
  /// In en, this message translates to:
  /// **'Profile image is required'**
  String get profileImageValidation;

  /// No description provided for @invalidPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone number invalid format.'**
  String get invalidPhoneNumber;

  /// No description provided for @searchForCountry.
  ///
  /// In en, this message translates to:
  /// **'Search for country'**
  String get searchForCountry;

  /// No description provided for @noResultFound.
  ///
  /// In en, this message translates to:
  /// **'No result found'**
  String get noResultFound;

  /// No description provided for @paginationLoadingMore.
  ///
  /// In en, this message translates to:
  /// **'Loading more...'**
  String get paginationLoadingMore;

  /// No description provided for @paginationCouldNotLoadMore.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load more. Tap to retry.'**
  String get paginationCouldNotLoadMore;

  /// No description provided for @paginationNoItems.
  ///
  /// In en, this message translates to:
  /// **'No items to show'**
  String get paginationNoItems;

  /// No description provided for @materialPhoneFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Mobile number'**
  String get materialPhoneFieldLabel;

  /// No description provided for @materialPhoneFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your mobile number'**
  String get materialPhoneFieldHint;

  /// No description provided for @materialPhoneSearchCountry.
  ///
  /// In en, this message translates to:
  /// **'Search for country'**
  String get materialPhoneSearchCountry;

  /// No description provided for @materialPhoneNoCountryResults.
  ///
  /// In en, this message translates to:
  /// **'No result found'**
  String get materialPhoneNoCountryResults;

  /// No description provided for @materialPhoneInvalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number'**
  String get materialPhoneInvalid;

  /// No description provided for @materialReadMore.
  ///
  /// In en, this message translates to:
  /// **'Read more'**
  String get materialReadMore;

  /// No description provided for @materialReadLess.
  ///
  /// In en, this message translates to:
  /// **'Read less'**
  String get materialReadLess;

  /// No description provided for @youMustAgreeTermsAndConditionsFirst.
  ///
  /// In en, this message translates to:
  /// **'You must agree to the terms and conditions first'**
  String get youMustAgreeTermsAndConditionsFirst;

  /// No description provided for @invalidIdentityNumber.
  ///
  /// In en, this message translates to:
  /// **'Invalid identity number'**
  String get invalidIdentityNumber;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @theSearch.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get theSearch;

  /// No description provided for @bankName.
  ///
  /// In en, this message translates to:
  /// **'Bank name'**
  String get bankName;

  /// No description provided for @enterBankName.
  ///
  /// In en, this message translates to:
  /// **'Enter bank name'**
  String get enterBankName;

  /// No description provided for @ibaneNumber.
  ///
  /// In en, this message translates to:
  /// **'Ibane number'**
  String get ibaneNumber;

  /// No description provided for @enterIbaneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter ibane number'**
  String get enterIbaneNumber;

  /// No description provided for @inCorrectPassword.
  ///
  /// In en, this message translates to:
  /// **'Incorrect password'**
  String get inCorrectPassword;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

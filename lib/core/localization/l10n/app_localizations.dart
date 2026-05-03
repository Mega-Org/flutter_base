import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_ur.dart';

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
    Locale('ur'),
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

  /// No description provided for @unAutherizedUserExeption.
  ///
  /// In en, this message translates to:
  /// **'Unauthorized user. Please log in again.'**
  String get unAutherizedUserExeption;

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

  /// No description provided for @clientOnboardingTitleOne.
  ///
  /// In en, this message translates to:
  /// **'Easy trip anytime'**
  String get clientOnboardingTitleOne;

  /// No description provided for @clientOnboardingSubtitleOne.
  ///
  /// In en, this message translates to:
  /// **'Order your car with one click, arrive faster at the lowest cost.'**
  String get clientOnboardingSubtitleOne;

  /// No description provided for @clientOnboardingTitleTwo.
  ///
  /// In en, this message translates to:
  /// **'Choose your trip your way'**
  String get clientOnboardingTitleTwo;

  /// No description provided for @clientOnboardingSubtitleTwo.
  ///
  /// In en, this message translates to:
  /// **'From a city ride to a tourist trip or intercity travel… and even a private driver by the hour, all services at your fingertips.'**
  String get clientOnboardingSubtitleTwo;

  /// No description provided for @clientOnboardingTitleThree.
  ///
  /// In en, this message translates to:
  /// **'Safe and reliable trip'**
  String get clientOnboardingTitleThree;

  /// No description provided for @clientOnboardingSubtitleThree.
  ///
  /// In en, this message translates to:
  /// **'Share your location with those you love, and enjoy a comfortable, reassuring trip'**
  String get clientOnboardingSubtitleThree;

  /// No description provided for @staffOnboardingTitleOne.
  ///
  /// In en, this message translates to:
  /// **'Printing services tailored to you'**
  String get staffOnboardingTitleOne;

  /// No description provided for @staffOnboardingSubtitleOne.
  ///
  /// In en, this message translates to:
  /// **'Everything you need in one place, just a few simple steps away.'**
  String get staffOnboardingSubtitleOne;

  /// No description provided for @staffOnboardingTitleTwo.
  ///
  /// In en, this message translates to:
  /// **'Your print shop in your pocket—order and print anytime.'**
  String get staffOnboardingTitleTwo;

  /// No description provided for @staffOnboardingSubtitleTwo.
  ///
  /// In en, this message translates to:
  /// **'Quick service, top quality, and competitive prices.'**
  String get staffOnboardingSubtitleTwo;

  /// No description provided for @staffOnboardingTitleThree.
  ///
  /// In en, this message translates to:
  /// **'From the print shop to your home or office, safely and fast.'**
  String get staffOnboardingTitleThree;

  /// No description provided for @staffOnboardingSubtitleThree.
  ///
  /// In en, this message translates to:
  /// **'Start now—let your prints reflect professionalism and take your work to the next level.'**
  String get staffOnboardingSubtitleThree;

  /// No description provided for @driverOnboardingTitleOne.
  ///
  /// In en, this message translates to:
  /// **'Start your journey with Zyarat'**
  String get driverOnboardingTitleOne;

  /// No description provided for @driverOnboardingSubtitleOne.
  ///
  /// In en, this message translates to:
  /// **'Join a wide network of trusted drivers, and start earning income from every trip you provide with safety and professionalism.'**
  String get driverOnboardingSubtitleOne;

  /// No description provided for @driverOnboardingTitleTwo.
  ///
  /// In en, this message translates to:
  /// **'Work whenever you want'**
  String get driverOnboardingTitleTwo;

  /// No description provided for @driverOnboardingSubtitleTwo.
  ///
  /// In en, this message translates to:
  /// **'Control your schedule yourself, choose trips that suit you, and track your earnings moment by moment through the app.'**
  String get driverOnboardingSubtitleTwo;

  /// No description provided for @driverOnboardingTitleThree.
  ///
  /// In en, this message translates to:
  /// **'Safe trips and continuous support'**
  String get driverOnboardingTitleThree;

  /// No description provided for @driverOnboardingSubtitleThree.
  ///
  /// In en, this message translates to:
  /// **'Your safety matters to us, every trip is tracked moment by moment, and the support team is always available when needed.'**
  String get driverOnboardingSubtitleThree;

  /// No description provided for @marketerOnboardingTitleOne.
  ///
  /// In en, this message translates to:
  /// **'Promote Zyarat and earn'**
  String get marketerOnboardingTitleOne;

  /// No description provided for @marketerOnboardingSubtitleOne.
  ///
  /// In en, this message translates to:
  /// **'Share trip links with your audience and earn when they book. One link, endless opportunities.'**
  String get marketerOnboardingSubtitleOne;

  /// No description provided for @marketerOnboardingTitleTwo.
  ///
  /// In en, this message translates to:
  /// **'Track your performance'**
  String get marketerOnboardingTitleTwo;

  /// No description provided for @marketerOnboardingSubtitleTwo.
  ///
  /// In en, this message translates to:
  /// **'See your referrals, clicks, and earnings in one place. Stay on top of your marketing results.'**
  String get marketerOnboardingSubtitleTwo;

  /// No description provided for @marketerOnboardingTitleThree.
  ///
  /// In en, this message translates to:
  /// **'Grow with us'**
  String get marketerOnboardingTitleThree;

  /// No description provided for @marketerOnboardingSubtitleThree.
  ///
  /// In en, this message translates to:
  /// **'Join a network of marketers. Get support, tips, and rewards as you help more people discover Zyarat.'**
  String get marketerOnboardingSubtitleThree;

  /// No description provided for @marketerRegistrationTitle.
  ///
  /// In en, this message translates to:
  /// **'Marketer Registration'**
  String get marketerRegistrationTitle;

  /// No description provided for @marketerRegistrationDescription.
  ///
  /// In en, this message translates to:
  /// **'Create your marketer account to start earning.'**
  String get marketerRegistrationDescription;

  /// No description provided for @marketerAvatar.
  ///
  /// In en, this message translates to:
  /// **'Avatar'**
  String get marketerAvatar;

  /// No description provided for @marketerIdentityImage.
  ///
  /// In en, this message translates to:
  /// **'Identity Document'**
  String get marketerIdentityImage;

  /// No description provided for @marketerIdentityImageHint.
  ///
  /// In en, this message translates to:
  /// **'Upload your identity document'**
  String get marketerIdentityImageHint;

  /// No description provided for @marketerIdentityImageRequired.
  ///
  /// In en, this message translates to:
  /// **'Identity document is required'**
  String get marketerIdentityImageRequired;

  /// No description provided for @marketerAccountType.
  ///
  /// In en, this message translates to:
  /// **'Account Type'**
  String get marketerAccountType;

  /// No description provided for @marketerAccountTypeHint.
  ///
  /// In en, this message translates to:
  /// **'Select account type'**
  String get marketerAccountTypeHint;

  /// No description provided for @marketerNationality.
  ///
  /// In en, this message translates to:
  /// **'Nationality'**
  String get marketerNationality;

  /// No description provided for @marketerNationalityHint.
  ///
  /// In en, this message translates to:
  /// **'Select nationality'**
  String get marketerNationalityHint;

  /// No description provided for @marketerAcceptTermsRequired.
  ///
  /// In en, this message translates to:
  /// **'You must accept the terms and conditions'**
  String get marketerAcceptTermsRequired;

  /// No description provided for @marketerHomeCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Total earnings'**
  String get marketerHomeCardTitle;

  /// No description provided for @marketerHomeCardValue.
  ///
  /// In en, this message translates to:
  /// **'0'**
  String get marketerHomeCardValue;

  /// No description provided for @marketerHomeCardSubtitle.
  ///
  /// In en, this message translates to:
  /// **'From your referrals this period'**
  String get marketerHomeCardSubtitle;

  /// No description provided for @pleaseSelectRoleFirst.
  ///
  /// In en, this message translates to:
  /// **'Please select user role first'**
  String get pleaseSelectRoleFirst;

  /// No description provided for @selectRoleTitleFirstSection.
  ///
  /// In en, this message translates to:
  /// **'Choose what suits you to start with the app'**
  String get selectRoleTitleFirstSection;

  /// No description provided for @selectRoleDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose what suits you to get started with our app and enjoy a personalized experience and services designed to meet your needs with ease and flexibility.'**
  String get selectRoleDescription;

  /// No description provided for @user.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get user;

  /// No description provided for @advertiser.
  ///
  /// In en, this message translates to:
  /// **'Advertiser'**
  String get advertiser;

  /// No description provided for @welcomeBackToRiseNowFirstSection.
  ///
  /// In en, this message translates to:
  /// **'Welcome back to the app'**
  String get welcomeBackToRiseNowFirstSection;

  /// No description provided for @loginDescription.
  ///
  /// In en, this message translates to:
  /// **'We are glad to see you again, and hope that your experience with us is always enjoyable and smooth.'**
  String get loginDescription;

  /// No description provided for @sendCode.
  ///
  /// In en, this message translates to:
  /// **'Send activation code'**
  String get sendCode;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @registerNow.
  ///
  /// In en, this message translates to:
  /// **'Register now'**
  String get registerNow;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @mobileFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get mobileFieldLabel;

  /// No description provided for @mobileFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your mobile number'**
  String get mobileFieldHint;

  /// No description provided for @otpFirstSection.
  ///
  /// In en, this message translates to:
  /// **'Please enter the verification code sent via text message to your mobile number'**
  String get otpFirstSection;

  /// No description provided for @otpSecondSection.
  ///
  /// In en, this message translates to:
  /// **'to complete the verification process.'**
  String get otpSecondSection;

  /// No description provided for @enterVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Enter verification code'**
  String get enterVerificationCode;

  /// No description provided for @verificationCodeLengthValidation.
  ///
  /// In en, this message translates to:
  /// **'Verification code must be 4 digits'**
  String get verificationCodeLengthValidation;

  /// No description provided for @otpSentSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Verification code sent successfully'**
  String get otpSentSuccessfully;

  /// No description provided for @dontReceiveCode.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive the code?'**
  String get dontReceiveCode;

  /// No description provided for @resend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend;

  /// No description provided for @registrationDescription.
  ///
  /// In en, this message translates to:
  /// **'Create a new account to take advantage of all our services and app features designed to meet your needs and facilitate your experience.'**
  String get registrationDescription;

  /// No description provided for @nameFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nameFieldHint;

  /// No description provided for @advertiserNameFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Advertiser Name'**
  String get advertiserNameFieldHint;

  /// No description provided for @cityFieldHint.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get cityFieldHint;

  /// No description provided for @identityNumberFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Identity Number'**
  String get identityNumberFieldLabel;

  /// No description provided for @identityNumberFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your identity number'**
  String get identityNumberFieldHint;

  /// No description provided for @commercialRegistrationNumberFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Commercial Registration Number'**
  String get commercialRegistrationNumberFieldHint;

  /// No description provided for @emailAddressFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddressFieldHint;

  /// No description provided for @termsFirstSection.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get termsFirstSection;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorite'**
  String get favorites;

  /// No description provided for @noFavorites.
  ///
  /// In en, this message translates to:
  /// **'No favorite drivers yet.'**
  String get noFavorites;

  /// No description provided for @removeFromFavoritesList.
  ///
  /// In en, this message translates to:
  /// **'Remove from favorites list'**
  String get removeFromFavoritesList;

  /// No description provided for @removedFromFavorites.
  ///
  /// In en, this message translates to:
  /// **'Removed from favorites'**
  String get removedFromFavorites;

  /// No description provided for @addedToFavorites.
  ///
  /// In en, this message translates to:
  /// **'Added to favorites'**
  String get addedToFavorites;

  /// No description provided for @packages.
  ///
  /// In en, this message translates to:
  /// **'Packages'**
  String get packages;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @homeAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to app'**
  String get homeAppBarTitle;

  /// No description provided for @adsCategories.
  ///
  /// In en, this message translates to:
  /// **'Advertisments Categories'**
  String get adsCategories;

  /// No description provided for @highestRated.
  ///
  /// In en, this message translates to:
  /// **'Highest Rated'**
  String get highestRated;

  /// No description provided for @noAdvertismentsFoundTitle.
  ///
  /// In en, this message translates to:
  /// **'No advertisments found'**
  String get noAdvertismentsFoundTitle;

  /// No description provided for @noAdvertismentsFoundDescription.
  ///
  /// In en, this message translates to:
  /// **'There are no advertisments available at the moment, but follow us to be the first one to know about the upcoming offers.'**
  String get noAdvertismentsFoundDescription;

  /// No description provided for @noAdvertismentsAddedYetTitle.
  ///
  /// In en, this message translates to:
  /// **'You have not posted any ads yet.'**
  String get noAdvertismentsAddedYetTitle;

  /// No description provided for @noAdvertismentsAddedYetDescription.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t posted any ads yet, start posting your first ad now to reach your audience and achieve the best results.'**
  String get noAdvertismentsAddedYetDescription;

  /// No description provided for @noCategoriesFoundTitle.
  ///
  /// In en, this message translates to:
  /// **'No categories found'**
  String get noCategoriesFoundTitle;

  /// No description provided for @noCategoriesFoundDescription.
  ///
  /// In en, this message translates to:
  /// **'There are no categories available at the moment, they will be added as soon as possible.'**
  String get noCategoriesFoundDescription;

  /// No description provided for @mobileNumbers.
  ///
  /// In en, this message translates to:
  /// **'Mobile numbers'**
  String get mobileNumbers;

  /// No description provided for @managementWhatsApp.
  ///
  /// In en, this message translates to:
  /// **'Management WhatsApp'**
  String get managementWhatsApp;

  /// No description provided for @managementEmail.
  ///
  /// In en, this message translates to:
  /// **'Management email'**
  String get managementEmail;

  /// No description provided for @sendMessage.
  ///
  /// In en, this message translates to:
  /// **'Send message'**
  String get sendMessage;

  /// No description provided for @messageType.
  ///
  /// In en, this message translates to:
  /// **'Message type'**
  String get messageType;

  /// No description provided for @selectMessageType.
  ///
  /// In en, this message translates to:
  /// **'Select message type'**
  String get selectMessageType;

  /// No description provided for @message.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get message;

  /// No description provided for @request.
  ///
  /// In en, this message translates to:
  /// **'Request'**
  String get request;

  /// No description provided for @inquiry.
  ///
  /// In en, this message translates to:
  /// **'Inquiry'**
  String get inquiry;

  /// No description provided for @suggestion.
  ///
  /// In en, this message translates to:
  /// **'Suggestion'**
  String get suggestion;

  /// No description provided for @complaint.
  ///
  /// In en, this message translates to:
  /// **'Complaint'**
  String get complaint;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @contactUsSuccessMessageTitle.
  ///
  /// In en, this message translates to:
  /// **'Message sent successfully'**
  String get contactUsSuccessMessageTitle;

  /// No description provided for @contactUsSuccessMessageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We will contact you soon'**
  String get contactUsSuccessMessageSubtitle;

  /// No description provided for @changeMobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Change Mobile Number'**
  String get changeMobileNumber;

  /// No description provided for @personalInformation.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInformation;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @changePhoneSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Phone number changed successfully'**
  String get changePhoneSuccessTitle;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @noNotificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'No notifications yet'**
  String get noNotificationsTitle;

  /// No description provided for @noNotificationsDescription.
  ///
  /// In en, this message translates to:
  /// **'No notifications yet. It looks like you haven\'t received any new alerts at this time. We\'ll let you know as soon as we have any updates.'**
  String get noNotificationsDescription;

  /// No description provided for @enterAsGuest.
  ///
  /// In en, this message translates to:
  /// **'Enter as guest'**
  String get enterAsGuest;

  /// No description provided for @welcomeInZyarat24.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Zyarat 24'**
  String get welcomeInZyarat24;

  /// No description provided for @loginNowToStartYourTrips.
  ///
  /// In en, this message translates to:
  /// **'Login now to start your trips with Zyarat 24'**
  String get loginNowToStartYourTrips;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @secondName.
  ///
  /// In en, this message translates to:
  /// **'Second Name'**
  String get secondName;

  /// No description provided for @familyName.
  ///
  /// In en, this message translates to:
  /// **'Family Name'**
  String get familyName;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// No description provided for @genderHint.
  ///
  /// In en, this message translates to:
  /// **'Select gender (male-female) ...'**
  String get genderHint;

  /// No description provided for @selectCity.
  ///
  /// In en, this message translates to:
  /// **'Select City'**
  String get selectCity;

  /// No description provided for @selectDistrict.
  ///
  /// In en, this message translates to:
  /// **'Select District'**
  String get selectDistrict;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @district.
  ///
  /// In en, this message translates to:
  /// **'District'**
  String get district;

  /// No description provided for @noDistrictsFound.
  ///
  /// In en, this message translates to:
  /// **'No districts found'**
  String get noDistrictsFound;

  /// No description provided for @selectVehicleType.
  ///
  /// In en, this message translates to:
  /// **'Select Vehicle Type'**
  String get selectVehicleType;

  /// No description provided for @selectVehicleModel.
  ///
  /// In en, this message translates to:
  /// **'Select Vehicle Model'**
  String get selectVehicleModel;

  /// No description provided for @noVehicleTypesFound.
  ///
  /// In en, this message translates to:
  /// **'No vehicle types found'**
  String get noVehicleTypesFound;

  /// No description provided for @noVehicleModelsFound.
  ///
  /// In en, this message translates to:
  /// **'No vehicle models found'**
  String get noVehicleModelsFound;

  /// No description provided for @birthDay.
  ///
  /// In en, this message translates to:
  /// **'Birthday'**
  String get birthDay;

  /// No description provided for @hijriDateOfBirthHint.
  ///
  /// In en, this message translates to:
  /// **'Select your birth day in hijri calendar'**
  String get hijriDateOfBirthHint;

  /// No description provided for @youAgeMustBeMoreThan18YearsOld.
  ///
  /// In en, this message translates to:
  /// **'You must be more than 18 years old'**
  String get youAgeMustBeMoreThan18YearsOld;

  /// No description provided for @completeYourProfile.
  ///
  /// In en, this message translates to:
  /// **'Complete your profile'**
  String get completeYourProfile;

  /// No description provided for @basicInformation.
  ///
  /// In en, this message translates to:
  /// **'Basic Information'**
  String get basicInformation;

  /// No description provided for @carInformation.
  ///
  /// In en, this message translates to:
  /// **'Car Information'**
  String get carInformation;

  /// No description provided for @requiredImages.
  ///
  /// In en, this message translates to:
  /// **'Required Images'**
  String get requiredImages;

  /// No description provided for @carType.
  ///
  /// In en, this message translates to:
  /// **'Car Type'**
  String get carType;

  /// No description provided for @carModel.
  ///
  /// In en, this message translates to:
  /// **'Car Model'**
  String get carModel;

  /// No description provided for @carColor.
  ///
  /// In en, this message translates to:
  /// **'Car Color'**
  String get carColor;

  /// No description provided for @carManufactureYear.
  ///
  /// In en, this message translates to:
  /// **'Car Manufacture Year'**
  String get carManufactureYear;

  /// No description provided for @carPlateLetters.
  ///
  /// In en, this message translates to:
  /// **'Car Plate Letters'**
  String get carPlateLetters;

  /// No description provided for @carPlateNumbers.
  ///
  /// In en, this message translates to:
  /// **'Car Plate Numbers'**
  String get carPlateNumbers;

  /// No description provided for @carPlateLettersHint.
  ///
  /// In en, this message translates to:
  /// **'Enter the left letters of the plate'**
  String get carPlateLettersHint;

  /// No description provided for @carPlateNumbersHint.
  ///
  /// In en, this message translates to:
  /// **'Enter the left numbers of the plate'**
  String get carPlateNumbersHint;

  /// No description provided for @invalidPlateNumbers.
  ///
  /// In en, this message translates to:
  /// **'Plate number must be exactly 4 digits'**
  String get invalidPlateNumbers;

  /// No description provided for @attachImage.
  ///
  /// In en, this message translates to:
  /// **'Attach image'**
  String get attachImage;

  /// No description provided for @waypoints.
  ///
  /// In en, this message translates to:
  /// **'Waypoints'**
  String get waypoints;

  /// No description provided for @carImage.
  ///
  /// In en, this message translates to:
  /// **'Car Image'**
  String get carImage;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @isCarOwner.
  ///
  /// In en, this message translates to:
  /// **'Are you the car owner?'**
  String get isCarOwner;

  /// No description provided for @isCarForSpecialNeeds.
  ///
  /// In en, this message translates to:
  /// **'Is the car for special needs?'**
  String get isCarForSpecialNeeds;

  /// No description provided for @specialNeedsCarImage.
  ///
  /// In en, this message translates to:
  /// **'Special needs car image'**
  String get specialNeedsCarImage;

  /// No description provided for @vehicleRegistrationNumberHint.
  ///
  /// In en, this message translates to:
  /// **'Enter the serial number of the vehicle on the form'**
  String get vehicleRegistrationNumberHint;

  /// No description provided for @vehicleRegistrationNumber.
  ///
  /// In en, this message translates to:
  /// **'Vehicle registration number'**
  String get vehicleRegistrationNumber;

  /// No description provided for @specialNeedsCarImageDescription.
  ///
  /// In en, this message translates to:
  /// **'Attach a car image for special needs'**
  String get specialNeedsCarImageDescription;

  /// No description provided for @attachCarImageFromFrontWithClearPlate.
  ///
  /// In en, this message translates to:
  /// **'Attach car image from the front with a clear plate'**
  String get attachCarImageFromFrontWithClearPlate;

  /// No description provided for @nationalId.
  ///
  /// In en, this message translates to:
  /// **'National ID'**
  String get nationalId;

  /// No description provided for @attachNationalIdImage.
  ///
  /// In en, this message translates to:
  /// **'Attach National ID image'**
  String get attachNationalIdImage;

  /// No description provided for @driverLicense.
  ///
  /// In en, this message translates to:
  /// **'Driver License'**
  String get driverLicense;

  /// No description provided for @attachDriverLicenseImage.
  ///
  /// In en, this message translates to:
  /// **'Attach Driver License image'**
  String get attachDriverLicenseImage;

  /// No description provided for @vehicleRegistration.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Registration'**
  String get vehicleRegistration;

  /// No description provided for @attachVehicleRegistrationImage.
  ///
  /// In en, this message translates to:
  /// **'Attach Vehicle Registration image'**
  String get attachVehicleRegistrationImage;

  /// No description provided for @vehicleInsurance.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Insurance'**
  String get vehicleInsurance;

  /// No description provided for @attachVehicleInsuranceImage.
  ///
  /// In en, this message translates to:
  /// **'Attach Vehicle Insurance image'**
  String get attachVehicleInsuranceImage;

  /// No description provided for @ownershipAuthorization.
  ///
  /// In en, this message translates to:
  /// **'Ownership Authorization'**
  String get ownershipAuthorization;

  /// No description provided for @toWhere.
  ///
  /// In en, this message translates to:
  /// **'To where?'**
  String get toWhere;

  /// No description provided for @attachOwnershipAuthorizationImage.
  ///
  /// In en, this message translates to:
  /// **'Attach Ownership Authorization image (if you are not the car owner)'**
  String get attachOwnershipAuthorizationImage;

  /// No description provided for @carReservation.
  ///
  /// In en, this message translates to:
  /// **'Car Reservation'**
  String get carReservation;

  /// No description provided for @carReservationFullTitle.
  ///
  /// In en, this message translates to:
  /// **'Car Reservation'**
  String get carReservationFullTitle;

  /// No description provided for @multipleDestinations.
  ///
  /// In en, this message translates to:
  /// **'Multiple Destinations'**
  String get multipleDestinations;

  /// No description provided for @multipleDestinationsFullTitle.
  ///
  /// In en, this message translates to:
  /// **'More Than One Destination'**
  String get multipleDestinationsFullTitle;

  /// No description provided for @roundTrip.
  ///
  /// In en, this message translates to:
  /// **'Round Trip'**
  String get roundTrip;

  /// No description provided for @roundTripFullTitle.
  ///
  /// In en, this message translates to:
  /// **'Go and Return'**
  String get roundTripFullTitle;

  /// No description provided for @femaleDriver.
  ///
  /// In en, this message translates to:
  /// **'Female Driver'**
  String get femaleDriver;

  /// No description provided for @femaleDriverFullTitle.
  ///
  /// In en, this message translates to:
  /// **'Female Driver'**
  String get femaleDriverFullTitle;

  /// No description provided for @specialNeeds.
  ///
  /// In en, this message translates to:
  /// **'Special Needs'**
  String get specialNeeds;

  /// No description provided for @specialNeedsFullTitle.
  ///
  /// In en, this message translates to:
  /// **'People of Determination'**
  String get specialNeedsFullTitle;

  /// No description provided for @earlyBooking.
  ///
  /// In en, this message translates to:
  /// **'Early Booking'**
  String get earlyBooking;

  /// No description provided for @earlyBookingFullTitle.
  ///
  /// In en, this message translates to:
  /// **'Early Booking (Scheduled)'**
  String get earlyBookingFullTitle;

  /// No description provided for @driverByHour.
  ///
  /// In en, this message translates to:
  /// **'Driver by Hour'**
  String get driverByHour;

  /// No description provided for @driverByHourFullTitle.
  ///
  /// In en, this message translates to:
  /// **'Driver by the Hour'**
  String get driverByHourFullTitle;

  /// No description provided for @intercityTrip.
  ///
  /// In en, this message translates to:
  /// **'Intercity Trip'**
  String get intercityTrip;

  /// No description provided for @intercityTripFullTitle.
  ///
  /// In en, this message translates to:
  /// **'Intercity Trip'**
  String get intercityTripFullTitle;

  /// No description provided for @carReservationDescription.
  ///
  /// In en, this message translates to:
  /// **'Book your car easily and safely with the best drivers'**
  String get carReservationDescription;

  /// No description provided for @multipleDestinationsDescription.
  ///
  /// In en, this message translates to:
  /// **'Travel to multiple destinations in one trip'**
  String get multipleDestinationsDescription;

  /// No description provided for @roundTripDescription.
  ///
  /// In en, this message translates to:
  /// **'Round trip with the best prices'**
  String get roundTripDescription;

  /// No description provided for @femaleDriverDescription.
  ///
  /// In en, this message translates to:
  /// **'Professional female drivers for more comfort'**
  String get femaleDriverDescription;

  /// No description provided for @specialNeedsDescription.
  ///
  /// In en, this message translates to:
  /// **'Specialized service for people with special needs'**
  String get specialNeedsDescription;

  /// No description provided for @earlyBookingDescription.
  ///
  /// In en, this message translates to:
  /// **'Book in advance and save more'**
  String get earlyBookingDescription;

  /// No description provided for @driverByHourDescription.
  ///
  /// In en, this message translates to:
  /// **'Rent a driver by the hour according to your needs'**
  String get driverByHourDescription;

  /// No description provided for @intercityTripDescription.
  ///
  /// In en, this message translates to:
  /// **'Comfortable travel between cities'**
  String get intercityTripDescription;

  /// No description provided for @carReservationFeature1.
  ///
  /// In en, this message translates to:
  /// **'A comfortable daily transportation solution that meets your needs.'**
  String get carReservationFeature1;

  /// No description provided for @carReservationFeature2.
  ///
  /// In en, this message translates to:
  /// **'Booking options: instant for immediate travel, or scheduled for a specific time.'**
  String get carReservationFeature2;

  /// No description provided for @carReservationFeature3.
  ///
  /// In en, this message translates to:
  /// **'Choose trip style: individual for complete privacy, or shared to reduce cost.'**
  String get carReservationFeature3;

  /// No description provided for @carReservationFeature4.
  ///
  /// In en, this message translates to:
  /// **'Choose the driver: you can select your preferred driver or let the system assign the nearest available driver.'**
  String get carReservationFeature4;

  /// No description provided for @carReservationFeature5.
  ///
  /// In en, this message translates to:
  /// **'Choose car type: select from several car options that suit your needs.'**
  String get carReservationFeature5;

  /// No description provided for @multipleDestinationsFeature1.
  ///
  /// In en, this message translates to:
  /// **'Multiple destinations in one trip'**
  String get multipleDestinationsFeature1;

  /// No description provided for @multipleDestinationsFeature2.
  ///
  /// In en, this message translates to:
  /// **'Optimized route planning'**
  String get multipleDestinationsFeature2;

  /// No description provided for @multipleDestinationsFeature3.
  ///
  /// In en, this message translates to:
  /// **'Save time and cost'**
  String get multipleDestinationsFeature3;

  /// No description provided for @roundTripFeature1.
  ///
  /// In en, this message translates to:
  /// **'Select destinations: choose your departure and return locations.'**
  String get roundTripFeature1;

  /// No description provided for @roundTripFeature2.
  ///
  /// In en, this message translates to:
  /// **'Choose return time: set the time or duration before the return trip.'**
  String get roundTripFeature2;

  /// No description provided for @roundTripFeature3.
  ///
  /// In en, this message translates to:
  /// **'Trip type: individual or shared.'**
  String get roundTripFeature3;

  /// No description provided for @roundTripFeature4.
  ///
  /// In en, this message translates to:
  /// **'Advance notification: notification before the return trip to confirm booking'**
  String get roundTripFeature4;

  /// No description provided for @femaleDriverFeature1.
  ///
  /// In en, this message translates to:
  /// **'Certified drivers: all female drivers are licensed and verified.'**
  String get femaleDriverFeature1;

  /// No description provided for @femaleDriverFeature2.
  ///
  /// In en, this message translates to:
  /// **'Vehicle options: choose the car suitable for your trip.'**
  String get femaleDriverFeature2;

  /// No description provided for @femaleDriverFeature3.
  ///
  /// In en, this message translates to:
  /// **'Timing options: instant or scheduled booking available.'**
  String get femaleDriverFeature3;

  /// No description provided for @femaleDriverFeature4.
  ///
  /// In en, this message translates to:
  /// **'Comfort and privacy: service designed specifically for women.'**
  String get femaleDriverFeature4;

  /// No description provided for @specialNeedsFeature1.
  ///
  /// In en, this message translates to:
  /// **'Custom vehicles: equipped with lifts and ramps for wheelchairs.'**
  String get specialNeedsFeature1;

  /// No description provided for @specialNeedsFeature2.
  ///
  /// In en, this message translates to:
  /// **'Trained drivers: for professional and respectful handling.'**
  String get specialNeedsFeature2;

  /// No description provided for @specialNeedsFeature3.
  ///
  /// In en, this message translates to:
  /// **'Booking options: instant or scheduled according to passenger needs.'**
  String get specialNeedsFeature3;

  /// No description provided for @specialNeedsFeature4.
  ///
  /// In en, this message translates to:
  /// **'Comfort and safety: a smooth and humane transportation experience from start to finish.'**
  String get specialNeedsFeature4;

  /// No description provided for @earlyBookingFeature1.
  ///
  /// In en, this message translates to:
  /// **'Choose time: easily select the date and time that suits you.'**
  String get earlyBookingFeature1;

  /// No description provided for @earlyBookingFeature2.
  ///
  /// In en, this message translates to:
  /// **'Advance confirmation: the driver is notified of the trip before the scheduled time to confirm availability.'**
  String get earlyBookingFeature2;

  /// No description provided for @earlyBookingFeature3.
  ///
  /// In en, this message translates to:
  /// **'Automatic alert: you receive a notification before the trip time to confirm readiness.'**
  String get earlyBookingFeature3;

  /// No description provided for @earlyBookingFeature4.
  ///
  /// In en, this message translates to:
  /// **'Guaranteed comfort: scheduled trips ensure departure at the specified time without delay.'**
  String get earlyBookingFeature4;

  /// No description provided for @driverByHourFeature1.
  ///
  /// In en, this message translates to:
  /// **'Enjoy hourly driver service for multiple trips and flexible stops.'**
  String get driverByHourFeature1;

  /// No description provided for @driverByHourFeature2.
  ///
  /// In en, this message translates to:
  /// **'Booking options: instant for immediate departure, or scheduled for a specific time.'**
  String get driverByHourFeature2;

  /// No description provided for @driverByHourFeature3.
  ///
  /// In en, this message translates to:
  /// **'Trip styles: individual for complete freedom, or shared to save cost.'**
  String get driverByHourFeature3;

  /// No description provided for @driverByHourFeature4.
  ///
  /// In en, this message translates to:
  /// **'Choose the driver: you can select your preferred driver or let the system assign the nearest available driver.'**
  String get driverByHourFeature4;

  /// No description provided for @driverByHourFeature5.
  ///
  /// In en, this message translates to:
  /// **'Choose car type: select from several car options that suit your needs.'**
  String get driverByHourFeature5;

  /// No description provided for @intercityTripFeature1.
  ///
  /// In en, this message translates to:
  /// **'Select destination: choose the city you want to travel to.'**
  String get intercityTripFeature1;

  /// No description provided for @intercityTripFeature2.
  ///
  /// In en, this message translates to:
  /// **'Choose time: set the date and time suitable for departure.'**
  String get intercityTripFeature2;

  /// No description provided for @intercityTripFeature3.
  ///
  /// In en, this message translates to:
  /// **'Specify number of passengers: enter the number of male and female passengers to provide a suitable car.'**
  String get intercityTripFeature3;

  /// No description provided for @intercityTripFeature4.
  ///
  /// In en, this message translates to:
  /// **'Choose the driver: you can select your preferred driver or let the system assign the nearest available driver.'**
  String get intercityTripFeature4;

  /// No description provided for @intercityTripFeature5.
  ///
  /// In en, this message translates to:
  /// **'Choose car type: select from several car options that suit your needs.'**
  String get intercityTripFeature5;

  /// No description provided for @services.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get services;

  /// No description provided for @bookNow.
  ///
  /// In en, this message translates to:
  /// **'Book Your Trip Now'**
  String get bookNow;

  /// No description provided for @myTrips.
  ///
  /// In en, this message translates to:
  /// **'My Trips'**
  String get myTrips;

  /// No description provided for @tripStatus.
  ///
  /// In en, this message translates to:
  /// **'Trip Status'**
  String get tripStatus;

  /// No description provided for @fullTripsWithDiscount.
  ///
  /// In en, this message translates to:
  /// **'Full Trips with Discount'**
  String get fullTripsWithDiscount;

  /// No description provided for @immediate.
  ///
  /// In en, this message translates to:
  /// **'Immediate'**
  String get immediate;

  /// No description provided for @searchInProgress.
  ///
  /// In en, this message translates to:
  /// **'Searching in progress'**
  String get searchInProgress;

  /// No description provided for @myAddresses.
  ///
  /// In en, this message translates to:
  /// **'My Addresses'**
  String get myAddresses;

  /// No description provided for @promotionalOffers.
  ///
  /// In en, this message translates to:
  /// **'Promotional Offers'**
  String get promotionalOffers;

  /// No description provided for @shareApp.
  ///
  /// In en, this message translates to:
  /// **'Share App'**
  String get shareApp;

  /// No description provided for @wallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get wallet;

  /// No description provided for @drawerInbox.
  ///
  /// In en, this message translates to:
  /// **'Inbox'**
  String get drawerInbox;

  /// No description provided for @drawerInviteFriends.
  ///
  /// In en, this message translates to:
  /// **'Invite Friends'**
  String get drawerInviteFriends;

  /// No description provided for @drawerOpportunities.
  ///
  /// In en, this message translates to:
  /// **'Opportunities'**
  String get drawerOpportunities;

  /// No description provided for @noOpportunitiesFound.
  ///
  /// In en, this message translates to:
  /// **'No opportunities found at the moment. Check back later for new opportunities.'**
  String get noOpportunitiesFound;

  /// No description provided for @drawerEarnings.
  ///
  /// In en, this message translates to:
  /// **'Earnings'**
  String get drawerEarnings;

  /// No description provided for @drawerUberPro.
  ///
  /// In en, this message translates to:
  /// **'Uber Pro'**
  String get drawerUberPro;

  /// No description provided for @drawerAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get drawerAccount;

  /// No description provided for @drawerTips.
  ///
  /// In en, this message translates to:
  /// **'Tips'**
  String get drawerTips;

  /// No description provided for @driverStatusActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get driverStatusActive;

  /// No description provided for @driverStatusPendingVerification.
  ///
  /// In en, this message translates to:
  /// **'Pending Verification'**
  String get driverStatusPendingVerification;

  /// No description provided for @driverStatusPendingApproval.
  ///
  /// In en, this message translates to:
  /// **'Pending Approval'**
  String get driverStatusPendingApproval;

  /// No description provided for @driverStatusProfileIncomplete.
  ///
  /// In en, this message translates to:
  /// **'Profile Incomplete'**
  String get driverStatusProfileIncomplete;

  /// No description provided for @driverStatusDocumentsRejected.
  ///
  /// In en, this message translates to:
  /// **'Documents Rejected'**
  String get driverStatusDocumentsRejected;

  /// No description provided for @driverStatusSuspended.
  ///
  /// In en, this message translates to:
  /// **'Suspended'**
  String get driverStatusSuspended;

  /// No description provided for @driverStatusInactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get driverStatusInactive;

  /// No description provided for @cash.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get cash;

  /// No description provided for @onlinePayment.
  ///
  /// In en, this message translates to:
  /// **'Online Payment'**
  String get onlinePayment;

  /// No description provided for @selectPaymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Select Payment Method'**
  String get selectPaymentMethod;

  /// No description provided for @help.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get help;

  /// No description provided for @appLanguage.
  ///
  /// In en, this message translates to:
  /// **'App Language'**
  String get appLanguage;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// Welcome greeting with user name
  ///
  /// In en, this message translates to:
  /// **'Hello {firstName} 👋'**
  String welcomeGreeting(String firstName);

  /// Welcome message on the Home screen
  ///
  /// In en, this message translates to:
  /// **'Welcome {firstName}'**
  String pageHomeTitle(String firstName);

  /// No description provided for @suggestions.
  ///
  /// In en, this message translates to:
  /// **'Suggestions'**
  String get suggestions;

  /// No description provided for @profileCompletedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Profile completed successfully'**
  String get profileCompletedSuccessfully;

  /// No description provided for @positionTheCardWithinTheFrame.
  ///
  /// In en, this message translates to:
  /// **'Position the card within the frame'**
  String get positionTheCardWithinTheFrame;

  /// No description provided for @vehicleCategoryDescription.
  ///
  /// In en, this message translates to:
  /// **'If the car is private, select number(1) and if the car is taxi, select number(2)'**
  String get vehicleCategoryDescription;

  /// No description provided for @captureCarPhotos.
  ///
  /// In en, this message translates to:
  /// **'Capture Car Photos'**
  String get captureCarPhotos;

  /// No description provided for @takePhotoOf.
  ///
  /// In en, this message translates to:
  /// **'Take a photo of'**
  String get takePhotoOf;

  /// No description provided for @capturePhoto.
  ///
  /// In en, this message translates to:
  /// **'Capture Photo'**
  String get capturePhoto;

  /// No description provided for @onlyOriginalDocumentsAccepted.
  ///
  /// In en, this message translates to:
  /// **'Only original documents are accepted. Temporary driving licenses or photos will not be accepted.'**
  String get onlyOriginalDocumentsAccepted;

  /// No description provided for @onlySaudiDriversCanJoin.
  ///
  /// In en, this message translates to:
  /// **'Only Saudi drivers / sons of female citizens can join'**
  String get onlySaudiDriversCanJoin;

  /// No description provided for @requiredDocuments.
  ///
  /// In en, this message translates to:
  /// **'Required Documents:'**
  String get requiredDocuments;

  /// No description provided for @avoidUnclearPhotos.
  ///
  /// In en, this message translates to:
  /// **'Avoid uploading unclear, poorly lit, or cropped photos.'**
  String get avoidUnclearPhotos;

  /// No description provided for @licenseMustBeValidForOneYear.
  ///
  /// In en, this message translates to:
  /// **'The license must be valid for at least one year.'**
  String get licenseMustBeValidForOneYear;

  /// No description provided for @delayWillAffectAccountActivation.
  ///
  /// In en, this message translates to:
  /// **'If there is a delay, it will affect your account activation.'**
  String get delayWillAffectAccountActivation;

  /// No description provided for @learnMoreInformation.
  ///
  /// In en, this message translates to:
  /// **'Learn more information'**
  String get learnMoreInformation;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get or;

  /// No description provided for @changeThemeDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose the theme that suits you'**
  String get changeThemeDescription;

  /// No description provided for @chooseDestination.
  ///
  /// In en, this message translates to:
  /// **'Choose Destination'**
  String get chooseDestination;

  /// No description provided for @reserveNow.
  ///
  /// In en, this message translates to:
  /// **'Reserve Now'**
  String get reserveNow;

  /// No description provided for @reserveLater.
  ///
  /// In en, this message translates to:
  /// **'Reserve Later'**
  String get reserveLater;

  /// No description provided for @confirmMeetingPoint.
  ///
  /// In en, this message translates to:
  /// **'Confirm Meeting Point'**
  String get confirmMeetingPoint;

  /// No description provided for @selectMeetingPoint.
  ///
  /// In en, this message translates to:
  /// **'Select Meeting Point on the map'**
  String get selectMeetingPoint;

  /// No description provided for @confirmMeetingPointDescription.
  ///
  /// In en, this message translates to:
  /// **'Confirm Meeting Point'**
  String get confirmMeetingPointDescription;

  /// No description provided for @selectDestination.
  ///
  /// In en, this message translates to:
  /// **'Select Destination'**
  String get selectDestination;

  /// No description provided for @selectDestinationOnMap.
  ///
  /// In en, this message translates to:
  /// **'Select Destination on the map'**
  String get selectDestinationOnMap;

  /// No description provided for @toWhereHint.
  ///
  /// In en, this message translates to:
  /// **'To where?'**
  String get toWhereHint;

  /// No description provided for @fromWhere.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get fromWhere;

  /// No description provided for @addAnotherDestination.
  ///
  /// In en, this message translates to:
  /// **'Add Another Destination'**
  String get addAnotherDestination;

  /// No description provided for @returnToCurrentLocation.
  ///
  /// In en, this message translates to:
  /// **'Return to Your Current Location'**
  String get returnToCurrentLocation;

  /// No description provided for @favoriteDriver.
  ///
  /// In en, this message translates to:
  /// **'Favorite Driver'**
  String get favoriteDriver;

  /// No description provided for @vehicleTypeBroadcast.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Type'**
  String get vehicleTypeBroadcast;

  /// No description provided for @chooseYourFavoriteDriver.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Favorite Driver'**
  String get chooseYourFavoriteDriver;

  /// No description provided for @chooseYourCar.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Car'**
  String get chooseYourCar;

  /// Seats for passengers
  ///
  /// In en, this message translates to:
  /// **'Seats {count} passengers'**
  String seatsFor(int count);

  /// No description provided for @minutes.
  ///
  /// In en, this message translates to:
  /// **'min'**
  String get minutes;

  /// No description provided for @pm.
  ///
  /// In en, this message translates to:
  /// **'PM'**
  String get pm;

  /// No description provided for @tripCreatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Trip created successfully'**
  String get tripCreatedSuccessfully;

  /// No description provided for @ratingSubmittedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Thank you for your rating!'**
  String get ratingSubmittedSuccessfully;

  /// No description provided for @commentOptional.
  ///
  /// In en, this message translates to:
  /// **'Comment (optional)'**
  String get commentOptional;

  /// No description provided for @pleaseSelectBookingType.
  ///
  /// In en, this message translates to:
  /// **'Please select booking type'**
  String get pleaseSelectBookingType;

  /// No description provided for @pleaseSelectDestination.
  ///
  /// In en, this message translates to:
  /// **'Please select destination'**
  String get pleaseSelectDestination;

  /// No description provided for @pleaseSelectAtLeastTwoDestinations.
  ///
  /// In en, this message translates to:
  /// **'Please select at least two destinations'**
  String get pleaseSelectAtLeastTwoDestinations;

  /// No description provided for @selectTripDate.
  ///
  /// In en, this message translates to:
  /// **'Select trip date'**
  String get selectTripDate;

  /// No description provided for @selectTripTime.
  ///
  /// In en, this message translates to:
  /// **'Select trip time'**
  String get selectTripTime;

  /// No description provided for @pleaseSelectDateAndTime.
  ///
  /// In en, this message translates to:
  /// **'Please select date and time for scheduled trip'**
  String get pleaseSelectDateAndTime;

  /// No description provided for @pleaseSelectFutureDateAndTime.
  ///
  /// In en, this message translates to:
  /// **'Please select a future date and time'**
  String get pleaseSelectFutureDateAndTime;

  /// No description provided for @safety.
  ///
  /// In en, this message translates to:
  /// **'Safety'**
  String get safety;

  /// No description provided for @safetyToolsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tools for maintaining safety'**
  String get safetyToolsSubtitle;

  /// No description provided for @proofOfTripStatus.
  ///
  /// In en, this message translates to:
  /// **'Proof of trip status'**
  String get proofOfTripStatus;

  /// No description provided for @assistance999.
  ///
  /// In en, this message translates to:
  /// **'999 Assistance'**
  String get assistance999;

  /// No description provided for @verifyUsingPin.
  ///
  /// In en, this message translates to:
  /// **'Verify using PIN'**
  String get verifyUsingPin;

  /// No description provided for @trackMyTrip.
  ///
  /// In en, this message translates to:
  /// **'Track my trip'**
  String get trackMyTrip;

  /// No description provided for @setSafetyPreferences.
  ///
  /// In en, this message translates to:
  /// **'Set Safety Preferences'**
  String get setSafetyPreferences;

  /// No description provided for @setSafetyPreferencesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your favorite safety tools and schedule them'**
  String get setSafetyPreferencesSubtitle;

  /// No description provided for @emergencyNumber999.
  ///
  /// In en, this message translates to:
  /// **'Emergency Number 999'**
  String get emergencyNumber999;

  /// No description provided for @emergencyNumber999Description.
  ///
  /// In en, this message translates to:
  /// **'You must share your location details and vehicle information with 999'**
  String get emergencyNumber999Description;

  /// No description provided for @estimatedLocation.
  ///
  /// In en, this message translates to:
  /// **'Estimated Location'**
  String get estimatedLocation;

  /// No description provided for @locationBeingUpdated.
  ///
  /// In en, this message translates to:
  /// **'Location is being updated'**
  String get locationBeingUpdated;

  /// No description provided for @swipeToCall999.
  ///
  /// In en, this message translates to:
  /// **'Swipe to call 999'**
  String get swipeToCall999;

  /// No description provided for @searchingForCaptain.
  ///
  /// In en, this message translates to:
  /// **'Searching for captain ...'**
  String get searchingForCaptain;

  /// No description provided for @tripDetails.
  ///
  /// In en, this message translates to:
  /// **'Trip Details'**
  String get tripDetails;

  /// No description provided for @pickupLocation.
  ///
  /// In en, this message translates to:
  /// **'Pickup location'**
  String get pickupLocation;

  /// No description provided for @destination.
  ///
  /// In en, this message translates to:
  /// **'Destination'**
  String get destination;

  /// No description provided for @waypoint.
  ///
  /// In en, this message translates to:
  /// **'Waypoint'**
  String get waypoint;

  /// No description provided for @myPreviousTrips.
  ///
  /// In en, this message translates to:
  /// **'My Previous Trips'**
  String get myPreviousTrips;

  /// No description provided for @myCurrentTrips.
  ///
  /// In en, this message translates to:
  /// **'My Current Trips'**
  String get myCurrentTrips;

  /// No description provided for @searchByTripNumber.
  ///
  /// In en, this message translates to:
  /// **'Search by trip number'**
  String get searchByTripNumber;

  /// No description provided for @tripNumber.
  ///
  /// In en, this message translates to:
  /// **'Trip No.'**
  String get tripNumber;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @tripType.
  ///
  /// In en, this message translates to:
  /// **'Trip Type'**
  String get tripType;

  /// No description provided for @estimatedPrice.
  ///
  /// In en, this message translates to:
  /// **'Estimated Price'**
  String get estimatedPrice;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @cancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelled;

  /// No description provided for @touristTrip.
  ///
  /// In en, this message translates to:
  /// **'Tourist Trip'**
  String get touristTrip;

  /// No description provided for @regularTrip.
  ///
  /// In en, this message translates to:
  /// **'Regular Trip'**
  String get regularTrip;

  /// No description provided for @individual.
  ///
  /// In en, this message translates to:
  /// **'Individual'**
  String get individual;

  /// No description provided for @scheduled.
  ///
  /// In en, this message translates to:
  /// **'Scheduled'**
  String get scheduled;

  /// No description provided for @searchingForDriver.
  ///
  /// In en, this message translates to:
  /// **'Searching for Driver'**
  String get searchingForDriver;

  /// No description provided for @waitingForDriverApproval.
  ///
  /// In en, this message translates to:
  /// **'Waiting for Driver Approval'**
  String get waitingForDriverApproval;

  /// No description provided for @accepted.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get accepted;

  /// No description provided for @current.
  ///
  /// In en, this message translates to:
  /// **'Current'**
  String get current;

  /// No description provided for @driverEnRoute.
  ///
  /// In en, this message translates to:
  /// **'Driver En Route'**
  String get driverEnRoute;

  /// No description provided for @driverArrived.
  ///
  /// In en, this message translates to:
  /// **'Driver Arrived'**
  String get driverArrived;

  /// No description provided for @inProgress.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get inProgress;

  /// No description provided for @expired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get expired;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @dateRange.
  ///
  /// In en, this message translates to:
  /// **'Date Range'**
  String get dateRange;

  /// No description provided for @fromDate.
  ///
  /// In en, this message translates to:
  /// **'From Date'**
  String get fromDate;

  /// No description provided for @toDate.
  ///
  /// In en, this message translates to:
  /// **'To Date'**
  String get toDate;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @bookingType.
  ///
  /// In en, this message translates to:
  /// **'Booking Type'**
  String get bookingType;

  /// No description provided for @noDataFound.
  ///
  /// In en, this message translates to:
  /// **'No Data Found'**
  String get noDataFound;

  /// No description provided for @cancelledByClient.
  ///
  /// In en, this message translates to:
  /// **'Cancelled by Client'**
  String get cancelledByClient;

  /// No description provided for @cancelledByDriver.
  ///
  /// In en, this message translates to:
  /// **'Cancelled by Driver'**
  String get cancelledByDriver;

  /// No description provided for @cancelledBySystem.
  ///
  /// In en, this message translates to:
  /// **'Cancelled by System'**
  String get cancelledBySystem;

  /// No description provided for @pendingDriverAcceptance.
  ///
  /// In en, this message translates to:
  /// **'Pending Driver Acceptance'**
  String get pendingDriverAcceptance;

  /// No description provided for @driverDetails.
  ///
  /// In en, this message translates to:
  /// **'Driver Details'**
  String get driverDetails;

  /// No description provided for @clientDetails.
  ///
  /// In en, this message translates to:
  /// **'Client Details'**
  String get clientDetails;

  /// No description provided for @chatWithDriver.
  ///
  /// In en, this message translates to:
  /// **'Chat with Driver'**
  String get chatWithDriver;

  /// No description provided for @chatWithClient.
  ///
  /// In en, this message translates to:
  /// **'Chat with Client'**
  String get chatWithClient;

  /// No description provided for @licensePlateNumber.
  ///
  /// In en, this message translates to:
  /// **'License Plate Number'**
  String get licensePlateNumber;

  /// No description provided for @orderDetails.
  ///
  /// In en, this message translates to:
  /// **'Order Details'**
  String get orderDetails;

  /// No description provided for @orderNumber.
  ///
  /// In en, this message translates to:
  /// **'Order Number'**
  String get orderNumber;

  /// No description provided for @orderTime.
  ///
  /// In en, this message translates to:
  /// **'Order Time'**
  String get orderTime;

  /// No description provided for @orderStatus.
  ///
  /// In en, this message translates to:
  /// **'Order Status'**
  String get orderStatus;

  /// No description provided for @tripTime.
  ///
  /// In en, this message translates to:
  /// **'Trip Time'**
  String get tripTime;

  /// No description provided for @tripDuration.
  ///
  /// In en, this message translates to:
  /// **'Trip Duration'**
  String get tripDuration;

  /// No description provided for @priceAndPaymentDetails.
  ///
  /// In en, this message translates to:
  /// **'Price and Payment Details'**
  String get priceAndPaymentDetails;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @discounts.
  ///
  /// In en, this message translates to:
  /// **'Discounts'**
  String get discounts;

  /// No description provided for @tax.
  ///
  /// In en, this message translates to:
  /// **'Tax'**
  String get tax;

  /// No description provided for @fines.
  ///
  /// In en, this message translates to:
  /// **'Fines'**
  String get fines;

  /// No description provided for @fineReason.
  ///
  /// In en, this message translates to:
  /// **'Fine Reason'**
  String get fineReason;

  /// No description provided for @totalPrice.
  ///
  /// In en, this message translates to:
  /// **'Total Price'**
  String get totalPrice;

  /// No description provided for @rateTrip.
  ///
  /// In en, this message translates to:
  /// **'Rate Trip'**
  String get rateTrip;

  /// No description provided for @downloadInvoicePdf.
  ///
  /// In en, this message translates to:
  /// **'Download Invoice PDF'**
  String get downloadInvoicePdf;

  /// No description provided for @km.
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get km;

  /// No description provided for @manageTrip.
  ///
  /// In en, this message translates to:
  /// **'Manage Trip'**
  String get manageTrip;

  /// No description provided for @shareTrip.
  ///
  /// In en, this message translates to:
  /// **'Share Trip'**
  String get shareTrip;

  /// No description provided for @getSupport.
  ///
  /// In en, this message translates to:
  /// **'Get Support'**
  String get getSupport;

  /// No description provided for @cancelTrip.
  ///
  /// In en, this message translates to:
  /// **'Cancel Trip'**
  String get cancelTrip;

  /// No description provided for @cancelTripConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to cancel this trip?'**
  String get cancelTripConfirmation;

  /// No description provided for @cancelTripReason.
  ///
  /// In en, this message translates to:
  /// **'Cancellation Reason'**
  String get cancelTripReason;

  /// No description provided for @enterCancelReason.
  ///
  /// In en, this message translates to:
  /// **'Please enter cancellation reason'**
  String get enterCancelReason;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @startTrip.
  ///
  /// In en, this message translates to:
  /// **'Start Trip'**
  String get startTrip;

  /// No description provided for @arrivedToPickupLocation.
  ///
  /// In en, this message translates to:
  /// **'Arrived to Pickup Location'**
  String get arrivedToPickupLocation;

  /// No description provided for @completeTrip.
  ///
  /// In en, this message translates to:
  /// **'Complete Trip'**
  String get completeTrip;

  /// No description provided for @unableToSwitchToConnectionMode.
  ///
  /// In en, this message translates to:
  /// **'Unable to switch to connection mode'**
  String get unableToSwitchToConnectionMode;

  /// No description provided for @tripAcceptedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Trip accepted successfully'**
  String get tripAcceptedSuccessfully;

  /// No description provided for @tripRejectedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Trip rejected successfully'**
  String get tripRejectedSuccessfully;

  /// No description provided for @accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get accept;

  /// No description provided for @reject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get reject;

  /// No description provided for @unknownError.
  ///
  /// In en, this message translates to:
  /// **'Unknown error'**
  String get unknownError;

  /// No description provided for @walletChargeBalance.
  ///
  /// In en, this message translates to:
  /// **'Charge Balance'**
  String get walletChargeBalance;

  /// No description provided for @chargeBalanceSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Fast and secure charging for your balance to use at any time.'**
  String get chargeBalanceSubtitle;

  /// No description provided for @amountValue.
  ///
  /// In en, this message translates to:
  /// **'Amount Value'**
  String get amountValue;

  /// No description provided for @enterAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter amount'**
  String get enterAmount;

  /// No description provided for @transactionLog.
  ///
  /// In en, this message translates to:
  /// **'Transaction Log'**
  String get transactionLog;

  /// No description provided for @searchByTripOrTransactionRef.
  ///
  /// In en, this message translates to:
  /// **'Search using trip/transaction reference..'**
  String get searchByTripOrTransactionRef;

  /// No description provided for @filterByStatus.
  ///
  /// In en, this message translates to:
  /// **'Filter by Status'**
  String get filterByStatus;

  /// No description provided for @filterByType.
  ///
  /// In en, this message translates to:
  /// **'Filter by Transaction Type'**
  String get filterByType;

  /// No description provided for @filterByDate.
  ///
  /// In en, this message translates to:
  /// **'Filter by Transaction Date'**
  String get filterByDate;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @successful.
  ///
  /// In en, this message translates to:
  /// **'Successful'**
  String get successful;

  /// No description provided for @walletCharge.
  ///
  /// In en, this message translates to:
  /// **'Wallet Charge'**
  String get walletCharge;

  /// No description provided for @refund.
  ///
  /// In en, this message translates to:
  /// **'Refund'**
  String get refund;

  /// No description provided for @coupon.
  ///
  /// In en, this message translates to:
  /// **'Coupon'**
  String get coupon;

  /// No description provided for @fine.
  ///
  /// In en, this message translates to:
  /// **'Fine'**
  String get fine;

  /// No description provided for @discount.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get discount;

  /// No description provided for @tripPayment.
  ///
  /// In en, this message translates to:
  /// **'Trip Payment'**
  String get tripPayment;

  /// No description provided for @tripRefund.
  ///
  /// In en, this message translates to:
  /// **'Trip Refund'**
  String get tripRefund;

  /// No description provided for @adminAdjustment.
  ///
  /// In en, this message translates to:
  /// **'Admin Adjustment'**
  String get adminAdjustment;

  /// No description provided for @tripEarnings.
  ///
  /// In en, this message translates to:
  /// **'Trip Earnings'**
  String get tripEarnings;

  /// No description provided for @withdrawal.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal'**
  String get withdrawal;

  /// No description provided for @penalty.
  ///
  /// In en, this message translates to:
  /// **'Penalty'**
  String get penalty;

  /// No description provided for @chargeSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Your balance has been successfully charged!'**
  String get chargeSuccessMessage;

  /// No description provided for @transactionType.
  ///
  /// In en, this message translates to:
  /// **'Transaction Type'**
  String get transactionType;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @transactionDate.
  ///
  /// In en, this message translates to:
  /// **'Transaction Date'**
  String get transactionDate;

  /// No description provided for @tripOrTransactionRef.
  ///
  /// In en, this message translates to:
  /// **'Trip / Transaction Reference'**
  String get tripOrTransactionRef;

  /// No description provided for @rewards.
  ///
  /// In en, this message translates to:
  /// **'Rewards'**
  String get rewards;

  /// No description provided for @availableBalance.
  ///
  /// In en, this message translates to:
  /// **'Available Balance'**
  String get availableBalance;

  /// No description provided for @selectTransactionDate.
  ///
  /// In en, this message translates to:
  /// **'Select transaction date...'**
  String get selectTransactionDate;

  /// No description provided for @noTransactions.
  ///
  /// In en, this message translates to:
  /// **'No transactions yet'**
  String get noTransactions;

  /// No description provided for @suggestionsForYou.
  ///
  /// In en, this message translates to:
  /// **'Suggestions for you'**
  String get suggestionsForYou;

  /// No description provided for @filterByCarServiceType.
  ///
  /// In en, this message translates to:
  /// **'Filter by car service type'**
  String get filterByCarServiceType;

  /// No description provided for @filterByTripServiceType.
  ///
  /// In en, this message translates to:
  /// **'Filter by trip service type'**
  String get filterByTripServiceType;

  /// No description provided for @applyDiscountOrShare.
  ///
  /// In en, this message translates to:
  /// **'Apply discount or share profits at a rate of x2'**
  String get applyDiscountOrShare;

  /// No description provided for @filterByPreferredDistricts.
  ///
  /// In en, this message translates to:
  /// **'Filter by preferred districts'**
  String get filterByPreferredDistricts;

  /// No description provided for @preferredDistrictsDescription.
  ///
  /// In en, this message translates to:
  /// **'Get trips that start in the areas you choose and end there. For up to 2 hours daily.'**
  String get preferredDistrictsDescription;

  /// No description provided for @filterByYouthRequests.
  ///
  /// In en, this message translates to:
  /// **'Filter by youth requests'**
  String get filterByYouthRequests;

  /// No description provided for @enabledForTrips.
  ///
  /// In en, this message translates to:
  /// **'Enabled for trips'**
  String get enabledForTrips;

  /// No description provided for @filterByCashTrips.
  ///
  /// In en, this message translates to:
  /// **'Filter by cash trips'**
  String get filterByCashTrips;

  /// No description provided for @cashTripsDescription.
  ///
  /// In en, this message translates to:
  /// **'The first two trips at the beginning of the day will be cash for only 3 hours, and then a new day starts and other payment methods are activated.'**
  String get cashTripsDescription;

  /// No description provided for @individualWithinCity.
  ///
  /// In en, this message translates to:
  /// **'Individual within city'**
  String get individualWithinCity;

  /// No description provided for @sharedWithinCity.
  ///
  /// In en, this message translates to:
  /// **'Shared within city'**
  String get sharedWithinCity;

  /// No description provided for @individualBetweenCities.
  ///
  /// In en, this message translates to:
  /// **'Individual between cities'**
  String get individualBetweenCities;

  /// No description provided for @sharedBetweenCities.
  ///
  /// In en, this message translates to:
  /// **'Shared between cities'**
  String get sharedBetweenCities;

  /// No description provided for @selectPreferredDistricts.
  ///
  /// In en, this message translates to:
  /// **'Select preferred districts'**
  String get selectPreferredDistricts;

  /// No description provided for @disabled.
  ///
  /// In en, this message translates to:
  /// **'Disabled'**
  String get disabled;

  /// No description provided for @vehicleMovementPermit.
  ///
  /// In en, this message translates to:
  /// **'How to obtain a vehicle movement permit from government authorities'**
  String get vehicleMovementPermit;

  /// No description provided for @vehicleMovementPermitSteps.
  ///
  /// In en, this message translates to:
  /// **'The following steps are shown'**
  String get vehicleMovementPermitSteps;

  /// No description provided for @findACar.
  ///
  /// In en, this message translates to:
  /// **'Find a car'**
  String get findACar;

  /// No description provided for @driverPhoto.
  ///
  /// In en, this message translates to:
  /// **'Driver photo'**
  String get driverPhoto;

  /// No description provided for @documentValidLessThanDays.
  ///
  /// In en, this message translates to:
  /// **'Valid for less than {days} days'**
  String documentValidLessThanDays(Object days);

  /// No description provided for @requiredActions.
  ///
  /// In en, this message translates to:
  /// **'Required Actions'**
  String get requiredActions;

  /// No description provided for @switchToConnectionMode.
  ///
  /// In en, this message translates to:
  /// **'Switch to connection mode'**
  String get switchToConnectionMode;

  /// No description provided for @yourRating.
  ///
  /// In en, this message translates to:
  /// **'Your Rating'**
  String get yourRating;

  /// No description provided for @rating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get rating;

  /// No description provided for @comment.
  ///
  /// In en, this message translates to:
  /// **'Comment'**
  String get comment;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @ratingTime.
  ///
  /// In en, this message translates to:
  /// **'Rating Time'**
  String get ratingTime;

  /// No description provided for @noRequiredActions.
  ///
  /// In en, this message translates to:
  /// **'No required actions'**
  String get noRequiredActions;

  /// No description provided for @shareYourExperience.
  ///
  /// In en, this message translates to:
  /// **'Share your experience'**
  String get shareYourExperience;

  /// No description provided for @callUs.
  ///
  /// In en, this message translates to:
  /// **'Call us'**
  String get callUs;

  /// No description provided for @currentBalance.
  ///
  /// In en, this message translates to:
  /// **'Current Balance'**
  String get currentBalance;

  /// No description provided for @aiSupported.
  ///
  /// In en, this message translates to:
  /// **'AI supported'**
  String get aiSupported;

  /// No description provided for @betaVersion.
  ///
  /// In en, this message translates to:
  /// **'Beta Version'**
  String get betaVersion;

  /// No description provided for @requestAdjustment.
  ///
  /// In en, this message translates to:
  /// **'Request Adjustment'**
  String get requestAdjustment;

  /// No description provided for @fillBankAccountInformation.
  ///
  /// In en, this message translates to:
  /// **'Please fill in bank account information'**
  String get fillBankAccountInformation;

  /// No description provided for @incomeTransferMethod.
  ///
  /// In en, this message translates to:
  /// **'Income transfer method - weekly to account******'**
  String get incomeTransferMethod;

  /// No description provided for @payments.
  ///
  /// In en, this message translates to:
  /// **'Payments'**
  String get payments;

  /// No description provided for @bankAccount.
  ///
  /// In en, this message translates to:
  /// **'Bank Account:'**
  String get bankAccount;

  /// No description provided for @earningsCollectedWeekly.
  ///
  /// In en, this message translates to:
  /// **'Earnings are collected weekly'**
  String get earningsCollectedWeekly;

  /// No description provided for @paymentScheduleDescription.
  ///
  /// In en, this message translates to:
  /// **'The wage week starts on Monday at 4:00 PM until the following Monday at 4:00 PM.\n\nWages for the week will be issued during that period.\n\nIssuing wages may require a longer period at the end of each month due to bank delays.'**
  String get paymentScheduleDescription;

  /// No description provided for @requestAdjustmentSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Request a settlement for your earnings. Enter the amount you wish to withdraw.'**
  String get requestAdjustmentSubtitle;

  /// No description provided for @requestAdjustmentSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Settlement request submitted successfully!'**
  String get requestAdjustmentSuccessMessage;

  /// No description provided for @emergencyCallDescription.
  ///
  /// In en, this message translates to:
  /// **'Select one of the emergency actions below, and we will contact you and share your location immediately.'**
  String get emergencyCallDescription;

  /// No description provided for @emergencyCall.
  ///
  /// In en, this message translates to:
  /// **'Emergency Call'**
  String get emergencyCall;

  /// No description provided for @emergencyCall1.
  ///
  /// In en, this message translates to:
  /// **'Call the police'**
  String get emergencyCall1;

  /// No description provided for @emergencyCall2.
  ///
  /// In en, this message translates to:
  /// **'Call the fire department'**
  String get emergencyCall2;

  /// No description provided for @emergencyCall3.
  ///
  /// In en, this message translates to:
  /// **'Call the ambulance'**
  String get emergencyCall3;

  /// No description provided for @emergencyCall4.
  ///
  /// In en, this message translates to:
  /// **'Call the traffic police'**
  String get emergencyCall4;

  /// No description provided for @contactNubmers.
  ///
  /// In en, this message translates to:
  /// **'Contact numbers'**
  String get contactNubmers;

  /// No description provided for @whatsapp.
  ///
  /// In en, this message translates to:
  /// **'Whatsapp'**
  String get whatsapp;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @events.
  ///
  /// In en, this message translates to:
  /// **'Events'**
  String get events;

  /// Date of income transfer
  ///
  /// In en, this message translates to:
  /// **'Income transfer date: {date}'**
  String incomeTransferDate(String date);

  /// No description provided for @reservations.
  ///
  /// In en, this message translates to:
  /// **'Reservations'**
  String get reservations;

  /// No description provided for @offers.
  ///
  /// In en, this message translates to:
  /// **'Promotional Offers'**
  String get offers;

  /// No description provided for @rateTripDescription.
  ///
  /// In en, this message translates to:
  /// **'Rate the driver and service to ensure the best experience in the future'**
  String get rateTripDescription;

  /// No description provided for @weWillNotifyYouWhenYouCanMakeTrips.
  ///
  /// In en, this message translates to:
  /// **'We will notify you when you can make trips'**
  String get weWillNotifyYouWhenYouCanMakeTrips;

  /// No description provided for @requiredActionsDescription.
  ///
  /// In en, this message translates to:
  /// **'The requirements that the driver partner must fulfill'**
  String get requiredActionsDescription;

  /// Direct chat with the user
  ///
  /// In en, this message translates to:
  /// **'Direct chat with {name}'**
  String directChatWith(String name);

  /// No description provided for @driver.
  ///
  /// In en, this message translates to:
  /// **'Driver'**
  String get driver;

  /// No description provided for @private.
  ///
  /// In en, this message translates to:
  /// **'Private'**
  String get private;

  /// No description provided for @taxi.
  ///
  /// In en, this message translates to:
  /// **'Taxi'**
  String get taxi;

  /// No description provided for @hijriMonth1.
  ///
  /// In en, this message translates to:
  /// **'Muharram'**
  String get hijriMonth1;

  /// No description provided for @hijriMonth2.
  ///
  /// In en, this message translates to:
  /// **'Safar'**
  String get hijriMonth2;

  /// No description provided for @hijriMonth3.
  ///
  /// In en, this message translates to:
  /// **'Rabi\' al-Awwal'**
  String get hijriMonth3;

  /// No description provided for @hijriMonth4.
  ///
  /// In en, this message translates to:
  /// **'Rabi\' al-Thani'**
  String get hijriMonth4;

  /// No description provided for @hijriMonth5.
  ///
  /// In en, this message translates to:
  /// **'Jumada al-Awwal'**
  String get hijriMonth5;

  /// No description provided for @hijriMonth6.
  ///
  /// In en, this message translates to:
  /// **'Jumada al-Thani'**
  String get hijriMonth6;

  /// No description provided for @hijriMonth7.
  ///
  /// In en, this message translates to:
  /// **'Rajab'**
  String get hijriMonth7;

  /// No description provided for @hijriMonth8.
  ///
  /// In en, this message translates to:
  /// **'Sha\'ban'**
  String get hijriMonth8;

  /// No description provided for @hijriMonth9.
  ///
  /// In en, this message translates to:
  /// **'Ramadan'**
  String get hijriMonth9;

  /// No description provided for @hijriMonth10.
  ///
  /// In en, this message translates to:
  /// **'Shawwal'**
  String get hijriMonth10;

  /// No description provided for @hijriMonth11.
  ///
  /// In en, this message translates to:
  /// **'Dhu al-Qi\'dah'**
  String get hijriMonth11;

  /// No description provided for @hijriMonth12.
  ///
  /// In en, this message translates to:
  /// **'Dhu al-Hijjah'**
  String get hijriMonth12;

  /// No description provided for @incomeDirections.
  ///
  /// In en, this message translates to:
  /// **'Income Directions'**
  String get incomeDirections;

  /// No description provided for @incomeDirectionsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'How and when your earnings are transferred to you'**
  String get incomeDirectionsSubtitle;

  /// No description provided for @incomeTransferMethodTitle.
  ///
  /// In en, this message translates to:
  /// **'Transfer method'**
  String get incomeTransferMethodTitle;

  /// No description provided for @incomeTransferDateTitle.
  ///
  /// In en, this message translates to:
  /// **'Transfer date'**
  String get incomeTransferDateTitle;

  /// No description provided for @incomeTransferDateDescription.
  ///
  /// In en, this message translates to:
  /// **'View when your next transfer is scheduled'**
  String get incomeTransferDateDescription;

  /// No description provided for @hourlyDirections.
  ///
  /// In en, this message translates to:
  /// **'Hourly Directions'**
  String get hourlyDirections;

  /// No description provided for @hourlyDirectionsDescription.
  ///
  /// In en, this message translates to:
  /// **'The colors display the data in real time while the gray color displays the previous data'**
  String get hourlyDirectionsDescription;

  /// No description provided for @navigateToConnectionMode.
  ///
  /// In en, this message translates to:
  /// **'Navigate to connection mode'**
  String get navigateToConnectionMode;

  /// No description provided for @selectWaypoint.
  ///
  /// In en, this message translates to:
  /// **'Select Waypoint on the map'**
  String get selectWaypoint;

  /// No description provided for @addressNotAvailableForNavigation.
  ///
  /// In en, this message translates to:
  /// **'Address not available for navigation'**
  String get addressNotAvailableForNavigation;

  /// No description provided for @locationUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Location unavailable'**
  String get locationUnavailable;

  /// No description provided for @unableToLoadRoute.
  ///
  /// In en, this message translates to:
  /// **'Unable to load route'**
  String get unableToLoadRoute;

  /// No description provided for @tripNoLongerActive.
  ///
  /// In en, this message translates to:
  /// **'This trip is no longer active'**
  String get tripNoLongerActive;

  /// No description provided for @eta.
  ///
  /// In en, this message translates to:
  /// **'ETA'**
  String get eta;

  /// No description provided for @trackTrip.
  ///
  /// In en, this message translates to:
  /// **'Track trip'**
  String get trackTrip;

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello!'**
  String get hello;

  /// No description provided for @uniqueCode.
  ///
  /// In en, this message translates to:
  /// **'Unique Code'**
  String get uniqueCode;

  /// No description provided for @copy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copy;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @userDiscount.
  ///
  /// In en, this message translates to:
  /// **'User Discount'**
  String get userDiscount;

  /// No description provided for @marketerDiscountPercentage.
  ///
  /// In en, this message translates to:
  /// **'Marketer Discount Percentage'**
  String get marketerDiscountPercentage;

  /// No description provided for @codeValidityFrom.
  ///
  /// In en, this message translates to:
  /// **'Code Validity From:'**
  String get codeValidityFrom;

  /// No description provided for @codeValidityTo.
  ///
  /// In en, this message translates to:
  /// **'Code Validity To:'**
  String get codeValidityTo;
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
      <String>['ar', 'en', 'ur'].contains(locale.languageCode);

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
    case 'ur':
      return AppLocalizationsUr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

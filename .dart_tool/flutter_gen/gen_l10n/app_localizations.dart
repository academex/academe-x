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
/// import 'gen_l10n/app_localizations.dart';
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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'AcademeX'**
  String get appTitle;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginTitle;

  /// No description provided for @loginSubTitle.
  ///
  /// In en, this message translates to:
  /// **'Please enter your information to log in to the world of knowledge and learning.'**
  String get loginSubTitle;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email or username'**
  String get emailLabel;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'Enter email address'**
  String get emailHint;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter password'**
  String get passwordHint;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMe;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginButton;

  /// No description provided for @orLoginWith.
  ///
  /// In en, this message translates to:
  /// **'Or login using'**
  String get orLoginWith;

  /// No description provided for @googleAccount.
  ///
  /// In en, this message translates to:
  /// **'Google Account'**
  String get googleAccount;

  /// No description provided for @noAccount.
  ///
  /// In en, this message translates to:
  /// **'Don’t have an account?'**
  String get noAccount;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @already_have_account.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get already_have_account;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPasswordTitle;

  /// No description provided for @forgotPasswordSubTitle.
  ///
  /// In en, this message translates to:
  /// **'Don’t worry! that happens. Please specify your email or phone number so we can send you a code.'**
  String get forgotPasswordSubTitle;

  /// No description provided for @emailOption.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailOption;

  /// No description provided for @emailDescription.
  ///
  /// In en, this message translates to:
  /// **'Email address: '**
  String get emailDescription;

  /// No description provided for @phoneOption.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneOption;

  /// No description provided for @phoneDescription.
  ///
  /// In en, this message translates to:
  /// **'Phone number: '**
  String get phoneDescription;

  /// No description provided for @confirmationButton.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirmationButton;

  /// No description provided for @verificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Verification Code'**
  String get verificationTitle;

  /// No description provided for @verificationSubTitle.
  ///
  /// In en, this message translates to:
  /// **'Please enter the verification code sent to your email:'**
  String get verificationSubTitle;

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get resendCode;

  /// No description provided for @newPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPasswordTitle;

  /// No description provided for @newPasswordSubTitle.
  ///
  /// In en, this message translates to:
  /// **'The new password must be different from your previous password.'**
  String get newPasswordSubTitle;

  /// No description provided for @newPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPasswordLabel;

  /// No description provided for @confirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPasswordLabel;

  /// No description provided for @passwordRequirement1.
  ///
  /// In en, this message translates to:
  /// **'Your password must be'**
  String get passwordRequirement1;

  /// No description provided for @passwordMinimumChars.
  ///
  /// In en, this message translates to:
  /// **'at least 8 characters'**
  String get passwordMinimumChars;

  /// No description provided for @passwordRequirement2.
  ///
  /// In en, this message translates to:
  /// **'containing some words and phrases to make it more secure.\"'**
  String get passwordRequirement2;

  /// No description provided for @robotIntroTitle.
  ///
  /// In en, this message translates to:
  /// **'Hello, I\'m the Smart Robot'**
  String get robotIntroTitle;

  /// No description provided for @robotIntroSubTitle.
  ///
  /// In en, this message translates to:
  /// **'I\'ll help you create accounts and prepare your data with great options and levels.'**
  String get robotIntroSubTitle;

  /// No description provided for @startButton.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get startButton;

  /// No description provided for @createAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google Account'**
  String get createAccountTitle;

  /// No description provided for @orCreateAccount.
  ///
  /// In en, this message translates to:
  /// **'or Create my Account'**
  String get orCreateAccount;

  /// No description provided for @accountPreparationMessage.
  ///
  /// In en, this message translates to:
  /// **'Preparing your account will take a few seconds!'**
  String get accountPreparationMessage;

  /// No description provided for @personalData.
  ///
  /// In en, this message translates to:
  /// **'Personal Data'**
  String get personalData;

  /// No description provided for @educationalLevel.
  ///
  /// In en, this message translates to:
  /// **'Educational Level'**
  String get educationalLevel;

  /// No description provided for @nameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nameLabel;

  /// No description provided for @nameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get nameHint;

  /// No description provided for @collegeLabel.
  ///
  /// In en, this message translates to:
  /// **'College'**
  String get collegeLabel;

  /// No description provided for @currentYearLabel.
  ///
  /// In en, this message translates to:
  /// **'Current Study Year'**
  String get currentYearLabel;

  /// No description provided for @semesterLabel.
  ///
  /// In en, this message translates to:
  /// **'Study Semester'**
  String get semesterLabel;

  /// No description provided for @createAccountButton.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccountButton;

  /// No description provided for @accountCreationLoadingTitle.
  ///
  /// In en, this message translates to:
  /// **'Creating Your Account'**
  String get accountCreationLoadingTitle;

  /// No description provided for @accountCreationLoadingSubTitle.
  ///
  /// In en, this message translates to:
  /// **'Your account and library are being prepared based on your level'**
  String get accountCreationLoadingSubTitle;

  /// No description provided for @accountCreationSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Account Created Successfully!'**
  String get accountCreationSuccessTitle;

  /// No description provided for @accountCreationSuccessSubTitle.
  ///
  /// In en, this message translates to:
  /// **'Your account has been set up successfully.'**
  String get accountCreationSuccessSubTitle;

  /// No description provided for @redirectIn.
  ///
  /// In en, this message translates to:
  /// **'Redirecting to the main page in '**
  String get redirectIn;

  /// No description provided for @seconds.
  ///
  /// In en, this message translates to:
  /// **'seconds'**
  String get seconds;

  /// No description provided for @goToMainPage.
  ///
  /// In en, this message translates to:
  /// **'Go to Main Page'**
  String get goToMainPage;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @onboarding_title_1.
  ///
  /// In en, this message translates to:
  /// **'Academy Chat: AI-powered assistant for students'**
  String get onboarding_title_1;

  /// No description provided for @onboarding_title_2.
  ///
  /// In en, this message translates to:
  /// **'A dedicated community for each college for questions and help'**
  String get onboarding_title_2;

  /// No description provided for @onboarding_title_3.
  ///
  /// In en, this message translates to:
  /// **'Comprehensive library of educational materials, summaries, and videos'**
  String get onboarding_title_3;

  /// No description provided for @onboarding_desc_1.
  ///
  /// In en, this message translates to:
  /// **'The Academy Chat answers all academic questions, summarizes files, and generates educational questions.'**
  String get onboarding_desc_1;

  /// No description provided for @onboarding_desc_2.
  ///
  /// In en, this message translates to:
  /// **'A space for college students to discuss, ask questions, conduct polls, and share the latest university news.'**
  String get onboarding_desc_2;

  /// No description provided for @onboarding_desc_3.
  ///
  /// In en, this message translates to:
  /// **'An electronic library containing study materials and summaries for all subjects.'**
  String get onboarding_desc_3;

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @start_now.
  ///
  /// In en, this message translates to:
  /// **'Start Now'**
  String get start_now;

  /// No description provided for @terms_and_conditions.
  ///
  /// In en, this message translates to:
  /// **'Using the app implies agreement to our'**
  String get terms_and_conditions;

  /// No description provided for @privacy_policy.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service and Privacy Policy'**
  String get privacy_policy;

  /// No description provided for @privacy_policy_suffix.
  ///
  /// In en, this message translates to:
  /// **'.'**
  String get privacy_policy_suffix;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}

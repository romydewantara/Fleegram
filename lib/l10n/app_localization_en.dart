// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localization.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Fleegram';

  @override
  String get loading => 'Processing...';

  @override
  String get errorGeneric => 'Oops, something went wrong';

  @override
  String get retry => 'Try again';

  @override
  String get cancel => 'Cancel';

  @override
  String get submit => 'Submit';

  @override
  String get save => 'Save';

  @override
  String get loginTitle => 'Login';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get loginButton => 'Login';

  @override
  String get loginFailed => 'Incorrect email or password. Please try again.';

  @override
  String get emptyEmailField => 'Email field must not be empty.';

  @override
  String get emptyPasswordField => 'Password must not be empty.';

  @override
  String get wrongEmailFormat =>
      'The email format is invalid. Please check again.';

  @override
  String get passwordLength => 'Password must be at least 8 characters.';

  @override
  String get emailNotRegistered =>
      'This email is not registered yet. Please sign up first.';

  @override
  String get emailAlreadyRegistered =>
      'This email is already registered. Please use another email.';

  @override
  String get wrongPassword =>
      'The password you entered is incorrect. Please try again.';

  @override
  String get noAccount => 'Don\'t have an account?';

  @override
  String get goToRegister => 'Sign up';

  @override
  String get registerTitle => 'Create New Account';

  @override
  String get nameLabel => 'Name';

  @override
  String get registerButton => 'Register';

  @override
  String get registerLoading => 'Creating account...';

  @override
  String get registerFailed => 'Registration failed. Please try again shortly.';

  @override
  String get emailAlreadyUsed =>
      'This email is already in use. Please try another one.';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get goToLogin => 'Login';

  @override
  String get emptyNameField => 'Name field must not be empty.';

  @override
  String get storyListTitle => 'Latest Stories';

  @override
  String get emptyStory => 'No stories available yet.';

  @override
  String get loadMore => 'Loading more stories...';

  @override
  String get storyDetailTitle => 'Story Details';

  @override
  String get locationLabel => 'Location';

  @override
  String get latitude => 'Latitude';

  @override
  String get longitude => 'Longitude';

  @override
  String get imageLoadError => 'Failed to load image';

  @override
  String get postStoryTitle => 'Add Story';

  @override
  String get descriptionLabel => 'Tell your story here';

  @override
  String get pickImage => 'Select image';

  @override
  String get cropImage => 'Crop image';

  @override
  String get noImage => 'No image selected';

  @override
  String get takePhoto => 'Take photo';

  @override
  String get camera => 'Camera';

  @override
  String get gallery => 'Gallery';

  @override
  String get uploadButton => 'Upload';

  @override
  String get uploading => 'Uploading...';

  @override
  String get uploadSuccess =>
      'Hooray! Your story has been uploaded successfully.';

  @override
  String get uploadFailed =>
      'Oops, failed to upload the story. Please try again.';

  @override
  String get imageAndDescriptionRequired =>
      'Please select an image and write a description.';

  @override
  String get settingTitle => 'Settings';

  @override
  String get preferences => 'Preferences';

  @override
  String get theme => 'Theme';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeSystem => 'System';

  @override
  String get language => 'Language';

  @override
  String get languageId => 'Indonesian';

  @override
  String get languageEn => 'English';

  @override
  String get account => 'Account';

  @override
  String get logout => 'Logout Confirmation';

  @override
  String get logoutButton => 'Logout';

  @override
  String get logoutConfirm => 'Are you sure you want to log out?';

  @override
  String get sessionExpired => 'Your session has expired. Please log in again.';

  @override
  String get userInformation =>
      'The name shown here is for viewing only and cannot be edited. This feature helps reviewers easily identify information such as the email or the account in use.';

  @override
  String get prefInformation =>
      'Here you can view and adjust your app preferences, such as the current theme and language, so your app experience matches your preference.';

  @override
  String get errorNetwork =>
      'You are not connected to the internet. Please check your connection and try again.';

  @override
  String get dateFormatFull => 'MMMM d, y';
}

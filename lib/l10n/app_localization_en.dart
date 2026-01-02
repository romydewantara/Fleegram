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
  String get loading => 'Processing, please wait...';

  @override
  String get errorGeneric => 'Oops, something went wrong';

  @override
  String get open => 'Go';

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
  String get confirmPasswordLabel => 'Confirm Password';

  @override
  String get loginButton => 'Login';

  @override
  String get loginFailed => 'Incorrect email or password. Please try again.';

  @override
  String get emptyEmailField => 'Email field must not be empty.';

  @override
  String get emptyPasswordField => 'Password field must not be empty.';

  @override
  String get emptyConfirmPasswordField =>
      'Confirm Password field must not be empty.';

  @override
  String get wrongEmailFormat => 'The email format is invalid.';

  @override
  String get passwordLength => 'Password must be at least 8 characters.';

  @override
  String get confirmPasswordNotMatch =>
      'Confirm Password must match the Password.';

  @override
  String get emailNotRegistered =>
      'This email is not registered yet. Please sign up first.';

  @override
  String get emailAlreadyRegistered =>
      'This email has already been registered. Please use another email.';

  @override
  String get wrongPassword =>
      'The password you entered is incorrect. Please try again.';

  @override
  String get noAccount => 'Don’t have an account?';

  @override
  String get goToRegister => 'Sign up';

  @override
  String get registerTitle => 'Create New Account';

  @override
  String get nameLabel => 'Name';

  @override
  String get registerButton => 'Register';

  @override
  String get registerLoading => 'Creating your account...';

  @override
  String get registerFailed => 'Registration failed. Please try again shortly.';

  @override
  String get registerWrongEmailFormat =>
      'The email format is invalid. Please check and try again.';

  @override
  String get registerSuccess =>
      'Yay! Your account has been successfully created. Please log in now!';

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
  String get timeJustNow => 'Just now';

  @override
  String timeMinutes(Object count) {
    return '${count}m';
  }

  @override
  String timeHours(Object count) {
    return '${count}h';
  }

  @override
  String get timeYesterday => 'Yesterday';

  @override
  String timeDays(Object count) {
    return '${count}d';
  }

  @override
  String timeWeeks(Object count) {
    return '${count}w';
  }

  @override
  String get postStoryTitle => 'New Story';

  @override
  String get descriptionLabel => 'Tell your story here...';

  @override
  String get pickImage => 'Choose image';

  @override
  String get cropImage => 'Crop image';

  @override
  String get noImage => 'Tap to add an image';

  @override
  String get selectSource => 'Select Image Source';

  @override
  String get sourceOption =>
      'Choose an image from your gallery or take a new photo with the camera.';

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
      'Hooray! Your story has been successfully uploaded.';

  @override
  String get uploadFailed =>
      'Oops, failed to upload your story. Please try again.';

  @override
  String get imageAndDescriptionRequired =>
      'Please select an image and fill in the story description.';

  @override
  String get addLocation => 'Add Location';

  @override
  String get locationServiceDisabled => 'Enable GPS to use location features';

  @override
  String get locationPermissionDenied =>
      'Location permission is required to display your position';

  @override
  String get locationPermissionDeniedForever =>
      'Location permission is permanently denied. Enable it from settings.';

  @override
  String get errorLocationUnknown => 'Unable to retrieve current location';

  @override
  String get readMore => ' more';

  @override
  String get readLess => ' less';

  @override
  String get loadAddress => 'Loading address...';

  @override
  String get failedToOpenMaps => 'Failed to open Google Maps';

  @override
  String get cityNotAvailable => 'City not available';

  @override
  String get mapPreview => 'Map preview';

  @override
  String get markerSelected => 'Your story will show up here';

  @override
  String get useLocation => 'Use this Location';

  @override
  String get enableLocation => 'Enable location';

  @override
  String get infoLocationService =>
      'Location service is disabled. Please enable GPS in Settings to use this feature.';

  @override
  String get locationDenied => 'Location permission denied';

  @override
  String get locationPermanentlyDenied =>
      'Location permission permanently denied. Enable it from settings.';

  @override
  String get locationFailed => 'Failed to get current location';

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
  String get logout => 'Confirm Logout';

  @override
  String get logoutButton => 'Logout';

  @override
  String get logoutConfirm =>
      'Are you sure you want to log out from your account?';

  @override
  String get sessionExpired => 'Your session has expired. Please log in again.';

  @override
  String get userInformation =>
      'The name and email displayed here are read-only and cannot be changed. This feature is provided to help developers easily identify information such as the email or the currently used account.';

  @override
  String get prefInformation =>
      'Here you can view and adjust application preferences, such as theme and language, to customize your experience.';

  @override
  String get errorNetworkTitle => 'Oops, Connection Problem';

  @override
  String get errorNetwork =>
      'You are not connected to the internet. Please check your connection and try again.';

  @override
  String get dateFormatFull => 'MMMM d, y';

  @override
  String get copyright => '© 2026 Fleegram';

  @override
  String get developedBy => 'Developed by';

  @override
  String get developerName => 'Romy';

  @override
  String get version => 'v1.1.0 – 2512312339';
}

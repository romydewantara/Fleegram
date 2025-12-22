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
  String get loading => 'Hang tight...';

  @override
  String get errorGeneric => 'Oops, Something went wrong';

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
  String get loginFailed => 'Email or password is incorrect. Please try again.';

  @override
  String get emptyEmailField => 'Email field cannot be empty.';

  @override
  String get emptyPasswordField => 'Password field cannot be empty.';

  @override
  String get wrongEmailFormat =>
      'Email format is not valid, please check it again please.';

  @override
  String get passwordLength => 'Masukin password minimal 8 karakter.';

  @override
  String get emailNotRegistered =>
      'This email isn\'t registered yet. Try a different one.';

  @override
  String get emailAlreadyRegistered =>
      'Email ini udah pernah terdaftar. Coba pakai email lain ya.';

  @override
  String get wrongPassword =>
      'That password doesn’t look right. Try another one.';

  @override
  String get noAccount => 'Don’t have an account?';

  @override
  String get goToRegister => 'Sign up';

  @override
  String get registerTitle => 'Create Account';

  @override
  String get nameLabel => 'Name';

  @override
  String get registerButton => 'Register';

  @override
  String get registerLoading => 'Creating your account...';

  @override
  String get registerFailed => 'Registration failed. Please try again.';

  @override
  String get emailAlreadyUsed =>
      'This email is already in use. Try another one.';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get goToLogin => 'Login';

  @override
  String get emptyNameField => 'Kolom Nama harus diisi.';

  @override
  String get storyListTitle => 'Stories';

  @override
  String get emptyStory => 'No stories available';

  @override
  String get loadMore => 'Loading more stories...';

  @override
  String get storyDetailTitle => 'Story Detail';

  @override
  String get locationLabel => 'Location';

  @override
  String get latitude => 'Latitude';

  @override
  String get longitude => 'Longitude';

  @override
  String get imageLoadError => 'Image failed to load';

  @override
  String get postStoryTitle => 'Add Story';

  @override
  String get descriptionLabel => 'Tell your story here';

  @override
  String get pickImage => 'Choose image';

  @override
  String get cropImage => 'Crop gambar';

  @override
  String get noImage => 'Belum ada gambar';

  @override
  String get takePhoto => 'Take photo';

  @override
  String get camera => 'Kamera';

  @override
  String get gallery => 'Galeri';

  @override
  String get uploadButton => 'Upload';

  @override
  String get uploading => 'Uploading...';

  @override
  String get uploadSuccess => 'Yay! Your story has been uploaded 🎉';

  @override
  String get uploadFailed =>
      'Oops, failed to upload your story. Please try again.';

  @override
  String get imageAndDescriptionRequired =>
      'Please add an image and write something first.';

  @override
  String get logout => 'Confirm Logout';

  @override
  String get logoutButton => 'Keluar';

  @override
  String get logoutConfirm => 'Are you sure you want to log out?';

  @override
  String get sessionExpired => 'Your session has expired. Please log in again.';

  @override
  String get errorNetwork =>
      'Kamu lagi nggak terhubung ke internet. Coba cek koneksi kamu, lalu ulangi lagi ya.';

  @override
  String get dateFormatFull => 'MMMM d, y';
}

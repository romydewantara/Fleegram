import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localization_en.dart';
import 'app_localization_id.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localization.dart';
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

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
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
    Locale('en'),
    Locale('id'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In id, this message translates to:
  /// **'Fleegram'**
  String get appTitle;

  /// No description provided for @loading.
  ///
  /// In id, this message translates to:
  /// **'Lagi diproses ya...'**
  String get loading;

  /// No description provided for @errorGeneric.
  ///
  /// In id, this message translates to:
  /// **'Ups, ada yang bermasalah'**
  String get errorGeneric;

  /// No description provided for @retry.
  ///
  /// In id, this message translates to:
  /// **'Coba lagi'**
  String get retry;

  /// No description provided for @cancel.
  ///
  /// In id, this message translates to:
  /// **'Batal'**
  String get cancel;

  /// No description provided for @submit.
  ///
  /// In id, this message translates to:
  /// **'Kirim'**
  String get submit;

  /// No description provided for @save.
  ///
  /// In id, this message translates to:
  /// **'Simpan'**
  String get save;

  /// No description provided for @loginTitle.
  ///
  /// In id, this message translates to:
  /// **'Masuk'**
  String get loginTitle;

  /// No description provided for @emailLabel.
  ///
  /// In id, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In id, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @loginButton.
  ///
  /// In id, this message translates to:
  /// **'Masuk'**
  String get loginButton;

  /// No description provided for @loginFailed.
  ///
  /// In id, this message translates to:
  /// **'Email atau password salah. Coba lagi ya.'**
  String get loginFailed;

  /// No description provided for @emptyEmailField.
  ///
  /// In id, this message translates to:
  /// **'Kolom Email harus diisi.'**
  String get emptyEmailField;

  /// No description provided for @emptyPasswordField.
  ///
  /// In id, this message translates to:
  /// **'Password ga boleh kosong.'**
  String get emptyPasswordField;

  /// No description provided for @wrongEmailFormat.
  ///
  /// In id, this message translates to:
  /// **'Format Email yang kamu masukin ga valid. Coba periksa lagi ya.'**
  String get wrongEmailFormat;

  /// No description provided for @passwordLength.
  ///
  /// In id, this message translates to:
  /// **'Masukin password minimal 8 karakter.'**
  String get passwordLength;

  /// No description provided for @emailNotRegistered.
  ///
  /// In id, this message translates to:
  /// **'Email ini belum terdaftar. Coba daftarin dulu yuk!'**
  String get emailNotRegistered;

  /// No description provided for @emailAlreadyRegistered.
  ///
  /// In id, this message translates to:
  /// **'Email ini udah pernah terdaftar. Coba pakai email lain ya.'**
  String get emailAlreadyRegistered;

  /// No description provided for @wrongPassword.
  ///
  /// In id, this message translates to:
  /// **'Yah, password yang kamu masukin masih salah. Coba lagi ya.'**
  String get wrongPassword;

  /// No description provided for @noAccount.
  ///
  /// In id, this message translates to:
  /// **'Belum punya akun?'**
  String get noAccount;

  /// No description provided for @goToRegister.
  ///
  /// In id, this message translates to:
  /// **'Daftar dulu'**
  String get goToRegister;

  /// No description provided for @registerTitle.
  ///
  /// In id, this message translates to:
  /// **'Daftar Akun Baru'**
  String get registerTitle;

  /// No description provided for @nameLabel.
  ///
  /// In id, this message translates to:
  /// **'Nama'**
  String get nameLabel;

  /// No description provided for @registerButton.
  ///
  /// In id, this message translates to:
  /// **'Daftar'**
  String get registerButton;

  /// No description provided for @registerLoading.
  ///
  /// In id, this message translates to:
  /// **'Sedang membuat akun...'**
  String get registerLoading;

  /// No description provided for @registerFailed.
  ///
  /// In id, this message translates to:
  /// **'Pendaftaran gagal. Coba lagi sebentar ya.'**
  String get registerFailed;

  /// No description provided for @emailAlreadyUsed.
  ///
  /// In id, this message translates to:
  /// **'Email ini sudah dipakai. Coba email yang lain ya.'**
  String get emailAlreadyUsed;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In id, this message translates to:
  /// **'Sudah punya akun?'**
  String get alreadyHaveAccount;

  /// No description provided for @goToLogin.
  ///
  /// In id, this message translates to:
  /// **'Masuk aja'**
  String get goToLogin;

  /// No description provided for @emptyNameField.
  ///
  /// In id, this message translates to:
  /// **'Kolom Nama harus diisi.'**
  String get emptyNameField;

  /// No description provided for @storyListTitle.
  ///
  /// In id, this message translates to:
  /// **'Cerita Terbaru'**
  String get storyListTitle;

  /// No description provided for @emptyStory.
  ///
  /// In id, this message translates to:
  /// **'Belum ada cerita nih.'**
  String get emptyStory;

  /// No description provided for @loadMore.
  ///
  /// In id, this message translates to:
  /// **'Lagi ambil cerita lainnya...'**
  String get loadMore;

  /// No description provided for @storyDetailTitle.
  ///
  /// In id, this message translates to:
  /// **'Detail Cerita'**
  String get storyDetailTitle;

  /// No description provided for @locationLabel.
  ///
  /// In id, this message translates to:
  /// **'Lokasi'**
  String get locationLabel;

  /// No description provided for @latitude.
  ///
  /// In id, this message translates to:
  /// **'Lintang'**
  String get latitude;

  /// No description provided for @longitude.
  ///
  /// In id, this message translates to:
  /// **'Bujur'**
  String get longitude;

  /// No description provided for @imageLoadError.
  ///
  /// In id, this message translates to:
  /// **'Gambarnya gagal dimuat'**
  String get imageLoadError;

  /// No description provided for @postStoryTitle.
  ///
  /// In id, this message translates to:
  /// **'Tambah Cerita'**
  String get postStoryTitle;

  /// No description provided for @descriptionLabel.
  ///
  /// In id, this message translates to:
  /// **'Ceritain sedikit di sini'**
  String get descriptionLabel;

  /// No description provided for @pickImage.
  ///
  /// In id, this message translates to:
  /// **'Pilih gambar'**
  String get pickImage;

  /// No description provided for @cropImage.
  ///
  /// In id, this message translates to:
  /// **'Crop gambar'**
  String get cropImage;

  /// No description provided for @noImage.
  ///
  /// In id, this message translates to:
  /// **'Belum ada gambar'**
  String get noImage;

  /// No description provided for @takePhoto.
  ///
  /// In id, this message translates to:
  /// **'Ambil foto'**
  String get takePhoto;

  /// No description provided for @camera.
  ///
  /// In id, this message translates to:
  /// **'Kamera'**
  String get camera;

  /// No description provided for @gallery.
  ///
  /// In id, this message translates to:
  /// **'Galeri'**
  String get gallery;

  /// No description provided for @uploadButton.
  ///
  /// In id, this message translates to:
  /// **'Unggah'**
  String get uploadButton;

  /// No description provided for @uploading.
  ///
  /// In id, this message translates to:
  /// **'Sedang mengunggah...'**
  String get uploading;

  /// No description provided for @uploadSuccess.
  ///
  /// In id, this message translates to:
  /// **'Hore! Ceritamu berhasil diunggah.'**
  String get uploadSuccess;

  /// No description provided for @uploadFailed.
  ///
  /// In id, this message translates to:
  /// **'Yah, ceritanya gagal diunggah. Coba lagi ya.'**
  String get uploadFailed;

  /// No description provided for @imageAndDescriptionRequired.
  ///
  /// In id, this message translates to:
  /// **'Jangan lupa pilih gambar dan isi ceritanya ya.'**
  String get imageAndDescriptionRequired;

  /// No description provided for @logout.
  ///
  /// In id, this message translates to:
  /// **'Konfirmasi Keluar'**
  String get logout;

  /// No description provided for @logoutButton.
  ///
  /// In id, this message translates to:
  /// **'Keluar'**
  String get logoutButton;

  /// No description provided for @logoutConfirm.
  ///
  /// In id, this message translates to:
  /// **'Kamu yakin mau keluar dari akunmu?'**
  String get logoutConfirm;

  /// No description provided for @sessionExpired.
  ///
  /// In id, this message translates to:
  /// **'Sesi kamu sudah habis. Yuk login lagi.'**
  String get sessionExpired;

  /// No description provided for @errorNetwork.
  ///
  /// In id, this message translates to:
  /// **'Kamu lagi nggak terhubung ke internet. Coba cek koneksi kamu, lalu ulangi lagi ya.'**
  String get errorNetwork;

  /// No description provided for @dateFormatFull.
  ///
  /// In id, this message translates to:
  /// **'d MMMM y'**
  String get dateFormatFull;
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
      <String>['en', 'id'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'id':
      return AppLocalizationsId();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

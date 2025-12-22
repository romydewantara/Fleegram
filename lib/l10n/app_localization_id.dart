// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localization.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appTitle => 'Fleegram';

  @override
  String get loading => 'Lagi diproses ya...';

  @override
  String get errorGeneric => 'Ups, ada yang bermasalah';

  @override
  String get retry => 'Coba lagi';

  @override
  String get cancel => 'Batal';

  @override
  String get submit => 'Kirim';

  @override
  String get save => 'Simpan';

  @override
  String get loginTitle => 'Masuk';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get loginButton => 'Masuk';

  @override
  String get loginFailed => 'Email atau password salah. Coba lagi ya.';

  @override
  String get emptyEmailField => 'Kolom Email harus diisi.';

  @override
  String get emptyPasswordField => 'Password ga boleh kosong.';

  @override
  String get wrongEmailFormat =>
      'Format Email yang kamu masukin ga valid. Coba periksa lagi ya.';

  @override
  String get passwordLength => 'Masukin password minimal 8 karakter.';

  @override
  String get emailNotRegistered =>
      'Email ini belum terdaftar. Coba daftarin dulu yuk!';

  @override
  String get emailAlreadyRegistered =>
      'Email ini udah pernah terdaftar. Coba pakai email lain ya.';

  @override
  String get wrongPassword =>
      'Yah, password yang kamu masukin masih salah. Coba lagi ya.';

  @override
  String get noAccount => 'Belum punya akun?';

  @override
  String get goToRegister => 'Daftar dulu';

  @override
  String get registerTitle => 'Daftar Akun Baru';

  @override
  String get nameLabel => 'Nama';

  @override
  String get registerButton => 'Daftar';

  @override
  String get registerLoading => 'Sedang membuat akun...';

  @override
  String get registerFailed => 'Pendaftaran gagal. Coba lagi sebentar ya.';

  @override
  String get emailAlreadyUsed =>
      'Email ini sudah dipakai. Coba email yang lain ya.';

  @override
  String get alreadyHaveAccount => 'Sudah punya akun?';

  @override
  String get goToLogin => 'Masuk aja';

  @override
  String get emptyNameField => 'Kolom Nama harus diisi.';

  @override
  String get storyListTitle => 'Cerita Terbaru';

  @override
  String get emptyStory => 'Belum ada cerita nih.';

  @override
  String get loadMore => 'Lagi ambil cerita lainnya...';

  @override
  String get storyDetailTitle => 'Detail Cerita';

  @override
  String get locationLabel => 'Lokasi';

  @override
  String get latitude => 'Lintang';

  @override
  String get longitude => 'Bujur';

  @override
  String get imageLoadError => 'Gambarnya gagal dimuat';

  @override
  String get postStoryTitle => 'Tambah Cerita';

  @override
  String get descriptionLabel => 'Ceritain sedikit di sini';

  @override
  String get pickImage => 'Pilih gambar';

  @override
  String get cropImage => 'Crop gambar';

  @override
  String get noImage => 'Belum ada gambar';

  @override
  String get takePhoto => 'Ambil foto';

  @override
  String get camera => 'Kamera';

  @override
  String get gallery => 'Galeri';

  @override
  String get uploadButton => 'Unggah';

  @override
  String get uploading => 'Sedang mengunggah...';

  @override
  String get uploadSuccess => 'Hore! Ceritamu berhasil diunggah.';

  @override
  String get uploadFailed => 'Yah, ceritanya gagal diunggah. Coba lagi ya.';

  @override
  String get imageAndDescriptionRequired =>
      'Jangan lupa pilih gambar dan isi ceritanya ya.';

  @override
  String get logout => 'Konfirmasi Keluar';

  @override
  String get logoutButton => 'Keluar';

  @override
  String get logoutConfirm => 'Kamu yakin mau keluar dari akunmu?';

  @override
  String get sessionExpired => 'Sesi kamu sudah habis. Yuk login lagi.';

  @override
  String get errorNetwork =>
      'Kamu lagi nggak terhubung ke internet. Coba cek koneksi kamu, lalu ulangi lagi ya.';

  @override
  String get dateFormatFull => 'd MMMM y';
}

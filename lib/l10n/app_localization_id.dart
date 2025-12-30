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
  String get open => 'Buka';

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
  String get confirmPasswordLabel => 'Konfirmasi Password';

  @override
  String get loginButton => 'Masuk';

  @override
  String get loginFailed => 'Email atau password salah. Coba lagi ya.';

  @override
  String get emptyEmailField => 'Kolom email harus diisi.';

  @override
  String get emptyPasswordField => 'Password nggak boleh kosong.';

  @override
  String get emptyConfirmPasswordField =>
      'Konfirmasi Password nggak boleh kosong.';

  @override
  String get wrongEmailFormat => 'Format email yang kamu masukin belum valid.';

  @override
  String get passwordLength => 'Masukin password minimal 8 karakter.';

  @override
  String get confirmPasswordNotMatch =>
      'Konfirmasi Password harus sama dengan Password.';

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
  String get registerWrongEmailFormat =>
      'Format email yang kamu masukin nggak valid. Coba periksa lagi ya.';

  @override
  String get registerSuccess =>
      'Yeay! Akunmu berhasil dibuat. Yuk, login sekarang!';

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
  String get timeJustNow => 'Baru saja';

  @override
  String timeMinutes(Object count) {
    return '${count}m';
  }

  @override
  String timeHours(Object count) {
    return '${count}j';
  }

  @override
  String get timeYesterday => 'Kemarin';

  @override
  String timeDays(Object count) {
    return '${count}h';
  }

  @override
  String timeWeeks(Object count) {
    return '${count}mg';
  }

  @override
  String get postStoryTitle => 'Cerita Baru';

  @override
  String get descriptionLabel => 'Ceritain sedikit di sini...';

  @override
  String get pickImage => 'Pilih gambar';

  @override
  String get cropImage => 'Crop gambar';

  @override
  String get noImage => 'Tap disini buat nambahin gambar';

  @override
  String get selectSource => 'Mau ambil dari mana nih?';

  @override
  String get sourceOption =>
      'Pakai foto dari galeri atau ambil baru pakai kamera tinggal pilih aja ya.';

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
  String get addLocation => 'Tambahin Lokasi';

  @override
  String get locationServiceDisabled =>
      'Aktifkan GPS untuk menggunakan fitur lokasi';

  @override
  String get locationPermissionDenied =>
      'Izin lokasi diperlukan untuk menampilkan posisi';

  @override
  String get locationPermissionDeniedForever =>
      'Izin lokasi ditolak permanen. Aktifkan melalui pengaturan.';

  @override
  String get errorLocationUnknown => 'Tidak dapat mengambil lokasi saat ini';

  @override
  String get mapPreview => 'Tampilan Peta';

  @override
  String get markerSelected => 'Ceritamu nanti bakal tampil disini';

  @override
  String get useLocation => 'Pakai Lokasi yang Ini';

  @override
  String get enableLocation => 'Aktifin lokasi';

  @override
  String get infoLocationService =>
      'Layanan lokasimu masih nonaktif. Buka Pengaturan dan nyalain GPS-nya buat pakai fitur ini.';

  @override
  String get locationDenied => 'Akses lokasi ditolak';

  @override
  String get locationPermanentlyDenied =>
      'Izin lokasi mati permanen, harus diaktifin manual di pengaturan.';

  @override
  String get locationFailed => 'Yah! Gagal dapetin lokasi sekarang';

  @override
  String get settingTitle => 'Pengaturan';

  @override
  String get preferences => 'Preferensi';

  @override
  String get theme => 'Tema';

  @override
  String get themeLight => 'Terang';

  @override
  String get themeDark => 'Gelap';

  @override
  String get themeSystem => 'Sistem';

  @override
  String get language => 'Bahasa';

  @override
  String get languageId => 'Indonesian';

  @override
  String get languageEn => 'English';

  @override
  String get account => 'Akun';

  @override
  String get logout => 'Konfirmasi Keluar';

  @override
  String get logoutButton => 'Keluar';

  @override
  String get logoutConfirm => 'Kamu yakin mau keluar dari akunmu?';

  @override
  String get sessionExpired => 'Sesi kamu sudah habis. Yuk login lagi.';

  @override
  String get userInformation =>
      'Nama dan email yang ditampilkan di sini hanya read-only dan nggak bisa diubah. Fitur ini dibuat agar developer lebih mudah mengenali informasi seperti email atau akun yang sedang dipakai.';

  @override
  String get prefInformation =>
      'Di sini kamu bisa melihat dan mengubah preferensi aplikasi, misalnya tema dan bahasa yang sedang digunakan, supaya pengalaman pakai aplikasinya sesuai keinginanmu.';

  @override
  String get errorNetworkTitle => 'Ups, Koneksi Bermasalah';

  @override
  String get errorNetwork =>
      'Kamu lagi nggak terhubung ke internet. Coba cek koneksi kamu, lalu ulangi lagi ya.';

  @override
  String get dateFormatFull => 'd MMMM, y';

  @override
  String get copyright => '© 2025 Fleegram';

  @override
  String get developedBy => 'Developed by Romy';

  @override
  String get version => 'v1.1.0 – 2512312339';
}

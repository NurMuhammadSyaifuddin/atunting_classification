import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

bool isValidEmail(String email) {
  // RegExp untuk validasi format email
  final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');
  return emailRegExp.hasMatch(email);
}

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

String getFormattedDate(DateTime date) {
  final DateFormat formatter = DateFormat('dd MMMM yyyy, HH:mm:ss');
  final String formattedDate = formatter.format(date);
  return formattedDate;
}

List<List<String>> educations = [
  ["Memperoleh Gizi yang Cukup: Edukasi harus fokus pada pentingnya memperoleh makanan yang kaya akan nutrisi penting seperti protein, zat besi, vitamin A, dan asam folat. Dianjurkan untuk mengonsumsi makanan sumber protein seperti daging, ikan, kacang-kacangan, dan telur, serta buah dan sayuran yang kaya akan vitamin dan mineral.",
  "Praktik Higiene yang Baik: Menjaga kebersihan pribadi, mencuci tangan sebelum makan, dan memastikan kebersihan makanan yang dikonsumsi dapat membantu mencegah infeksi yang dapat memperburuk kondisi stunting."],
  ["Peningkatan Asupan Gizi: Edukasi harus mencakup peningkatan asupan makanan bergizi dengan memperhatikan kualitas dan kuantitas makanan. Mengonsumsi makanan yang kaya akan energi, protein, dan mikronutrien seperti biji-bijian, susu, dan produk olahan nabati dapat membantu meningkatkan pertumbuhan.",
  "Pendampingan Gizi: Mungkin perlu melibatkan profesional kesehatan seperti dokter atau ahli gizi untuk memberikan saran dan pemantauan terkait program pemulihan gizi yang sesuai."],
  ["Pemulihan Gizi yang Intensif: Edukasi harus memfokuskan pada program pemulihan gizi yang intensif dengan pengawasan dan dukungan khusus dari profesional kesehatan. Program ini mungkin mencakup terapi nutrisi terapeutik, suplemen makanan khusus, dan pemantauan yang ketat.",
  "Perawatan Medis yang Komprehensif: Penderita stunting dengan tingkat tinggi kemungkinan memiliki masalah kesehatan lainnya, seperti infeksi berulang atau gangguan hormonal. Penting untuk mendapatkan perawatan medis yang komprehensif dan pengobatan penyakit yang mendasarinya."]
];
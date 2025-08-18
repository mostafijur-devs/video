// lib/quran_model.dart

class QuranData {
  final int code;
  final String status;
  final Data data;

  QuranData({required this.code, required this.status, required this.data});

  factory QuranData.fromJson(Map<String, dynamic> json) {
    return QuranData(
      code: json['code'],
      status: json['status'],
      data: Data.fromJson(json['data']),
    );
  }
}

class Data {
  final int number;
  final List<Ayah> ayahs;
  final Map<String, Surah> surahs;
  final Edition edition;

  Data({
    required this.number,
    required this.ayahs,
    required this.surahs,
    required this.edition,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    var ayahsList = json['ayahs'] as List;
    List<Ayah> ayahs = ayahsList.map((i) => Ayah.fromJson(i)).toList();

    Map<String, Surah> surahsMap = {};
    (json['surahs'] as Map<String, dynamic>).forEach((key, value) {
      surahsMap[key] = Surah.fromJson(value);
    });

    return Data(
      number: json['number'],
      ayahs: ayahs,
      surahs: surahsMap,
      edition: Edition.fromJson(json['edition']),
    );
  }
}

class Ayah {
  final int number;
  final String text;
  final Surah surah;
  final int numberInSurah;
  final int juz;
  final int manzil;
  final int page;
  final int ruku;
  final int hizbQuarter;
  final bool sajda;

  Ayah({
    required this.number,
    required this.text,
    required this.surah,
    required this.numberInSurah,
    required this.juz,
    required this.manzil,
    required this.page,
    required this.ruku,
    required this.hizbQuarter,
    required this.sajda,
  });

  factory Ayah.fromJson(Map<String, dynamic> json) {
    return Ayah(
      number: json['number'],
      text: json['text'],
      surah: Surah.fromJson(json['surah']),
      numberInSurah: json['numberInSurah'],
      juz: json['juz'],
      manzil: json['manzil'],
      page: json['page'],
      ruku: json['ruku'],
      hizbQuarter: json['hizbQuarter'],
      sajda: json['sajda'],
    );
  }
}

class Surah {
  final int number;
  final String name;
  final String englishName;
  final String englishNameTranslation;
  final String revelationType;
  final int numberOfAyahs;

  Surah({
    required this.number,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
    required this.revelationType,
    required this.numberOfAyahs,
  });

  factory Surah.fromJson(Map<String, dynamic> json) {
    return Surah(
      number: json['number'],
      name: json['name'],
      englishName: json['englishName'],
      englishNameTranslation: json['englishNameTranslation'],
      revelationType: json['revelationType'],
      numberOfAyahs: json['numberOfAyahs'],
    );
  }
}

class Edition {
  final String identifier;
  final String language;
  final String name;
  final String englishName;
  final String format;
  final String type;
  final String direction;

  Edition({
    required this.identifier,
    required this.language,
    required this.name,
    required this.englishName,
    required this.format,
    required this.type,
    required this.direction,
  });

  factory Edition.fromJson(Map<String, dynamic> json) {
    return Edition(
      identifier: json['identifier'],
      language: json['language'],
      name: json['name'],
      englishName: json['englishName'],
      format: json['format'],
      type: json['type'],
      direction: json['direction'],
    );
  }
}
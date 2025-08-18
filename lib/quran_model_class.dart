// lib/quran_model.dart

class QuranModelClass {
  int? code;
  String? status;
  Data? data;

  QuranModelClass({this.code, this.status, this.data});

  factory QuranModelClass.fromJson(Map<String, dynamic> json) {
    return QuranModelClass(
      code: json['code'],
      status: json['status'],
      data: json['data'] != null && json['data'] is Map<String, dynamic>
          ? Data.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  // Correctly defined as a Map, as per API structure
  Map<String, Surahs>? surahs;
  Edition? edition;

  Data({this.surahs, this.edition});

  factory Data.fromJson(Map<String, dynamic> json) {
    Map<String, Surahs>? parsedSurahs;
    if (json['surahs'] != null && json['surahs'] is Map<String, dynamic>) {
      parsedSurahs = <String, Surahs>{};
      (json['surahs'] as Map<String, dynamic>).forEach((key, value) {
        if (value is Map<String, dynamic>) { // Ensure each surah value is a Map
          parsedSurahs![key] = Surahs.fromJson(value);
        }
      });
    }
    return Data(
      surahs: parsedSurahs,
      edition: json['edition'] != null && json['edition'] is Map<String, dynamic>
          ? Edition.fromJson(json['edition'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (surahs != null) {
      data['surahs'] = surahs!.map((key, value) => MapEntry(key, value.toJson()));
    }
    if (edition != null) {
      data['edition'] = edition!.toJson();
    }
    return data;
  }
}

class Surahs {
  int? number;
  String? name;
  String? englishName;
  String? englishNameTranslation;
  String? revelationType;
  List<Ayahs>? ayahs;

  Surahs({
    this.number,
    this.name,
    this.englishName,
    this.englishNameTranslation,
    this.revelationType,
    this.ayahs,
  });

  factory Surahs.fromJson(Map<String, dynamic> json) {
    List<Ayahs>? parsedAyahs;
    if (json['ayahs'] != null && json['ayahs'] is List<dynamic>) { // Ensure it's a List
      parsedAyahs = (json['ayahs'] as List<dynamic>)
          .map((v) {
        if (v is Map<String, dynamic>) { // Ensure each item in the list is a Map
          return Ayahs.fromJson(v);
        }
        return Ayahs(); // Return a default/empty Ayahs if malformed data
      })
          .whereType<Ayahs>() // Filter out any nulls if Ayahs() returns null
          .toList();
    }
    return Surahs(
      number: json['number'],
      name: json['name'],
      englishName: json['englishName'],
      englishNameTranslation: json['englishNameTranslation'],
      revelationType: json['revelationType'],
      ayahs: parsedAyahs,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['number'] = number;
    data['name'] = name;
    data['englishName'] = englishName;
    data['englishNameTranslation'] = englishNameTranslation;
    data['revelationType'] = revelationType;
    if (ayahs != null) {
      data['ayahs'] = ayahs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ayahs {
  int? number;
  String? text;
  int? numberInSurah;
  int? juz;
  int? manzil;
  int? page;
  int? ruku;
  int? hizbQuarter;
  bool? sajda; // This is a nullable boolean

  Ayahs({
    this.number,
    this.text,
    this.numberInSurah,
    this.juz,
    this.manzil,
    this.page,
    this.ruku,
    this.hizbQuarter,
    this.sajda,
  });

  factory Ayahs.fromJson(Map<String, dynamic> json) {
    return Ayahs(
      number: json['number'],
      text: json['text'],
      numberInSurah: json['numberInSurah'],
      juz: json['juz'],
      manzil: json['manzil'],
      page: json['page'],
      ruku: json['ruku'],
      hizbQuarter: json['hizbQuarter'],
      // Robust check for sajda: ensures it's a bool, otherwise null
      sajda: json['sajda'] is bool ? json['sajda'] : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['number'] = number;
    data['text'] = text;
    data['numberInSurah'] = numberInSurah;
    data['juz'] = juz;
    data['manzil'] = manzil;
    data['page'] = page;
    data['ruku'] = ruku;
    data['hizbQuarter'] = hizbQuarter;
    data['sajda'] = sajda;
    return data;
  }
}

class Edition {
  String? identifier;
  String? language;
  String? name;
  String? englishName;
  String? format;
  String? type;

  Edition({
    this.identifier,
    this.language,
    this.name,
    this.englishName,
    this.format,
    this.type,
  });

  factory Edition.fromJson(Map<String, dynamic> json) {
    return Edition(
      identifier: json['identifier'],
      language: json['language'],
      name: json['name'],
      englishName: json['englishName'],
      format: json['format'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['identifier'] = identifier;
    data['language'] = language;
    data['name'] = name;
    data['englishName'] = englishName;
    data['format'] = format;
    data['type'] = type;
    return data;
  }
}
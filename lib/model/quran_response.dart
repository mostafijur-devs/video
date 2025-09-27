// ==================== QuranResponse ====================
class QuranResponse {
  int code;
  String status;
  Data data;

  QuranResponse({
    required this.code,
    required this.status,
    required this.data,
  });

  factory QuranResponse.fromJson(Map<String, dynamic> json) {
    return QuranResponse(
      code: json['code'],
      status: json['status'],
      data: Data.fromJson(json['data']),
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'code': code,
  //     'status': status,
  //     'data': data.toJson(),
  //   };
  // }
}

// ==================== Data ====================
class Data {
  List<Surah> surahs;
  Edition edition;

  Data({required this.surahs, required this.edition});

  factory Data.fromJson(Map<String, dynamic> json) {
    var surahsList =
    (json['surahs'] as List).map((item) => Surah.fromJson(item)).toList();
    return Data(surahs: surahsList, edition: Edition.fromJson(json['edition']));
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'surahs': surahs.map((e) => e.toJson()).toList(),
  //     'edition': edition.toJson(),
  //   };
  // }
}

// ==================== Surah ====================
class Surah {
  int number;
  String name;
  String englishName;
  String englishNameTranslation;
  String revelationType;
  List<Ayah> ayahs;

  Surah({
    required this.number,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
    required this.revelationType,
    required this.ayahs,
  });

  factory Surah.fromJson(Map<String, dynamic> json) {
    var ayahsList = (json['ayahs'] as List)
        .map((item) => Ayah.fromJson(item))
        .toList();
    return Surah(
      number: json['number'],
      name: json['name'],
      englishName: json['englishName'],
      englishNameTranslation: json['englishNameTranslation'],
      revelationType: json['revelationType'],
      ayahs: ayahsList,
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'number': number,
  //     'name': name,
  //     'englishName': englishName,
  //     'englishNameTranslation': englishNameTranslation,
  //     'revelationType': revelationType,
  //     'ayahs': json['ayahs'] as List).map((e) => Ayah.fromJson(e)).toList(),
  //   };
  // }
}

// ==================== Ayah ====================
class Ayah {
  final int? number;
  final String? text;
  final int? numberInSurah;
  final int? juz;
  final int? page;
  final bool? sajda;

  Ayah({this.number, this.text, this.numberInSurah, this.juz, this.page, this.sajda});

  factory Ayah.fromJson(Map<String, dynamic> json) {
    bool? sajdaValue;

    if (json['sajda'] is bool) {
      sajdaValue = json['sajda'];
    } else if (json['sajda'] is Map) {
      // যদি sajda map আসে, আমরা recommended field use করতে পারি
      sajdaValue = json['sajda']['recommended'] ?? false;
    } else {
      sajdaValue = false;
    }

    return Ayah(
      number: json['number'],
      text: json['text'] ?? "",
      numberInSurah: json['numberInSurah'],
      juz: json['juz'],
      page: json['page'],
      sajda: sajdaValue,
    );
  }
}


// ==================== Edition ====================
class Edition {
  String identifier;
  String language;
  String name;
  String englishName;
  String format;
  String type;

  Edition({
    required this.identifier,
    required this.language,
    required this.name,
    required this.englishName,
    required this.format,
    required this.type,
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
    return {
      'identifier': identifier,
      'language': language,
      'name': name,
      'englishName': englishName,
      'format': format,
      'type': type,
    };
  }
}

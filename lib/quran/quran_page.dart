import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/quran_response.dart';

// ==================== Model Classes ====================
// (তোমার দেওয়া QuranResponse, Data, Surah, Ayah, Edition ক্লাস এখানে paste করো)

// ==================== Flutter Page ====================
class QuranPage extends StatefulWidget {
  const QuranPage({Key? key}) : super(key: key);

  @override
  State<QuranPage> createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  QuranResponse? quranResponse;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchQuran();
  }

  Future<void> fetchQuran() async {
    final url = Uri.parse('https://api.alquran.cloud/v1/quran');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        quranResponse = QuranResponse.fromJson(jsonData);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load Quran data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Al-Quran'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : quranResponse == null
          ? Center(child: Text('No data found'))
          : ListView.builder(
        itemCount: quranResponse!.data!.surahs!.length,
        itemBuilder: (context, index) {
          final surah = quranResponse!.data!.surahs![index];
          return ExpansionTile(
            title: Text(
              '${surah.englishName} (${surah.name})',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(surah.englishNameTranslation!),
            children: surah.ayahs!.map((ayah) {
              return ListTile(
                title: Text(
                  ayah.text!,
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 18),
                ),
                subtitle: Text(
                    'Ayah ${ayah.numberInSurah}, Page ${ayah.page}'),
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        final edition = quranResponse!.data.edition;
        Navigator.push(context, MaterialPageRoute(builder: (context) => AditionView(edition: edition,),));
      },child: Text('Edition view'),),
    );
  }
}
class AditionView extends StatelessWidget {
  AditionView({super.key,required this.edition});

  Edition edition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(
        children: [
          Text(edition.identifier),
          Text(edition.language),
          Text(edition.name),
          Text(edition.englishName),
          Text(edition.format),
          Text(edition.type),
        ],
      ),)
    );
  }
}

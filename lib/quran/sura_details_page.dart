import 'package:flutter/material.dart';
import '../model/quran_response.dart';


class SurahDetailPage extends StatelessWidget {
  final Surah surah;
  const SurahDetailPage({Key? key, required this.surah}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ayahs = surah.ayahs ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('${surah.englishName ?? ""} (${surah.name ?? ""})'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: ayahs.length,
        itemBuilder: (context, index) {
          final ayah = ayahs[index];

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Arabic text
                  Text(
                    ayah.text ?? "",
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontSize: 22,
                      height: 1.8,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Details row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Ayah: ${ayah.numberInSurah ?? ""}'),
                      Text('Juz: ${ayah.juz ?? ""}'),
                      Text('Page: ${ayah.page ?? ""}'),
                      Text('Sajda: ${ayah.sajda == true ? "Yes" : "No"}'),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

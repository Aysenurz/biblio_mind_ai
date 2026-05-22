import 'package:flutter/material.dart';

class KitapKesifEkrani extends StatefulWidget {
  const KitapKesifEkrani({super.key});

  @override
  State<KitapKesifEkrani> createState() => _KitapKesifEkraniState();
}

class _KitapKesifEkraniState extends State<KitapKesifEkrani> {
  // Buraya Sena'nın fonksiyonlarından dönecek listeleri bağlayacağız
  List<String> _bfsSonuclari = ["1984", "Cesur Yeni Dünya", "Fahrenheit 451"];
  List<String> _dfsSonuclari = ["Vakıf", "Dune", "Mülksüzler"];

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Yapay Zeka Kitap Keşif Ağı",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // BFS Bölümü
              const Text(
                "🔍 BFS ile Benzer Kitap Keşfi (En Yakın Komşular)",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6366F1),
                ),
              ),
              const SizedBox(height: 10),
              _buildYatayListe(_bfsSonuclari, isDark),

              const SizedBox(height: 30),

              // DFS Bölümü
              const Text(
                "🌲 DFS ile Derinlemesine Tür Yolculuğu",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF10B981),
                ),
              ),
              const SizedBox(height: 10),
              _buildYatayListe(_dfsSonuclari, isDark),
            ],
          ),
        ),
      ),
    );
  }

  // Kitapları yan yana şık kartlar şeklinde gösteren yardımcı widget
  Widget _buildYatayListe(List<String> kitaplar, bool isDark) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: kitaplar.length,
        itemBuilder: (context, index) {
          return Card(
            color: isDark ? const Color(0xFF1E293B) : Colors.white,
            elevation: 2,
            margin: const EdgeInsets.only(right: 12),
            child: Container(
              width: 140,
              padding: const EdgeInsets.all(12),
              alignment: Alignment.center,
              child: Text(
                kitaplar[index],
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          );
        },
      ),
    );
  }
}

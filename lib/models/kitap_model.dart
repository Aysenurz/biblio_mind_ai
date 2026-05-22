class Kitap {
  final int? id;
  final String baslik; // Ya da direkt 'isim' de denebilir
  final String yazar;
  final String turu; // Algoritma için en kritik alan (Düğümleri bağlayacak)

  Kitap({
    this.id,
    required this.baslik,
    required this.yazar,
    required this.turu,
  });

  // Veritabanına kaydederken Map'e çevirmek için
  Map<String, dynamic> haritayaCevir() {
    return {'id': id, 'baslik': baslik, 'yazar': yazar, 'turu': turu};
  }

  // Veritabanından okurken nesneye çevirmek için
  factory Kitap.haritadanCevir(Map<String, dynamic> harita) {
    return Kitap(
      id: harita['id'],
      baslik: harita['baslik'],
      yazar: harita['yazar'],
      turu: harita['turu'],
    );
  }
}

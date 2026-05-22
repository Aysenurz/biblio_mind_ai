class Dugum {
  final String
  id; // Benzersiz kimlik (Kitap adı veya Tür adı için 'id' genelde aynen bırakılır veya 'kod' denir)
  final String isim; // Ekranda görünecek olan ad/etiket
  final String turu; // 'kitap', 'yazar' veya 'tur' (Ayrım yapmak için)

  Dugum({required this.id, required this.isim, required this.turu});
}

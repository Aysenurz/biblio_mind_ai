import '../models/dugum.dart';
import '../models/kitap_model.dart'; // Dosya yoluna göre düzenleyebilirsin
import 'veritabani_yardimcisi.dart'; // SQLite sınıfının adı

class GrafYoneticisi {
  final Map<Dugum, List<Dugum>> komsulukListesi = {};
  final Map<String, Dugum> _dugumOnbellegi = {};

  // Aynı ID ile tekrar tekrar düğüm üretilmesini engelleyen yardımcı metot
  Dugum _dugumOlusturVeyaGetir(String id, String isim, String turu) {
    return _dugumOnbellegi.putIfAbsent(
      id,
      () => Dugum(id: id, isim: isim, turu: turu),
    );
  }

  void dugumEkle(Dugum dugum) {
    komsulukListesi.putIfAbsent(dugum, () => []);
  }

  void bagOlustur(Dugum kaynak, Dugum hedef) {
    if (komsulukListesi.containsKey(kaynak) &&
        komsulukListesi.containsKey(hedef)) {
      if (!komsulukListesi[kaynak]!.contains(hedef))
        komsulukListesi[kaynak]!.add(hedef);
      if (!komsulukListesi[hedef]!.contains(kaynak))
        komsulukListesi[hedef]!.add(kaynak);
    }
  }

  // Senin yazıp tamamladığın altyapı fonksiyonu
  Future<void> veritabanindanGrafiOlustur() async {
    // Veritabanından tüm kitapları Türkçe modelle çekiyoruz
    List<Kitap> kitaplar = await VeritabaniYardimcisi.instance
        .tumKitaplariGetir();

    for (var kitap in kitaplar) {
      var kitapDugumu = _dugumOlusturVeyaGetir(
        kitap.baslik,
        kitap.baslik,
        'kitap',
      );
      var yazarDugumu = _dugumOlusturVeyaGetir(
        kitap.yazar,
        kitap.yazar,
        'yazar',
      );
      var turDugumu = _dugumOlusturVeyaGetir(kitap.turu, kitap.turu, 'tur');

      dugumEkle(kitapDugumu);
      dugumEkle(yazarDugumu);
      dugumEkle(turDugumu);

      bagOlustur(kitapDugumu, yazarDugumu);
      bagOlustur(kitapDugumu, turDugumu);
    }
  }
}

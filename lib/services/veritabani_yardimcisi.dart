import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/kitap_model.dart'; // Kitap sınıfının olduğu dosya yolu

class VeritabaniYardimcisi {
  static final VeritabaniYardimcisi instance = VeritabaniYardimcisi._init();
  static Database? _database;

  VeritabaniYardimcisi._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('biblio_mind.db');
    return _database!;
  }

  Future<Database> _initDB(String dosyaYolu) async {
    final dbYolu = await getDatabasesPath();
    final path = join(dbYolu, dosyaYolu);

    return await openDatabase(path, version: 1, onCreate: _dbOlustur);
  }

  // Veritabanı ilk defa açılırken tabloyu kuruyoruz
  Future _dbOlustur(Database db, int version) async {
    await db.execute('''
      CREATE TABLE kitaplar (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        baslik TEXT NOT NULL,
        yazar TEXT NOT NULL,
        turu TEXT NOT NULL
      )
    ''');
    
    // Yapay Zeka dersinde hocanın hemen test edebilmesi için örnek bir kitap ağı ekliyoruz
    await db.insert('kitaplar', {'baslik': '1984', 'yazar': 'George Orwell', 'turu': 'Distopya'});
    await db.insert('kitaplar', {'baslik': 'Cesur Yeni Dünya', 'yazar': 'Aldous Huxley', 'turu': 'Distopya'});
    await db.insert('kitaplar', {'baslik': 'Fahrenheit 451', 'yazar': 'Ray Bradbury', 'turu': 'Distopya'});
    await db.insert('kitaplar', {'baslik': 'Vakıf', 'yazar': 'Isaac Asimov', 'turu': 'Bilim Kurgu'});
    await db.insert('kitaplar', {'baslik': 'Dune', 'yazar': 'Frank Herbert', 'turu': 'Bilim Kurgu'});
    await db.insert('kitaplar', {'baslik': 'Mülksüzler', 'yazar': 'Ursula K. Le Guin', 'turu': 'Bilim Kurgu'});
  }

  // Grafı besleyecek olan tüm kitapları listeleme fonksiyonu
  Future<List<Kitap>> tumKitaplariGetir() async {
    final db = await instance.database;
    final sonuc = await db.query('kitaplar');
    
    // Senin yazdığın 'haritadanCevir' metodunu kullanarak nesneye dönüştürüyoruz
    return sonuc.map((harita) => Kitap.haritadanCevir(harita)).toList();
  }
}

import 'dart:convert';

List<DombaBreedingModels> dombaBreedingModelsFromJson(String str) => List<DombaBreedingModels>.from(json.decode(str).map((x) => DombaBreedingModels.fromJson(x)));

String dombaBreedingModelsToJson(List<DombaBreedingModels> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DombaBreedingModels {
    final int id;
    final String namaPaket;
    final int harga;
    final String keterangan;
    final dynamic jumlahDomba;
    final dynamic gambar;
    final DateTime createdAt;
    final DateTime updatedAt;
    dynamic gambar_url;

    DombaBreedingModels( {
        required this.id,
        required this.namaPaket,
        required this.harga,
        required this.keterangan,
        required this.gambar,
        required this.createdAt,
        required this.updatedAt,
        this.gambar_url,
        this.jumlahDomba,
    });

    factory DombaBreedingModels.fromJson(Map<String, dynamic> json) => DombaBreedingModels(
        id: json["id"],
        namaPaket: json["nama_paket"],
        harga: json["harga"],
        jumlahDomba: json["jumlah_domba"],
        keterangan: json["keterangan"],
        gambar: json["gambar"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        gambar_url: json['gambar_url'],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama_paket": namaPaket,
        "harga": harga,
        "keterangan": keterangan,
        "gambar": gambar,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

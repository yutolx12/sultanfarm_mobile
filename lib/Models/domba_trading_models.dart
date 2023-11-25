// To parse this JSON data, do
//
//     final dombaModels = dombaModelsFromJson(jsonString);

// ignore: unused_import
import 'dart:convert';

List<DombaModels> dombaModelsFromJson(String str) => List<DombaModels>.from(json.decode(str).map((x) => DombaModels.fromJson(x)));

String dombaModelsToJson(List<DombaModels> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DombaModels {
    final int id;
    final String kodeDomba;
    final String jenisKelamin;
    final String tipeDomba;
    final int bobot;
    final dynamic indukJantan;
    final dynamic indukBetina;
    final int turunan;
    final String gambar;
    final String keterangan;
    final int hargaBeli;
    final int hargaJual;
    final String status;
    final DateTime tglLahir;
    final int idKamar;
    final int idJenis;
    final DateTime createdAt;
    final DateTime updatedAt;
    final String jenisDomba;

    DombaModels({
        required this.id,
        required this.kodeDomba,
        required this.jenisKelamin,
        required this.tipeDomba,
        required this.bobot,
        this.indukJantan,
        this.indukBetina,
        required this.turunan,
        required this.gambar,
        required this.keterangan,
        required this.hargaBeli,
        required this.hargaJual,
        required this.status,
        required this.tglLahir,
        required this.idKamar,
        required this.idJenis,
        required this.createdAt,
        required this.updatedAt,
        required this.jenisDomba,
    });

    factory DombaModels.fromJson(Map<String, dynamic> json) => DombaModels(
        id: json["id"],
        kodeDomba: json["kode_domba"],
        jenisKelamin: json["jenis_kelamin"],
        tipeDomba: json["tipe_domba"],
        bobot: json["bobot"],
        indukJantan: json["induk_jantan"],
        indukBetina: json["induk_betina"],
        turunan: json["turunan"],
        gambar: json["gambar"],
        keterangan: json["keterangan"],
        hargaBeli: json["harga_beli"],
        hargaJual: json["harga_jual"],
        status: json["status"],
        tglLahir: DateTime.parse(json["tgl_lahir"]),
        idKamar: json["id_kamar"],
        idJenis: json["id_jenis"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        jenisDomba: json["jenis_domba"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "kode_domba": kodeDomba,
        "jenis_kelamin": jenisKelamin,
        "tipe_domba": tipeDomba,
        "bobot": bobot,
        "turunan": turunan,
        "gambar": gambar,
        "keterangan": keterangan,
        "harga_beli": hargaBeli,
        "harga_jual": hargaJual,
        "status": status,
        "tgl_lahir": "${tglLahir.year.toString().padLeft(4, '0')}-${tglLahir.month.toString().padLeft(2, '0')}-${tglLahir.day.toString().padLeft(2, '0')}",
        "id_kamar": idKamar,
        "id_jenis": idJenis,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "jenis_domba": jenisDomba,
    };
}
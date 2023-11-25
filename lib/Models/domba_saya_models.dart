// To parse this JSON data, do
//
//     final dombaSayaModels = dombaSayaModelsFromJson(jsonString);

import 'dart:convert';

List<DombaSayaModels> dombaSayaModelsFromJson(String str) => List<DombaSayaModels>.from(json.decode(str).map((x) => DombaSayaModels.fromJson(x)));

String dombaSayaModelsToJson(List<DombaSayaModels> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DombaSayaModels {
    final int id;
    final String kodeDomba;
    final String jenisKelamin;
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
    final String jenisDomba;
    final String kode;
    final int urutan;
    final int idPlasma;
    final int noKamar;
    final int idCustomer;
    final int idPaket;
    final int total;
    final String namaPaket;
    final int harga;
    final DateTime createdAt;
    final DateTime updatedAt;

    DombaSayaModels({
        required this.id,
        required this.kodeDomba,
        required this.jenisKelamin,
        required this.bobot,
        required this.indukJantan,
        required this.indukBetina,
        required this.turunan,
        required this.gambar,
        required this.keterangan,
        required this.hargaBeli,
        required this.hargaJual,
        required this.status,
        required this.tglLahir,
        required this.jenisDomba,
        required this.kode,
        required this.urutan,
        required this.idPlasma,
        required this.noKamar,
        required this.idCustomer,
        required this.idPaket,
        required this.total,
        required this.namaPaket,
        required this.harga,
        required this.createdAt,
        required this.updatedAt,
    });

    factory DombaSayaModels.fromJson(Map<String, dynamic> json) => DombaSayaModels(
        id: json["id"],
        kodeDomba: json["kode_domba"],
        jenisKelamin: json["jenis_kelamin"],
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
        jenisDomba: json["jenis_domba"],
        kode: json["kode"],
        urutan: json["urutan"],
        idPlasma: json["id_plasma"],
        noKamar: json["no_kamar"],
        idCustomer: json["id_customer"],
        idPaket: json["id_paket"],
        total: json["total"],
        namaPaket: json["nama_paket"],
        harga: json["harga"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "kode_domba": kodeDomba,
        "jenis_kelamin": jenisKelamin,
        "bobot": bobot,
        "induk_jantan": indukJantan,
        "induk_betina": indukBetina,
        "turunan": turunan,
        "gambar": gambar,
        "keterangan": keterangan,
        "harga_beli": hargaBeli,
        "harga_jual": hargaJual,
        "status": status,
        "tgl_lahir": "${tglLahir.year.toString().padLeft(4, '0')}-${tglLahir.month.toString().padLeft(2, '0')}-${tglLahir.day.toString().padLeft(2, '0')}",
        "jenis_domba": jenisDomba,
        "kode": kode,
        "urutan": urutan,
        "id_plasma": idPlasma,
        "no_kamar": noKamar,
        "id_customer": idCustomer,
        "id_paket": idPaket,
        "total": total,
        "nama_paket": namaPaket,
        "harga": harga,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

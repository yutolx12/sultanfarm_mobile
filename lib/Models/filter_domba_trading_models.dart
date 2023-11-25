// To parse this JSON data, do
//
//     final filterDombaTradingModels = filterDombaTradingModelsFromJson(jsonString);

import 'dart:convert';

List<FilterDombaTradingModels> filterDombaTradingModelsFromJson(String str) => List<FilterDombaTradingModels>.from(json.decode(str).map((x) => FilterDombaTradingModels.fromJson(x)));

String filterDombaTradingModelsToJson(List<FilterDombaTradingModels> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FilterDombaTradingModels {
    final int id;
    final String kodeDomba;
    final String jenisKelamin;
    final int bobot;
    final String indukJantan;
    final String indukBetina;
    final int turunan;
    final String gambar;
    final String keterangan;
    final int hargaBeli;
    final int hargaJual;
    final String status;
    final DateTime tglLahir;
    final String jenisDomba;
    final String kode;
    final String urutan;

    FilterDombaTradingModels({
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
    });

    factory FilterDombaTradingModels.fromJson(Map<String, dynamic> json) => FilterDombaTradingModels(
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
    };
}

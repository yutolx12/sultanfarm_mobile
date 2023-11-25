import 'dart:convert';

List<FilterJenisDombaModels> filterJenisDombaModelsFromJson(String str) => List<FilterJenisDombaModels>.from(json.decode(str).map((x) => FilterJenisDombaModels.fromJson(x)));

String filterJenisDombaModelsToJson(List<FilterJenisDombaModels> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FilterJenisDombaModels {
    final String id;
    final String jenisDomba;
    final String kode;
    final String gambar;
    final String urutan;
    final dynamic createdAt;
    final DateTime updatedAt;

    FilterJenisDombaModels({
        required this.id,
        required this.jenisDomba,
        required this.kode,
        required this.gambar,
        required this.urutan,
        required this.createdAt,
        required this.updatedAt,
    });

    factory FilterJenisDombaModels.fromJson(Map<String, dynamic> json) => FilterJenisDombaModels(
        id: json["id"],
        jenisDomba: json["jenis_domba"],
        kode: json["kode"],
        gambar: json["gambar"],
        urutan: json["urutan"],
        createdAt: json["created_at"],
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "jenis_domba": jenisDomba,
        "kode": kode,
        "gambar": gambar,
        "urutan": urutan,
        "created_at": createdAt,
        "updated_at": updatedAt.toIso8601String(),
    };
}

import 'dart:convert';

List<kamarModels> plasmaModelsFromJson(String str) => List<kamarModels>.from(json.decode(str).map((x) => kamarModels.fromJson(x)));

String plasmaModelsToJson(List<kamarModels> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class kamarModels {
    final int id;
    final int idPlasma;
    final String namaPlasma;
    final String alamatPlasma;
    final int noKamar;
    final String status;

    kamarModels({
        required this.id,
        required this.idPlasma,
        required this.namaPlasma,
        required this.alamatPlasma,
        required this.noKamar,
        required this.status,
    });

    factory kamarModels.fromJson(Map<String, dynamic> json) => kamarModels(
        id: json["id"],
        idPlasma: json["id_plasma"],
        namaPlasma: json["nama_plasma"],
        alamatPlasma: json["alamat_plasma"],
        noKamar: json["no_kamar"],
        status: json["status"]
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "id_plasma": idPlasma,
        "nama_plasma": namaPlasma,
        "alamat_plasma": alamatPlasma,
        "no_kamar": noKamar,
        "status": status,
    };
}


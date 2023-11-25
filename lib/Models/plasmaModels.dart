
import 'dart:convert';

PlasmaModels plasmaModelsFromJson(String str) => PlasmaModels.fromJson(json.decode(str));

String plasmaModelsToJson(PlasmaModels data) => json.encode(data.toJson());

class PlasmaModels {
    final int id;
    final String namaPlasma;
    final String alamatPlasma;
    DateTime? createdAt;
    DateTime? updatedAt;

    PlasmaModels({
        required this.id,
        required this.namaPlasma,
        required this.alamatPlasma,
        this.createdAt,
        this.updatedAt,
    });

    factory PlasmaModels.fromJson(Map<String, dynamic> json) => PlasmaModels(
        id: json["id"],
        namaPlasma: json["nama_plasma"],
        alamatPlasma: json["alamat_plasma"],
        // createdAt: DateTime.parse(json["created_at"]),
        // updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama_plasma": namaPlasma,
        "alamat_plasma": alamatPlasma,
    };
}

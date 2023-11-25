// To parse this JSON data, do
//
//     final riwayatPengajuanModels = riwayatPengajuanModelsFromJson(jsonString);

import 'dart:convert';

List<RiwayatDiprosesModels> riwayatPengajuanModelsFromJson(String str) =>
    List<RiwayatDiprosesModels>.from(
        json.decode(str).map((x) => RiwayatDiprosesModels.fromJson(x)));

String riwayatPengajuanModelsToJson(List<RiwayatDiprosesModels> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RiwayatDiprosesModels {
  final int id;
  final String kodePenjualan;
  final String buktiPembayaran;
  final String akad;
  final String status;
  final int total;
  final int idKamar;
  final int idPaket;
  final int idUser;
  final int idCustomer;
  final int idPlasma;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String namaPaket;
  final String gambar;
  final String noKamar;
  final String namaPlasma;

  RiwayatDiprosesModels({
    required this.id,
    required this.kodePenjualan,
    required this.buktiPembayaran,
    required this.akad,
    required this.status,
    required this.total,
    required this.idKamar,
    required this.idPaket,
    required this.idUser,
    required this.idCustomer,
    required this.idPlasma,
    required this.createdAt,
    required this.updatedAt,
    required this.namaPaket,
    required this.gambar,
    required this.noKamar,
    required this.namaPlasma,
  });

  factory RiwayatDiprosesModels.fromJson(Map<String, dynamic> json) =>
      RiwayatDiprosesModels(
        id: json["id"],
        kodePenjualan: json["kode_penjualan"],
        buktiPembayaran: json["bukti_pembayaran"],
        akad: json["akad"],
        status: json["status"],
        total: json["total"],
        idKamar: json["id_kamar"],
        idPaket: json["id_paket"],
        idUser: json["id_user"],
        idCustomer: json["id_customer"],
        idPlasma: json["id_plasma"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        namaPaket: json["nama_paket"],
        gambar: json["gambar"],
        noKamar: json["no_kamar"],
        namaPlasma: json["nama_plasma"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kode_penjualan": kodePenjualan,
        "bukti_pembayaran": buktiPembayaran,
        "akad": akad,
        "status": status,
        "total": total,
        "id_kamar": idKamar,
        "id_paket": idPaket,
        "id_user": idUser,
        "id_customer": idCustomer,
        "id_plasma": idPlasma,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "nama_paket": namaPaket,
        "gambar": gambar,
        "no_kamar": noKamar,
        "nama_plasma": namaPlasma,
      };
}

import 'dart:convert';

ModelRegister modelRegisterFromJson(String str) => ModelRegister.fromJson(json.decode(str));

String modelRegisterToJson(ModelRegister data) => json.encode(data.toJson());

class ModelRegister {
    dynamic id;
    String? namaCustomer;
    String? email;
    String? noTelpon;
    String? alamat;
    String? password;

    ModelRegister({
        this.id,
        this.namaCustomer,
        this.email,
        this.noTelpon,
        this.alamat,
        this.password,
    });

    factory ModelRegister.fromJson(Map<String, dynamic> json) => ModelRegister(
        id: json["id"],
        namaCustomer: json["nama_customer"],
        email: json["email"],
        noTelpon: json["no_telpon"],
        alamat: json["alamat"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama_customer": namaCustomer,
        "email": email,
        "no_telpon": noTelpon,
        "alamat": alamat,
        "password": password,
    };
}

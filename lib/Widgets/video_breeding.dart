import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sultan_farm_mobile/Models/domba_trading_models.dart';
import 'package:sultan_farm_mobile/Theme.dart';
import 'package:url_launcher/url_launcher.dart';

class ButtonWhatsapp extends StatefulWidget {
  @override
  State<ButtonWhatsapp> createState() => _ButtonWhatsappState();
  final String? title;
  final String? icon;
  final ButtonStyle? buttonStyle;
  final Color? iconColor;
  final Color? textColor;
  //  final DombaModels? domba;

  const ButtonWhatsapp({
    Key? key,
    this.title,
    this.icon,
    this.buttonStyle,
    this.iconColor,
    this.textColor,
    // this.domba,
  }) : super(key: key);
}

class _ButtonWhatsappState extends State<ButtonWhatsapp> {
  late SharedPreferences prefs;
  var id = '';
  var name = '';

  getDataAkun() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getString("id").toString();
      name = prefs.getString("nama").toString();
    });
  }

  @override
  void initState() {
    super.initState();
    getDataAkun();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final DombaModels? domba = args?['domba'];
    // ignore: unused_local_variable
    Future<void>? launched;

    Future<void> launchInApp(Uri url) async {
      if (!await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      )) {
        throw Exception('Could not launch $url');
      }
    }

    final Uri toLaunch = Uri(
      scheme: 'https',
      host: 'wa.me',
      path: '+6281455165124',
      queryParameters: {
        'text': 'Id : $id\n'
            'Nama : $name\n'
            'Saya ingin membeli Domba\n'
            'Jenis Domba : ${domba?.jenisDomba ?? 'Tidak Tersedia'}\n'
            'Harga domba :Rp ${NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0).format(domba?.hargaJual ?? 0)}',
      },
    );

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () => setState(() {
          launched = launchInApp(toLaunch);
        }),
        icon: widget.icon != null && widget.icon!.isNotEmpty
            ? Image.asset(
                widget.icon!,
                width: 24,
                height: 24,
                color: widget.iconColor,
              )
            : const SizedBox(),
        label: Text(
          widget.title ?? '',
          style: blackTextStyle.copyWith(
            fontWeight: bold,
            fontSize: 14,
            letterSpacing: 0.5,
            color: widget.textColor,
          ),
        ),
        style: widget.buttonStyle,
      ),
    );
  }
}

class ButtonWhatsappQurban extends StatefulWidget {
  @override
  State<ButtonWhatsappQurban> createState() => _ButtonWhatsappQurbanState();
  final String? title;
  final String? icon;
  final ButtonStyle? buttonStyle;
  final Color? iconColor;
  final Color? textColor;
  //  final DombaModels? domba;

  const ButtonWhatsappQurban({
    Key? key,
    this.title,
    this.icon,
    this.buttonStyle,
    this.iconColor,
    this.textColor,
    // this.domba,
  }) : super(key: key);
}

class _ButtonWhatsappQurbanState extends State<ButtonWhatsappQurban> {
  late SharedPreferences prefs;
  var id = '';
  var name = '';

  getDataAkun() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getString("id").toString();
      name = prefs.getString("nama").toString();
    });
  }

  @override
  void initState() {
    super.initState();
    getDataAkun();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Future<void>? launched;

    Future<void> launchInApp(Uri url) async {
      if (!await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      )) {
        throw Exception('Could not launch $url');
      }
    }

    final Uri toLaunch = Uri(
      scheme: 'https',
      host: 'wa.me',
      path: '+6281455165124',
      queryParameters: {
        'text': 'Id : $id\n'
            'Nama : $name\n'
            'Saya ingin membeli Paket Qurban\n'
            'Harga Paket Qurban : Rp 6.000.000',
      },
    );

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () => setState(() {
          launched = launchInApp(toLaunch);
        }),
        icon: widget.icon != null && widget.icon!.isNotEmpty
            ? Image.asset(
                widget.icon!,
                width: 24,
                height: 24,
                color: widget.iconColor,
              )
            : const SizedBox(),
        label: Text(
          widget.title ?? '',
          style: blackTextStyle.copyWith(
            fontWeight: bold,
            fontSize: 14,
            letterSpacing: 0.5,
            color: widget.textColor,
          ),
        ),
        style: widget.buttonStyle,
      ),
    );
  }
}

class YoutubeThumbnailContainer extends StatelessWidget {
  final String videoId;

  const YoutubeThumbnailContainer({super.key, required this.videoId});

  String getThumbnailUrl() {
    return 'https://img.youtube.com/vi/$videoId/0.jpg';
  }

  void _launchYoutubeVideo() async {
    final url = 'https://www.youtube.com/watch?v=$videoId';
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _launchYoutubeVideo,
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage(getThumbnailUrl()),
            fit: BoxFit.cover,
          ),
        ),
        child: const Center(
          child: Icon(
            Icons.play_arrow,
            size: 50,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

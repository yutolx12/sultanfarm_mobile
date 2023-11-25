import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sultan_farm_mobile/Models/Api_Connect.dart';
import 'package:sultan_farm_mobile/Models/domba_trading_models.dart';
import 'package:sultan_farm_mobile/Models/filter_jenis_domba_models.dart';
import 'package:sultan_farm_mobile/Theme.dart';
import 'package:sultan_farm_mobile/Widgets/buttons.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:http/http.dart' as http;

class ModalFilter extends StatefulWidget {
  final Function(bool) onFilterApplied;
  const ModalFilter({
    super.key,
    required this.onFilterApplied,
  });

  @override
  State<ModalFilter> createState() => _ModalFilterState();
}

class _ModalFilterState extends State<ModalFilter> {
  SfRangeValues _values = const SfRangeValues(20, 150);
  FilterJenisDombaModels? selectedJenisDomba;
  DombaModels? selectedSemua;
  String? selectedKelaminDomba;
  bool isLoading = false;
  List<FilterJenisDombaModels> jenisDombaList = [];
  List<DombaModels> dombaList = [];

  Future<void> fetchDataDomba() async {
    try {
      final response = await http.get(Uri.parse(ApiConnect.datadomba));

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        List<DombaModels> dombas =
            jsonResponse.map((data) => DombaModels.fromJson(data)).toList();

        setState(() {
          dombaList = dombas;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load data from the API');
      }
    } catch (e) {
      // Handle the error, e.g., show an error message to the user
      setState(() {
        isLoading = false; // Perbaikan: Hentikan loading jika ada kesalahan.
      });
    }
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse(ApiConnect.filterJenisDomba));

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        List<FilterJenisDombaModels> jenisDomba = jsonResponse
            .map((data) => FilterJenisDombaModels.fromJson(data))
            .toList();
        setState(() {
          jenisDombaList = jenisDomba;
        });
      } else {
        throw Exception('Failed to load data from the API');
      }
    } catch (e) {
      // Handle the error, e.g., show an error message to the user
    }
  }

  // save filter biar bisa diakses ke domba_tersedia_page
  // SEHARUSNYA: pake state management
  // parameternya tinggal diisi di fungsi ini, ntar diwrite ke shared prefs
  Future<void> filterData(getDomba) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("getDomba", getDomba);
    // await prefs.setString("jenis", jenis);
    // await prefs.setString("kelamin", kelamin);
    // await prefs.setInt("bobotMin", bobotMin);
    // await prefs.setInt("bobotMax", bobotMax);
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: whiteColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(
                  color: Color(0xffD9D9D9),
                  thickness: 4,
                  indent: 165,
                  endIndent: 165,
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(24, 0, 24, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Filter",
                        style: filterTextStyle.copyWith(
                          fontWeight: semiBold,
                          fontSize: 14,
                          letterSpacing: 0.1,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Jenis Domba",
                        style: blackTextStyle.copyWith(
                          fontSize: 14,
                          letterSpacing: 0.4,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Wrap(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  selectedSemua =
                                      null; // Reset selected jenis domba
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: selectedSemua == null
                                    ? bluetogreenColor
                                    : neutral95Color,
                              ),
                              child: Text(
                                "Semua",
                                style: selectedSemua == null
                                    ? whitekTextStyle.copyWith(
                                        fontWeight: medium)
                                    : blackTextStyle.copyWith(
                                        fontWeight: medium),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          ...List.generate(
                            jenisDombaList.length,
                            (index) {
                              final domba = jenisDombaList[index];

                              return Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        if (selectedJenisDomba != domba) {
                                          setState(() {
                                            selectedJenisDomba = domba;
                                          });
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        backgroundColor:
                                            selectedJenisDomba?.id == domba.id
                                                ? bluetogreenColor
                                                : neutral95Color,
                                      ),
                                      child: Text(
                                        domba.jenisDomba,
                                        style:
                                            selectedJenisDomba?.id == domba.id
                                                ? whitekTextStyle.copyWith(
                                                    fontWeight: medium)
                                                : blackTextStyle.copyWith(
                                                    fontWeight: medium),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Kelamin",
                        style: blackTextStyle.copyWith(
                          fontSize: 14,
                          letterSpacing: 0.4,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Wrap(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  selectedKelaminDomba =
                                      null; // Set selected jenis domba to null (default)
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: selectedKelaminDomba == null
                                    ? bluetogreenColor // Warna default
                                    : neutral95Color,
                              ),
                              child: Text(
                                "Semua",
                                style: selectedKelaminDomba == null
                                    ? whitekTextStyle.copyWith(
                                        fontWeight: medium)
                                    : blackTextStyle.copyWith(
                                        fontWeight: medium),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    // Update the selectedKelaminDomba to 'Jantan'
                                    if (selectedKelaminDomba != 'Jantan') {
                                      setState(() {
                                        selectedKelaminDomba = 'Jantan';
                                      });
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor:
                                        selectedKelaminDomba == 'Jantan'
                                            ? bluetogreenColor
                                            : neutral95Color,
                                  ),
                                  child: Text(
                                    'Jantan',
                                    style: selectedKelaminDomba == 'Jantan'
                                        ? whitekTextStyle.copyWith(
                                            fontWeight: medium)
                                        : blackTextStyle.copyWith(
                                            fontWeight: medium),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    // Update the selectedKelaminDomba to 'Betina'
                                    if (selectedKelaminDomba != 'Betina') {
                                      setState(() {
                                        selectedKelaminDomba = 'Betina';
                                      });
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor:
                                        selectedKelaminDomba == 'Betina'
                                            ? bluetogreenColor
                                            : neutral95Color,
                                  ),
                                  child: Text(
                                    'Betina',
                                    style: selectedKelaminDomba == 'Betina'
                                        ? whitekTextStyle.copyWith(
                                            fontWeight: medium)
                                        : blackTextStyle.copyWith(
                                            fontWeight: medium),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Bobot (Kg)",
                        style: blackTextStyle.copyWith(
                          fontSize: 14,
                          letterSpacing: 0.4,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SfRangeSlider(
                        values: _values,
                        max: 250,
                        min: 0,
                        inactiveColor: neutral90Color,
                        interval: 10,
                        showTicks: false,
                        showLabels: false,
                        activeColor: bluetogreenColor,
                        startThumbIcon: Center(
                          child: Text(
                            '${_values.start.round()}',
                            style: filterTextStyle.copyWith(
                              fontSize: 10,
                              fontWeight: semiBold,
                              color: primary99Color,
                            ),
                          ),
                        ),
                        endThumbIcon: Center(
                          child: Text(
                            '${_values.end.round()}',
                            style: filterTextStyle.copyWith(
                              fontSize: 10,
                              fontWeight: semiBold,
                              color: primary99Color,
                            ),
                          ),
                        ),
                        onChanged: (dynamic newValues) {
                          setState(() {
                            _values = newValues;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      CustomFilledButton(
                        bgcolor: bluetogreenColor,
                        title: 'Terapkan',
                        textColor: TextStyle(
                          color: whiteColor,
                        ),
                        onPressed: () {
                           var getDomba = selectedSemua?.jenisDomba ?? "";
                          // var jenis = selectedJenisDomba!.jenisDomba;
                          // var kelamin = selectedKelaminDomba;
                          // var bobotMin = _values.start.round();
                          // var bobotMax = _values.end.round();

                          filterData(
                              getDomba);

                          widget.onFilterApplied(true);
                          Navigator.pop(context); // Tutup modal filter
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

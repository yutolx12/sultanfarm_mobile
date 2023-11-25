import 'package:flutter/material.dart';
import 'package:sultan_farm_mobile/Screens/monitoring_page.dart';
import 'package:sultan_farm_mobile/Theme.dart';

class CardDombaNonbreeding extends StatelessWidget {
  const CardDombaNonbreeding({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 15,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.only(left: 20),
                  child: Image.asset(
                      'assets/domba_paket_qurban.png'), // Replace with your image asset path
                ),
                const SizedBox(width: 20),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jenis Domba',
                        style: TextStyle(
                          fontFamily: 'poppins_medium',
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '40kg',
                        style: TextStyle(
                          fontFamily: 'poppins_medium',
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Jantan',
                        style: TextStyle(
                          fontFamily: 'poppins_semibold',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: const Text(
                    '1 Bulan',
                    style: TextStyle(
                      fontFamily: 'poppins_medium',
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Monitoring()),
                        );
                    // Add your monitoring logic here
                  },
                  icon: Icon(
                    Icons.monitor,
                    color: bluetogreenColor,
                  ),
                  label: Text(
                    'monitoring',
                    style: blackTextStyle.copyWith(
                      color: bluetogreenColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

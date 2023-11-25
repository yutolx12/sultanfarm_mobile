import 'package:flutter/material.dart';

class PlaceholderImageNotFound extends StatelessWidget {
  final double? width;
  final double? height;
  final double? fontsize;
  const PlaceholderImageNotFound({
    super.key,
    this.width = 100,
    this.height = 100,
    this.fontsize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width, // Adjust the size of the placeholder image
      height: height,
      color: Colors.grey, // Set the appropriate background color
      child: Center(
        child: Text(
          "Gambar Tidak Ditemukan", // Error message
          style: TextStyle(
            color: Colors.white, // Set the appropriate text color
            fontSize: fontsize,
            // Adjust the text size
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class ErrorPlaceholder extends StatelessWidget {
  const ErrorPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100, // Adjust the size of the placeholder image
      height: 100,
      color: Colors.grey, // Set the appropriate background color
      child: const Center(
        child: Text(
          "Gagal Memuat Gambar", // Error message
          style: TextStyle(
            color: Colors.white, // Set the appropriate text color
            fontSize: 16, // Adjust the text size
          ),
        ),
      ),
    );
  }
}

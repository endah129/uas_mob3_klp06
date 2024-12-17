import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  // Fungsi untuk membuka WhatsApp dengan pesan otomatis
  void _launchWhatsApp() async {
    const phoneNumber = '+6282339542002';  // Ganti dengan nomor WhatsApp Anda
    const message = 'Halo, saya membutuhkan bantuan dengan aplikasi simpan pinjam.';
    final url = 'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Tidak dapat membuka WhatsApp.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bantuan"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Cara Menggunakan Aplikasi:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "1. Masuk ke aplikasi menggunakan akun Anda.\n"
              "2. Setelah login, Anda akan diarahkan ke dashboard utama.\n"
              "3. Untuk menambahkan data anggota, pilih 'Input Data Anggota'.\n"
              "4. Untuk melihat pinjaman, pilih 'Data Pinjaman'.\n"
              "5. Untuk melihat pembayaran, pilih 'Data Pembayaran'.\n"
              "6. Jika ada kesulitan, Anda bisa mengakses halaman ini untuk bantuan.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              "Kontak Bantuan:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Jika Anda membutuhkan bantuan lebih lanjut, silakan hubungi kami di:\n"
              "WhatsApp: ",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _launchWhatsApp,
              child: const Text("Hubungi via WhatsApp"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Kembali"),
            ),
          ],
        ),
      ),
    );
  }
}

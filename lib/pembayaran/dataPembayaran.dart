import 'package:flutter/material.dart';
import 'package:mob3_uas_klp_06/pembayaran/inputPembayaran.dart';

class DataPembayaranScreen extends StatelessWidget {
  const DataPembayaranScreen({super.key});
// up
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Jumlah tab
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Data Pembayaran'),
          backgroundColor: Colors.blue.shade600,
          bottom: const TabBar(
            labelColor: Colors.white, // Warna teks untuk tab yang dipilih
            unselectedLabelColor:
                Colors.white70, // Warna teks untuk tab yang tidak dipilih
            indicatorColor: Colors.white, // Warna indikator di bawah tab
            tabs: [
              Tab(text: 'Data Pembayaran'), // Tab kiri
              Tab(text: 'Form Input Pembayaran'), // Tab kanan
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const Center(
              child: Text(
                'Belum ada data pembayaran.',
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
            ),
            InputPembayaran(),
          ],
        ),
      ),
    );
  }
}

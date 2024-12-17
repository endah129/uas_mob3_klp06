import 'package:flutter/material.dart';
import 'package:mob3_uas_klp_06/angsuran/data_angsuran.dart';
import 'package:mob3_uas_klp_06/angsuran/inputData_Angsuran.dart';

class DataAngsuran extends StatelessWidget {
  const DataAngsuran({super.key});
// up
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Jumlah tab
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Data Angsuran'),
          backgroundColor: Colors.blue.shade600,
          bottom: const TabBar(
            labelColor: Colors.white, // Warna teks untuk tab yang dipilih
            unselectedLabelColor:
                Colors.white70, // Warna teks untuk tab yang tidak dipilih
            indicatorColor: Colors.white, // Warna indikator di bawah tab
            tabs: [
              Tab(text: 'Data Angsuran'), // Tab kiri
              Tab(text: 'Form Input Angsuran'), // Tab kanan
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const Center(
              child: Text(
                'Belum ada data Angsuran.',
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
            ),
            InputdataAngsuran(),
          ],
        ),
      ),
    );
  }
}

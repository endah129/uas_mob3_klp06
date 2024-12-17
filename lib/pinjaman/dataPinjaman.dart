import 'package:flutter/material.dart';
import 'package:mob3_uas_klp_06/pinjaman/inputPinjaman.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataPinjamanScreen extends StatefulWidget {
  const DataPinjamanScreen({super.key});

  @override
  _DataPinjamanScreenState createState() => _DataPinjamanScreenState();
}

class _DataPinjamanScreenState extends State<DataPinjamanScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Data Pinjaman'),
          backgroundColor: Colors.blue.shade600,
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Data Pinjaman'),
              Tab(text: 'Form Input Pinjaman'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('pinjaman').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(child: Text('Terjadi kesalahan'));
                }
                final data = snapshot.data?.docs ?? [];
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final pinjaman = data[index].data() as Map<String, dynamic>;
                    return ListTile(
                      title: Text(pinjaman['nama']),
                      subtitle: Text(pinjaman['jumlah'].toString()),
                    );
                  },
                );
              },
            ),
            InputPinjaman(),
          ],
        ),
      ),
    );
  }
}

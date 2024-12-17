import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mob3_uas_klp_06/data_anggota/inputAnggota.dart';

class DataAnggotaScreen extends StatefulWidget {
  const DataAnggotaScreen({super.key});

  @override
  _DataAnggotaScreenState createState() => _DataAnggotaScreenState();
}

class _DataAnggotaScreenState extends State<DataAnggotaScreen> with SingleTickerProviderStateMixin {
  final List<Map<String, String>> _dataAnggota = [];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _tambahData(Map<String, String> data) {
    setState(() {
      _dataAnggota.add(data);
    });
  }

  Widget _buildClientListView() {
    return _dataAnggota.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.group_off_outlined,
                  size: 100,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'Belum Ada Data Anggota',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          )
        : ListView.builder(
            itemCount: _dataAnggota.length,
            itemBuilder: (context, index) {
              final anggota = _dataAnggota[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        anggota['nama'] ?? 'Nama Tidak Tersedia',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildDetailRow(Icons.credit_card, 'NIK', anggota['nik']),
                      _buildDetailRow(Icons.cake, 'Tanggal Lahir', anggota['tanggalLahir']),
                      _buildDetailRow(Icons.home, 'Alamat', anggota['alamat']),
                      _buildDetailRow(Icons.phone, 'No Kontak', anggota['noKontak']),
                    ],
                  ),
                ),
              );
            },
          );
  }

  Widget _buildBiodataSection() {
    final anggota = _dataAnggota[0];
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Informasi Pribadi',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 58, 146, 183),
              ),
            ),
            Divider(color: Colors.grey[300]),
            const SizedBox(height: 10),
            _buildDetailRow(
              Icons.credit_card,
              'NIK',
              anggota['nik'],
            ),
            _buildDetailRow(
              Icons.cake,
              'Tanggal Lahir',
              anggota['tanggalLahir'],
            ),
            _buildDetailRow(
              Icons.home,
              'Alamat',
              anggota['alamat'],
            ),
            _buildDetailRow(
              Icons.phone,
              'No Kontak',
              anggota['noKontak'],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: const Color.fromARGB(255, 58, 146, 183),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  value ?? 'Tidak Tersedia',
                  style: TextStyle(
                    color: Colors.grey[900],
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Anggota'),
        backgroundColor: const Color.fromARGB(255, 58, 146, 183),
        bottom: TabBar(
          labelColor: Colors.white, // Warna teks untuk tab yang dipilih
          unselectedLabelColor: Colors.white70, // Warna teks untuk tab yang tidak dipilih
          indicatorColor: Colors.white, // Warna indikator di bawah tab
          controller: _tabController,
          tabs: const [
            Tab(text: 'Client Data'),
            Tab(text: 'Submit Form'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ClientDataTab(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: InputDataAnggota(onSaveData: _tambahData),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ClientDataTab extends StatelessWidget {
  const ClientDataTab({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('anggota').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final data = snapshot.data?.docs;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: data == null || data.isEmpty
              ? const Center(child: Text('Tidak Ada Data Anggota', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)))
              : ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final memberData = data[index].data() as Map<String, dynamic>;
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: Colors.lightBlue[50],
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              memberData['nama'] ?? 'Nama Tidak Tersedia',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildDetailRow(Icons.card_membership, 'NIK', memberData['nik']),
                            _buildDetailRow(Icons.calendar_today, 'Tanggal Lahir', memberData['tanggalLahir']),
                            _buildDetailRow(Icons.home, 'Alamat', memberData['alamat']),
                            _buildDetailRow(Icons.phone, 'No Kontak', memberData['noKontak']),
                            const SizedBox(height: 8),
                            const Divider(),
                            Text(
                              'Tanggal Bergabung: ${memberData['tanggalBergabung'] ?? 'Tidak Tersedia'}',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueAccent),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              '$label: ${value ?? 'Tidak Tersedia'}',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
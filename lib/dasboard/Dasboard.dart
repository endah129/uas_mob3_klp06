import 'package:flutter/material.dart';
import 'package:mob3_uas_klp_06/UI/logout.dart';
import 'package:mob3_uas_klp_06/angsuran/data_angsuran.dart';
import 'package:mob3_uas_klp_06/dasboard/Dasboard.dart';
// navigasi
import 'package:mob3_uas_klp_06/dasboard/navigasi/help.dart';
import 'package:mob3_uas_klp_06/dasboard/navigasi/setting.dart';

// memanggil button
import 'package:mob3_uas_klp_06/data_anggota/dataAnggota.dart';
import 'package:mob3_uas_klp_06/pembayaran/dataPembayaran.dart';
import 'package:mob3_uas_klp_06/pinjaman/dataPinjaman.dart';



void main() {
  runApp(DashboardApp());
}

class DashboardApp extends StatelessWidget {
  const DashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'myPOS Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Control Panel'),
        backgroundColor: Colors.blue.shade600,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue.shade600,
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/profile.jpg'),
                    radius: 30,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Admin',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text(
                    'Online',
                    style: TextStyle(color: Colors.greenAccent),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () {
                // Navigasi ke halaman dashboard
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.group),
              title: const Text('Customers'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('User'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.question_answer),
              title: const Text('Help'),
              onTap: () {
                // Navigasi ke halaman help
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HelpPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Setting'),
              onTap: () {
                // Navigasi ke halaman Setting
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                );
              },
            ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LogoutPage()),
              );
            },
          ),

          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                children: [
                  DashboardCard(
                    icon: Icons.people,
                    title: 'Data Anggota',
                    count: 4,
                  ),
                  DashboardCard(
                    icon: Icons.attach_money, // Ikon untuk pinjaman
                    title: 'Data Pinjaman',
                    count: 3,
                  ),
                  DashboardCard(
                    icon: Icons.credit_card, // Ikon untuk angsuran
                    title: 'Data Angsuran',
                    count: 11,
                  ),
                ],
              ),
            ),
            // Menambahkan tombol untuk navigasi ke Data Anggota, Form Pinjaman, dan Form Pembayaran
            Container(
              margin: const EdgeInsets.only(top: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildButton(context, 'Data \n Anggota', Colors.blue, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DataAnggotaScreen()),
                    );
                  }),
                  const SizedBox(width: 10),
                  _buildButton(context, 'Form \n Pinjaman', Colors.green, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DataPinjamanScreen()),
                    );
                  }),
                   const SizedBox(width: 10),
                  _buildButton(context, 'Form \n Angsuran', Colors.purple, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DataAngsuran()),
                    );
                  }),
                  const SizedBox(width: 10),
                  _buildButton(context, 'Form \n Pembayaran', Colors.orange,
                      () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DataPembayaranScreen()),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(
      BuildContext context, String title, Color color, VoidCallback onPressed) {
    return Expanded(
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Sudut melengkung
          ),
          padding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 16.0), // Mengurangi horizontal padding
        ),
        onPressed: onPressed,
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center, // Membuat teks terpusat
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final int count;

  const DashboardCard({super.key, required this.icon, required this.title, required this.count});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 50, color: Colors.deepPurple),
          const SizedBox(height: 10),
          Text(
            '$count',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

// List<Anggota> dataAnggota = [];

// class DataAnggotaScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2, // Jumlah tab
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Data Anggota'),
//           backgroundColor: Colors.blue.shade600,
//           bottom: TabBar(
//             labelColor: Colors.white, // Warna teks untuk tab yang dipilih
//             unselectedLabelColor: Colors.white70, // Warna teks untuk tab yang tidak dipilih
//             indicatorColor: Colors.white, // Warna indikator di bawah tab
//             tabs: [
//               Tab(text: 'Data Anggota'), // Tab kiri
//               Tab(text: 'Input Anggota'), // Tab kanan
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             // Tab "Data Anggota"
//             dataAnggota.isEmpty
//                 ? Center(
//                     child: Text(
//                       'Belum ada data anggota.',
//                       style: TextStyle(fontSize: 20, color: Colors.grey),
//                     ),
//                   )
//                 : ListView.builder(
//                     itemCount: dataAnggota.length,
//                     itemBuilder: (context, index) {
//                       final anggota = dataAnggota[index];
//                       return Card(
//                         margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                         child: ListTile(
//                           leading: CircleAvatar(
//                             child: Text(anggota.nama[0].toUpperCase()),
//                           ),
//                           title: Text(anggota.nama),
//                           subtitle: Text(
//                             'Umur: ${anggota.umur}, Alamat: ${anggota.alamat},\n'
//                             'No Kontak: ${anggota.noKontak}, Bergabung: ${anggota.tanggalBergabung}',
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//             // Tab "Input Anggota"
//             InputAnggota(),
//           ],
//         ),
//       ),
//     );
//   }
// }

class InputPinjamanScreen extends StatelessWidget {
  const InputPinjamanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Pinjaman'),
        backgroundColor: Colors.green,
      ),
      body: const Center(
        child: Text(
          'Form untuk menginput pinjaman',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class InputdataAngsuran extends StatelessWidget {
  const InputdataAngsuran({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Angsuran'),
        backgroundColor: Colors.green,
      ),
      body: const Center(
        child: Text(
          'Form untuk menginput Angsuran',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class InputPembayaranScreen extends StatelessWidget {
  const InputPembayaranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Pembayaran'),
        backgroundColor: Colors.orange,
      ),
      body: const Center(
        child: Text(
          'Form untuk menginput pembayaran',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

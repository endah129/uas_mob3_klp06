import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InputPinjaman extends StatelessWidget {
  final TextEditingController tanggalPinjamanController =
      TextEditingController();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController nomorIdentitasController =
      TextEditingController();
  final TextEditingController jumlahPinjamanController =
      TextEditingController();

  InputPinjaman({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Form Pinjaman',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade800,
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildTextField(
                    context: context,
                    label: 'Nama Lengkap',
                    hint: 'Masukkan nama lengkap',
                    icon: Icons.person,
                    controller: namaController,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    context: context,
                    label: 'Nomor Identitas',
                    hint: 'Masukkan nomor identitas',
                    icon: Icons.perm_identity,
                    controller: nomorIdentitasController,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    context: context,
                    label: 'Jumlah Pinjaman',
                    hint: 'Masukkan jumlah pinjaman',
                    icon: Icons.attach_money,
                    controller: jumlahPinjamanController,
                  ),
                  const SizedBox(height: 16),
                  _buildDateField(
                    context: context,
                    controller: tanggalPinjamanController,
                    label: 'Tanggal Pinjaman',
                    hint: 'Pilih tanggal',
                    icon: Icons.calendar_today,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () async {
                      // Validasi input
                      if (_validateFields(context)) {
                        await _saveDataToFirestore();
                        _showDialog(context, 'Data berhasil disimpan!', true);
                      } else {
                        _showDialog(
                            context, 'Ada data yang belum diisi!', false);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade600,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Simpan',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _validateFields(BuildContext context) {
    if (namaController.text.isEmpty) return false;
    if (nomorIdentitasController.text.isEmpty) return false;
    if (jumlahPinjamanController.text.isEmpty) return false;
    if (tanggalPinjamanController.text.isEmpty) return false;
    return true;
  }

  Widget _buildTextField({
    required BuildContext context,
    required String label,
    required String hint,
    required IconData icon,
    required TextEditingController controller,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildDateField({
    required BuildContext context,
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: TextField(
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101),
          );
          if (pickedDate != null) {
            String formattedDate =
                "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
            controller.text = formattedDate; // Menyimpan tanggal yang dipilih
          }
        },
      ),
    );
  }

  void _showDialog(BuildContext context, String message, bool isSuccess) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          contentPadding: const EdgeInsets.all(20.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isSuccess ? Icons.check_circle_outline : Icons.error_outline,
                color: isSuccess ? Colors.green : Colors.red,
                size: 50,
              ),
              const SizedBox(height: 15),
              Text(
                message,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
                child: const Text('OK', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveDataToFirestore() async {
    CollectionReference pinjaman =
        FirebaseFirestore.instance.collection('pinjaman');

    await pinjaman.add({
      'nama': namaController.text,
      'nomor_identitas': nomorIdentitasController.text,
      'jumlah_pinjaman': jumlahPinjamanController.text,
      'tanggal_pinjaman': tanggalPinjamanController.text,
    });
  }
}

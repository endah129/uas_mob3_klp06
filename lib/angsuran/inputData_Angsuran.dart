import 'package:flutter/material.dart';

class InputdataAngsuran extends StatelessWidget {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController nomorIdentitasController =
      TextEditingController();
  final TextEditingController pinjamanController = TextEditingController();
  final TextEditingController pembayaranController = TextEditingController();
  final TextEditingController tanggalPembayaranController =
      TextEditingController();

  InputdataAngsuran({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Menghapus tombol kembali
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Isi Data Angsuran',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: namaController,
                  label: 'Nama Lengkap',
                  hint: 'Masukkan nama lengkap Anda',
                  icon: Icons.person,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: nomorIdentitasController,
                  label: 'Nomor Identitas',
                  hint: 'Masukkan nomor identitas Anda',
                  icon: Icons.perm_identity,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: pinjamanController,
                  label: 'Jumlah Angsuran',
                  hint: 'Masukkan jumlah Angsuran',
                  icon: Icons.attach_money,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: pembayaranController,
                  label: 'Jumlah Pembayaran Angsuran',
                  hint: 'Masukkan jumlah pembayaran Angsuran',
                  icon: Icons.payment,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                _buildDateField(
                  context: context,
                  controller: tanggalPembayaranController,
                  label: 'Tanggal Angsuran',
                  hint: 'Pilih tanggal angsuran',
                  icon: Icons.calendar_today,
                ),
                const SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Validasi input
                      if (_validateFields(context)) {
                        _showDialog(context, 'Data berhasil disimpan!', true);
                      } else {
                        _showDialog(
                            context, 'Ada data yang belum diisi!', false);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade600,
                      padding:
                          const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
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
    return TextField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          // Format tanggal yang dipilihtfcfcrfcf
          String formattedDate =
              "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
          controller.text = formattedDate;
        }
      },
    );
  }

  bool _validateFields(BuildContext context) {
    if (namaController.text.isEmpty) return false;
    if (nomorIdentitasController.text.isEmpty) return false;
    if (pinjamanController.text.isEmpty) return false;
    if (pembayaranController.text.isEmpty) return false;
    if (tanggalPembayaranController.text.isEmpty) return false;
    return true;
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
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
}

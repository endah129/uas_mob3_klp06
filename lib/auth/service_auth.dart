import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mob3_uas_klp_06/UI/login.dart';
import 'package:mob3_uas_klp_06/dasboard/Dasboard.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signup({
    required String username,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update nama pengguna
      await userCredential.user?.updateDisplayName(username);

      _showSnackBar(
        context: context,
        message: 'Registrasi berhasil!',
        color: Colors.green.shade400,
        icon: Icons.check_circle_outline,
      );

      await Future.delayed(const Duration(milliseconds: 1000));

      // Navigasi ke layar login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } on FirebaseAuthException catch (e) {
      String message = _getAuthErrorMessage(e.code);
      _showSnackBar(
        context: context,
        message: message,
        color: Colors.red.shade400,
        icon: Icons.error_outline,
      );
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  Future<void> signin({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      _showSnackBar(
        context: context,
        message: 'Login berhasil!',
        color: Colors.green.shade400,
        icon: Icons.check_circle_outline,
      );

      await Future.delayed(const Duration(milliseconds: 1000));

      // Navigasi ke dashboard
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardScreen()),
      );
    } on FirebaseAuthException catch (e) {
      String message = _getAuthErrorMessage(e.code);
      _showSnackBar(
        context: context,
        message: message,
        color: Colors.red.shade400,
        icon: Icons.error_outline,
      );
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  Future<void> forgotPassword({
    required String email,
    required BuildContext context,
  }) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);

      _showSnackBar(
        context: context,
        message: "Email untuk reset password telah dikirim!",
        color: Colors.green.shade400,
        icon: Icons.check_circle_outline,
      );
    } on FirebaseAuthException catch (e) {
      String message = _getAuthErrorMessage(e.code);
      _showSnackBar(
        context: context,
        message: message,
        color: Colors.red.shade400,
        icon: Icons.error_outline,
      );
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  // Fungsi untuk memperbarui password pengguna
  Future<void> resetPassword({
    required String email,
    required String newPassword,
    required BuildContext context,
  }) async {
    try {
      User? user = _auth.currentUser;

      if (user != null && user.email == email) {
        await user.updatePassword(newPassword);

        _showSnackBar(
          context: context,
          message: 'Password berhasil direset!',
          color: Colors.green.shade400,
          icon: Icons.check_circle_outline,
        );
      } else {
        _showSnackBar(
          context: context,
          message: 'Email tidak cocok dengan pengguna yang masuk!',
          color: Colors.red.shade400,
          icon: Icons.error_outline,
        );
      }
    } on FirebaseAuthException catch (e) {
      String message = _getAuthErrorMessage(e.code);
      _showSnackBar(
        context: context,
        message: message,
        color: Colors.red.shade400,
        icon: Icons.error_outline,
      );
    } catch (e) {
      debugPrint('Error: $e');
      _showSnackBar(
        context: context,
        message: 'Terjadi kesalahan. Coba lagi nanti.',
        color: Colors.red.shade400,
        icon: Icons.error_outline,
      );
    }
  }

  /// Menampilkan SnackBar
  void _showSnackBar({
    required BuildContext context,
    required String message,
    required Color color,
    required IconData icon,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          width: 180,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 18,
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        duration: const Duration(milliseconds: 2000),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.45,
          left: 120,
          right: 120,
        ),
      ),
    );
  }
  // Menambahkan fungsi logout
  static Future<void> logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut(); // Log out dari Firebase

      // Arahkan pengguna ke halaman login setelah logout berhasil
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } catch (e) {
      debugPrint('Logout error: $e');
      // Menampilkan snack bar jika logout gagal
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal Logout: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }


  /// Mendapatkan pesan error dari kode FirebaseAuthException
  String _getAuthErrorMessage(String code) {
    switch (code) {
      case 'weak-password':
        return 'Password terlalu lemah \n Setidaknya 8 karakter';
      case 'email-already-in-use':
        return 'Email sudah terdaftar';
      case 'invalid-email':
        return 'Email tidak valid';
      case 'user-not-found':
        return 'Email tidak terdaftar';
      case 'wrong-password':
      case 'invalid-credential':
        return 'Password salah';
      case 'too-many-requests':
        return 'Terlalu banyak percobaan. Silakan coba lagi nanti';
      default:
        return 'Terjadi kesalahan. Silakan coba lagi.';
    }
  }
}

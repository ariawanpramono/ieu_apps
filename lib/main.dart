import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Variable baru menyimpan user
  String namaUser = "Budi";

  final PageController _pageController = PageController(
    viewportFraction: 0.9,
    initialPage: 1000
    );
  Timer? _timer; // Mulai dari angka besar agar langsung bisa digeser ke kiri/kanan

  @override
  void initState() {
    super.initState();
    // Nyalakan jam setiap 3 detik
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    });
  }

@override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi E-Learning',
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch},
      ),
      home: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Text('Welcome $namaUser'),
          backgroundColor: Colors.grey[100],
          foregroundColor: Colors.black,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Kelas Akan Datang',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            
            SizedBox(
              height: 180, 
              child: PageView.builder(
                // Mulai dari angka besar agar langsung bisa digeser ke kiri/kanan
                controller: _pageController, 

                // Baris "itemCount" dihapus agar jumlah layarnya jadi tak terhingga

                itemBuilder: (context, index) {
                  // Gunakan Modulo (%) untuk mengulang 5 jadwal kelas
                  final int jumlahJadwal = 5;
                  final int indexAsli = index % jumlahJadwal;

                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        )
                      ],
                    ),
                    child: Center(
                      child: Text(
                        // Kita gunakan indexAsli agar tulisannya selalu berulang dari 1 sampai 5
                        'Jadwal Kelas ${indexAsli + 1}\n(08:00 - 10:00)',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Agar jarak antar kotak rata
              children: [
                // 3 kotak menu
                _buildMenuIcon(Icons.home_work, 'Home Work', Colors.orange),
                _buildMenuIcon(Icons.quiz, 'Quiz', Colors.blue),
                _buildMenuIcon(Icons.assignment, 'Exam', Colors.red),
                        ],
                      ),
                    ),
                ],
        ),
        // Slot khusus di bawah body
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed, // Agar icon tidak goyang saat diklik
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: 'News'),
            BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notif'), // Ide tambahan: Notifikasi
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ), //BottomNavbar
      ),
    );
  }
  // Ini adalah "cetakan" untuk kotak menu Anda
  Widget _buildMenuIcon(IconData icon, String label, Color warna) {
  return Column(
    children: [
      Container(
        width: 80, // Lebar kotak
        height: 80, // Tinggi kotak
        decoration: BoxDecoration(
          color: warna.withOpacity(0.1), // Warna background transparan tipis
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: warna, width: 2), // Garis pinggir kotak
        ),
        child: Icon(icon, size: 40, color: warna),
      ),
      const SizedBox(height: 8),
      Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      ),
    ],
  );
  } // _buildMenuIcon

} //MyAppState extends State<MyApp>
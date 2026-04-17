import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:async';
import 'schedule_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  String namaUser = "Budi";

  final PageController _pageController = PageController(
    viewportFraction: 0.9,
    initialPage: 1000,
  );
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      _pageController.nextPage
      (
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
      if (_pageController.hasClients) 
      {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  // 1. KITA BUAT DAFTAR HALAMANNYA MENJADI GETTER AGAR BISA MEMBACA FUNGSI DI DALAM CLASS
  List<Widget> get _widgetOptions => <Widget>[
        _buildDashboard(),                           // Index 0: Memanggil fungsi Dashboard di bawah
        SchedulePage(),                        // Index 1: Memanggil file schedule_page.dart
        const Center(child: Text('Profile Page')),   // Index 2: Halaman Profil sementara
      ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
        
        // 2. KUNCI PERUBAHANNYA ADA DI SINI: Body sekarang menyesuaikan index yang diklik!
        body: _widgetOptions.elementAt(_selectedIndex), 

        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'Schedule'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  // --- KODE DASHBOARD ANDA SAYA BUNGKUS KE DALAM FUNGSI INI ---
  Widget _buildDashboard() {
    return Column(
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
            controller: _pageController,
            itemBuilder: (context, index) {
              final int jumlahJadwal = 3;
              final int indexAsli = index % jumlahJadwal;
              List<String> daftarGambar = [
                'assets/kelas1.jpg',
                'assets/kelas2.jpg',
                'assets/kelas3.jpg',
              ];

              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: AssetImage(daftarGambar[indexAsli]),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 50),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildMenuIcon(Icons.home_work, 'Lesson', Colors.green),
              _buildMenuIcon(Icons.quiz, 'Quiz', Colors.blue),
              _buildMenuIcon(Icons.assignment, 'Exam', Colors.red),
            ],
          ),
        ),
      ],
    );
  }

  // --- FUNGSI KOTAK MENU ANDA ---
  Widget _buildMenuIcon(IconData icon, String label, Color warna) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: warna.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: warna, width: 2),
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
  }
}
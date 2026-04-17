import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jadwal Kelas'),
        backgroundColor: Colors.blueAccent, // Sesuaikan dengan warna tema aplikasi
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Ini adalah Widget Kalendernya
          TableCalendar(
            firstDay: DateTime.utc(2024, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay; 
              });
              // Nanti di sini kita panggil fungsi untuk menampilkan daftar pelajaran
              print('Tanggal diklik: $selectedDay'); 
            },
            calendarFormat: CalendarFormat.month,
            headerStyle: const HeaderStyle(
              formatButtonVisible: false, // Menyembunyikan tombol '2 weeks' dsb agar rapi
              titleCentered: true,
            ),
            calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.blueAccent,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Area Kosong di Bawah Kalender untuk Menampilkan Detail Lesson Nanti
          Expanded(
            child: Center(
              child: Text(
                _selectedDay == null 
                  ? 'Pilih tanggal untuk melihat jadwal' 
                  : 'Menampilkan jadwal untuk tanggal:\n${_selectedDay!.day}-${_selectedDay!.month}-${_selectedDay!.year}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
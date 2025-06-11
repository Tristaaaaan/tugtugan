import 'package:flutter/material.dart';

class BookAppointmentScreen extends StatelessWidget {
  const BookAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data and Preferences"),
      ),
      body: const Center(
        child: Text(
          "Book Appointment",
        ),
      ),
    );
  }
}

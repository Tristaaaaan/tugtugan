import 'package:flutter/material.dart';

import '../../../book_appointment/domain/entities/appointment_entity.dart';
import 'appointment_image_container.dart';

class AppointmentContainer extends StatelessWidget {
  final AppointmentEntity appointment;
  const AppointmentContainer({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(18),
          ),
          color: Colors.white,
        ),
        child: Column(
          children: [
            AppointmentImageContainer(
              images: appointment.studioImage ?? [],
              date: appointment.appoinmentDay,
              month: appointment.appoinmentMonth,
              time: appointment.appoinmentTime,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appointment.studioName ?? 'Unknown Studio',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                          appointment.bookingNumber ?? 'Unknown Booking Number',
                          style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withValues(alpha: 0.2),
                    ),
                    child: Icon(Icons.chevron_right,
                        size: 30, color: Theme.of(context).colorScheme.primary),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

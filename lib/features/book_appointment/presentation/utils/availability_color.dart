import 'package:flutter/material.dart';

import '../screen/book_appointment.dart';

Color getAvailabilityColor(Availability availability) {
  switch (availability) {
    case Availability.available:
      return const Color(0xff5F7A6F); // Muted green

    case Availability.occupied:
      return const Color(0xff9A6868); // Muted red
  }
}

import '../../../presentation/screen/book_appointment.dart';

class AppointmentTime {
  final String time;
  final Availability availability;

  const AppointmentTime({
    required this.time,
    required this.availability,
  });
}

final List<AppointmentTime> dummyTimes = [
  const AppointmentTime(
    time: '8:00 AM',
    availability: Availability.available,
  ),
  const AppointmentTime(
    time: '9:00 AM',
    availability: Availability.available,
  ),
  const AppointmentTime(
    time: '10:00 AM',
    availability: Availability.occupied,
  ),
  const AppointmentTime(
    time: '11:00 AM',
    availability: Availability.occupied,
  ),
  const AppointmentTime(
    time: '12:00 PM',
    availability: Availability.available,
  ),
  const AppointmentTime(
    time: '1:00 PM',
    availability: Availability.available,
  ),
  const AppointmentTime(
    time: '2:00 PM',
    availability: Availability.occupied,
  ),
  const AppointmentTime(
    time: '3:00 PM',
    availability: Availability.occupied,
  ),
  const AppointmentTime(
    time: '4:00 PM',
    availability: Availability.available,
  ),
  const AppointmentTime(
    time: '5:00 PM',
    availability: Availability.available,
  ),
  const AppointmentTime(
    time: '6:00 PM',
    availability: Availability.occupied,
  ),
  const AppointmentTime(
    time: '7:00 PM',
    availability: Availability.available,
  ),
  const AppointmentTime(
    time: '8:00 PM',
    availability: Availability.available,
  ),
  const AppointmentTime(
    time: '9:00 PM',
    availability: Availability.available,
  ),
  const AppointmentTime(
    time: '10:00 PM',
    availability: Availability.available,
  ),
];

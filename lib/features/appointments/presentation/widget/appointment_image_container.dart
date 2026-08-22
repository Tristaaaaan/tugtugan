import 'package:flutter/material.dart';

class AppointmentImageContainer extends StatelessWidget {
  final List<String> images;
  final String month;
  final String date;
  final String time;

  const AppointmentImageContainer({
    super.key,
    required this.images,
    required this.month,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.redAccent,
        image: images.isNotEmpty
            ? DecorationImage(
                image: NetworkImage(images.first),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: Stack(
        children: [
          Positioned(
            top: 16,
            left: 16,
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: .6),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        month,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        date,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 8),
                  const VerticalDivider(
                    color: Colors.black,
                    thickness: 1,
                  ),
                  const SizedBox(width: 8),
                  Center(
                    child: Text(
                      time,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
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
}

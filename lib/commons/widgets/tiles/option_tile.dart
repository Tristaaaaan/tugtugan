import 'package:flutter/material.dart';

class OptionTile extends StatelessWidget {
  final Function onTap;
  const OptionTile({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        onTap();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.logout,
                ),
                SizedBox(width: 15),
                Text(
                  'Log Out',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Icon(Icons.chevron_right)
          ],
        ),
      ),
    );
  }
}

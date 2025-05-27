import 'package:flutter/material.dart';
import 'package:tugtugan/commons/widgets/textfields/regular_textfield.dart';

class StudioRegistration extends StatelessWidget {
  const StudioRegistration({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController studioNameController = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RegularTextField(controller: studioNameController),
            const SizedBox(height: 18),
            RegularTextField(controller: studioNameController),
            const SizedBox(height: 18),
            RegularTextField(controller: studioNameController),
            const SizedBox(height: 18),
            RegularTextField(controller: studioNameController),
            const SizedBox(height: 18),
            RegularTextField(controller: studioNameController),
            const SizedBox(height: 18),
            RegularTextField(controller: studioNameController),
            const SizedBox(height: 18),
            RegularTextField(controller: studioNameController),
            const SizedBox(height: 18),
            RegularTextField(controller: studioNameController),
          ],
        ),
      ),
    );
  }
}

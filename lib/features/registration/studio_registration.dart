import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:tugtugan/commons/widgets/buttons/regular_button.dart';
import 'package:tugtugan/commons/widgets/textfields/regular_textfield.dart';
import 'package:tugtugan/features/studios/studio_services.dart';

class StudioRegistration extends StatelessWidget {
  const StudioRegistration({super.key});

  @override
  Widget build(BuildContext context) {
    final StudioServices studioService = StudioServices();
    final TextEditingController studioNameController = TextEditingController();
    final TextEditingController studioAddressController =
        TextEditingController();
    final TextEditingController contactNumberController =
        TextEditingController();
    final TextEditingController studioDescriptionController =
        TextEditingController();

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                RegularTextField(
                  key: const Key("studioName"),
                  controller: studioNameController,
                  icon: Icons.music_note,
                  title: "Studio Name",
                  hintText: "Enter your studio name",
                ),
                const SizedBox(height: 18),
                RegularTextField(
                  key: const Key("studioAddress"),
                  controller: studioAddressController,
                  icon: Icons.location_on,
                  title: "Studio Address",
                  hintText: "Enter your studio address",
                ),
                const SizedBox(height: 18),
                RegularTextField(
                  key: const Key("contactNumber"),
                  controller: contactNumberController,
                  icon: Icons.phone,
                  title: "Contact Number",
                  hintText: "Enter your contact number",
                  numbersOnly: true,
                ),
                const SizedBox(height: 24),
                RegularButton(
                  key: const Key("registerStudioButton"),
                  text: "Register Studio",
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  textColor: Theme.of(context).colorScheme.surface,
                  withoutLoading: true,
                  withIcon: false,
                  onTap: () async {
                    final bool areTextFieldsEmpty = checkTextFields(
                      studioNameController,
                      studioAddressController,
                      contactNumberController,
                    );

                    developer.log(
                      "Are text fields empty? $areTextFieldsEmpty",
                    );

                    if (areTextFieldsEmpty) {
                      // Show an error message or warning
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please fill in all fields."),
                        ),
                      );
                      return;
                    }

                    // StudioModel studio = StudioModel(
                    //   id: "",
                    //   description: studioDescriptionController.text,
                    //   imageUrl: "",
                    //   location:
                    //       const GeoPoint(0, 0), // Placeholder for location
                    //   followers: [],
                    //   address: studioAddressController.text,
                    //   studioName: studioNameController.text,
                    // );

                    // await studioService.addStudio(studio);
                  },
                  buttonKey: "registerStudio",
                  suffixIcon: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

bool checkTextFields(
  TextEditingController studioNameController,
  TextEditingController studioAddressController,
  TextEditingController contactNumberController,
) {
  return (studioNameController.text.isEmpty ||
      studioAddressController.text.isEmpty ||
      contactNumberController.text.isEmpty);
}

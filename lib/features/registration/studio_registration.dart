import 'dart:developer' as developer;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tugtugan/commons/widgets/buttons/regular_button.dart';
import 'package:tugtugan/commons/widgets/textfields/regular_textfield.dart';
import 'package:tugtugan/core/appmodels/studio_model.dart';
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RegularTextField(
                  controller: studioNameController,
                  icon: Icons.music_note,
                  title: "Studio Name",
                  hintText: "Enter your studio name",
                ),
                const SizedBox(height: 18),
                RegularTextField(
                  controller: studioAddressController,
                  icon: Icons.location_on,
                  title: "Studio Address",
                  hintText: "Enter your studio address",
                ),
                const SizedBox(height: 18),
                RegularTextField(
                  controller: contactNumberController,
                  icon: Icons.phone,
                  title: "Contact Number",
                  hintText: "Enter your contact number",
                  numbersOnly: true,
                ),
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.bottomRight,
                  child: RegularButton(
                    text: "Register Studio",
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    textColor: Theme.of(context).colorScheme.surface,
                    withoutLoading: true,
                    withIcon: false,
                    onTap: () async {
                      developer
                          .log("Studio Name: ${studioNameController.text}");
                      developer.log(
                          "Studio Address: ${studioAddressController.text}");
                      developer.log(
                          "Contact Number: ${contactNumberController.text}");
                      developer.log(
                        "Studio Description: ${studioDescriptionController.text}",
                      );
                      StudioModel studio = StudioModel(
                        id: "",
                        description: studioDescriptionController.text,
                        imageUrl: "",
                        location:
                            const GeoPoint(0, 0), // Placeholder for location
                        followers: [],
                        address: studioAddressController.text,
                        studioName: studioNameController.text,
                      );

                      await studioService.addStudio(studio);
                    },
                    buttonKey: "registerStudio",
                    suffixIcon: false,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

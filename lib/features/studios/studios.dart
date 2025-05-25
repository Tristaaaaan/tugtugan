import 'package:flutter/material.dart';
import 'package:tugtugan/commons/widgets/buttons/regular_button.dart';
import 'package:tugtugan/commons/widgets/text/expandable_text.dart';
import 'package:tugtugan/core/apptext/app_text.dart';

class Studio extends StatelessWidget {
  const Studio({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            "assets/icons/2023-09-11.png",
                            fit: BoxFit.cover,
                            height: 400,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 425,
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            width: 60,
                            height: 60,
                            margin: const EdgeInsets.only(
                              right: 15,
                            ),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    "Tristan Studios",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const ExpandableText(
                    text:
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna alLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua... Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua...iqua...',
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          AppText.price,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "\$199",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ]),
                  RegularButton(
                    text: AppText.bookNow,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    textColor: Theme.of(context).colorScheme.surface,
                    buttonKey: "bookButton",
                    withIcon: false,
                  ),
                ],
              ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

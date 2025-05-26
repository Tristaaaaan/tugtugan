import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tugtugan/commons/widgets/buttons/regular_button.dart';
import 'package:tugtugan/commons/widgets/text/expandable_text.dart';
import 'package:tugtugan/core/apptext/app_text.dart';
import 'package:tugtugan/features/authentication/auth_services.dart';

class Studio extends ConsumerWidget {
  const Studio({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AuthServices authServices = AuthServices();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(
                Icons.logout,
                color: Colors.black,
              ),
              onPressed: () async {
                authServices.signOutAccount(ref);
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          "assets/icons/Rectangle990.png",
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
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Lorem ipsum",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => context.go('/maps?name=Studio'),
                      child: Text("Show map",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          )),
                    )
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.tertiaryContainer,
                          Theme.of(context).colorScheme.tertiary
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds),
                      blendMode: BlendMode.srcIn,
                      child: Icon(
                        Icons.star,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Text("4.5 (12 reviews)"),
                  ],
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
          ),
        ),
        bottomNavigationBar: IntrinsicHeight(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
          ),
        ),
        // bottomSheet: Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        //       const Text(
        //         AppText.price,
        //         style: TextStyle(
        //           fontSize: 12,
        //           fontWeight: FontWeight.w500,
        //         ),
        //       ),
        //       Text(
        //         "\$199",
        //         style: TextStyle(
        //           fontSize: 24,
        //           fontWeight: FontWeight.bold,
        //           color: Theme.of(context).colorScheme.secondary,
        //         ),
        //       ),
        //     ]),
        //     RegularButton(
        //       text: AppText.bookNow,
        //       backgroundColor: Theme.of(context).colorScheme.primary,
        //       textColor: Theme.of(context).colorScheme.surface,
        //       buttonKey: "bookButton",
        //       withIcon: false,
        //     ),
        //   ],
        // ),
      ),
    );
  }
}

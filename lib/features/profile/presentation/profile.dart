import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../commons/widgets/avatars/image_avatar.dart';
import '../../../commons/widgets/tiles/option_tile.dart';
import '../../authentication/auth_services.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AuthServices authServices = AuthServices();
    final FirebaseAuth auth = FirebaseAuth.instance;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverList(
              delegate: SliverChildListDelegate([
            Column(children: [
              Container(
                height: 180,
                margin:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Stack(
                  children: [
                    Row(
                      children: [
                        ImageAvatar(imageUrl: auth.currentUser!.photoURL!),
                        const SizedBox(width: 20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 25,
                              ),
                              "${auth.currentUser!.displayName}",
                            ),
                            Text(
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                              "${auth.currentUser!.email}",
                            ),
                            const SizedBox(height: 12),
                            TextButton(
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                              ),
                              onPressed: () {},
                              child: Text(
                                "Edit Profile",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              OptionTile(
                onTap: () => authServices.signOutAccount(ref),
              ),
              OptionTile(
                onTap: () => authServices.signOutAccount(ref),
              ),
              OptionTile(
                onTap: () => authServices.signOutAccount(ref),
              ),
              OptionTile(
                onTap: () => authServices.signOutAccount(ref),
              ),
              OptionTile(
                onTap: () => authServices.signOutAccount(ref),
              ),
              OptionTile(
                onTap: () => authServices.signOutAccount(ref),
              ),
              OptionTile(
                onTap: () => authServices.signOutAccount(ref),
              ),
              OptionTile(
                onTap: () => authServices.signOutAccount(ref),
              ),
              OptionTile(
                onTap: () => authServices.signOutAccount(ref),
              ),
              OptionTile(
                onTap: () => authServices.signOutAccount(ref),
              ),
              OptionTile(
                onTap: () => authServices.signOutAccount(ref),
              ),
              OptionTile(
                onTap: () => authServices.signOutAccount(ref),
              ),
              OptionTile(
                onTap: () => authServices.signOutAccount(ref),
              ),
              OptionTile(
                onTap: () => authServices.signOutAccount(ref),
              ),
            ]),
          ]))
        ],
      ),
    );
  }
}

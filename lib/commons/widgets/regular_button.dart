import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tugtugan/commons/widgets/loading_state_notifier.dart';
import 'package:tugtugan/core/appimages/app_images.dart';

class RegularButton extends ConsumerWidget {
  final bool? withIcon;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final String buttonKey;
  final bool? withoutLoading;
  final void Function()? onTap;
  const RegularButton({
    super.key,
    this.withIcon = true,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    required this.buttonKey,
    this.withoutLoading = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading =
        ref.watch(regularButtonLoadingProvider)[buttonKey] ?? false;
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(
        horizontal: 25,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: GestureDetector(
          onTap: withoutLoading!
              ? onTap
              : isLoading
                  ? () {}
                  : () async {
                      onTap!();
                    },
          child: Row(
            children: [
              if (withIcon == true)
                SvgPicture.asset(
                  AppImages.googleLogo,
                  height: 20,
                  width: 20,
                ),
              Expanded(
                child: isLoading
                    ? Center(
                        child: LoadingAnimationWidget.stretchedDots(
                          color: withIcon == true
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.surface,
                          size: 30,
                        ),
                      )
                    : Text(
                        text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: textColor,
                        ),
                      ),
              ),
              if (withIcon == true)
                const SizedBox(
                  width: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

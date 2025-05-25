import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tugtugan/commons/widgets/buttons/loading_state_notifier.dart';
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
      height: 55,
      width: 200,
      // margin: const EdgeInsets.symmetric(
      //   horizontal: 25,
      // ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
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
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            text,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Icon(
                            Icons.chevron_right,
                            color: Theme.of(context).colorScheme.surface,
                          )
                        ],
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

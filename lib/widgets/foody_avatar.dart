import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../utils/foody_default_shadow.dart';

class FoodyAvatar extends StatelessWidget {
  const FoodyAvatar({
    super.key,
    this.avatarPath,
    this.avatarUrl,
    this.onTap,
    this.showShadow = true,
    this.height = 50,
    this.width = 50,
    this.padding = 15,
  }) : assert(avatarPath == null || avatarUrl == null,
            'You cannot set avatarPath and avatarUrl at the same time');

  final String? avatarPath;
  final String? avatarUrl;
  final void Function()? onTap;
  final bool showShadow;
  final double height;
  final double width;
  final double padding;

  @override
  Widget build(BuildContext context) {
    Widget inkWell([Widget? child]) => InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap != null
              ? () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  onTap!.call();
                }
              : null,
          child: child,
        );

    Widget inkWellInOverlay() => Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: inkWell(),
          ),
        );

    Widget circularImage(image) => ClipOval(
          child: Stack(
            children: [
              image,
              inkWellInOverlay(),
            ],
          ),
        );

    Widget defaultAvatarContainer() => Container(
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).primaryColor.withOpacity(0.2),
          ),
          child: Image.asset(
            'assets/images/user.png',
            color: Theme.of(context).primaryColor,
            width: width,
            height: height,
          ),
        );

    Widget defaultAvatar() => inkWell(defaultAvatarContainer());

    Widget localAvatar() => circularImage(
          Image.file(
            File(avatarPath!),
            fit: BoxFit.cover,
            width: width + 30,
            height: height + 30,
          ),
        );

    Widget remoteAvatar() => circularImage(
          CachedNetworkImage(
            fadeInDuration: const Duration(milliseconds: 300),
            fadeOutDuration: const Duration(milliseconds: 300),
            imageUrl: avatarUrl!,
            fit: BoxFit.cover,
            width: width + 30,
            height: height + 30,
            placeholder: (_, __) => defaultAvatarContainer(),
            errorWidget: (_, __, ___) => defaultAvatarContainer(),
          ),
        );

    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.all(showShadow ? 10 : 0),
        child: Ink(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: showShadow ? foodyDefaultShadow() : null,
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              avatarPath == null && avatarUrl == null
                  ? defaultAvatar()
                  : avatarUrl == null
                      ? localAvatar()
                      : remoteAvatar(),
              if (onTap != null)
                Positioned(
                  bottom: 0,
                  right: -10,
                  child: inkWell(
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(5.0),
                      child: const Icon(
                        PhosphorIconsRegular.camera,
                        size: 24,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

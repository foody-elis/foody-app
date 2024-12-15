import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../utils/foody_default_shadow.dart';

class FoodyAvatar extends StatelessWidget {
  const FoodyAvatar({super.key, this.avatarPath, this.avatarUrl, this.onTap})
      : assert(avatarPath == null || avatarUrl == null,
            'You cannot set avatarPath and avatarUrl at the same time');

  final String? avatarPath;
  final String? avatarUrl;
  final void Function()? onTap;

  Widget _inkWell([Widget? child]) => InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap != null
            ? () {
                FocusManager.instance.primaryFocus?.unfocus();
                onTap!.call();
              }
            : null,
        child: child,
      );

  Widget _inkWellInOverlay() => Positioned.fill(
        child: Material(
          color: Colors.transparent,
          child: _inkWell(),
        ),
      );

  Widget _circularImage(image) => ClipOval(
        child: Stack(
          children: [
            image,
            _inkWellInOverlay(),
          ],
        ),
      );

  Widget _defaultAvatarContainer() => Container(
        padding: const EdgeInsets.all(15.0),
        child: Image.asset(
          'assets/images/user.png',
          width: 50,
          height: 50,
        ),
      );

  Widget _defaultAvatar() => _inkWell(_defaultAvatarContainer());

  Widget _localAvatar() => _circularImage(
        Image.file(
          File(avatarPath!),
          fit: BoxFit.cover,
          width: 80,
          height: 80,
        ),
      );

  Widget _remoteAvatar() => _circularImage(
        CachedNetworkImage(
          fadeInDuration: const Duration(milliseconds: 300),
          fadeOutDuration: const Duration(milliseconds: 300),
          imageUrl: avatarUrl!,
          fit: BoxFit.cover,
          width: 80,
          height: 80,
          placeholder: (_, __) => _defaultAvatarContainer(),
          errorWidget: (_, __, ___) => _defaultAvatarContainer(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Ink(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: foodyDefaultShadow(),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              avatarPath == null && avatarUrl == null
                  ? _defaultAvatar()
                  : avatarUrl == null
                      ? _localAvatar()
                      : _remoteAvatar(),
              if (onTap != null)
                Positioned(
                  bottom: 0,
                  right: -10,
                  child: Container(
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
            ],
          ),
        ),
      ),
    );
  }
}

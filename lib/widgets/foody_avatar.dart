import 'dart:io';

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class FoodyAvatar extends StatelessWidget {
  const FoodyAvatar({super.key, this.avatarPath, this.avatarUrl, this.onTap})
      : assert(avatarPath == null || avatarUrl == null,
            'You cannot set avatarPath and avatarUrl at the same time');

  final String? avatarPath;
  final String? avatarUrl;
  final void Function()? onTap;

  Widget defaultAvatar() => InkWell(
      customBorder: const CircleBorder(),
      onTap: onTap != null
          ? () {
              FocusManager.instance.primaryFocus?.unfocus();
              onTap!.call();
            }
          : null,
      child: Container(
        padding: const EdgeInsets.all(15.0),
        child: Image.asset(
          'assets/images/user.png',
          width: 50,
          height: 50,
        ),
      ));

  Widget localAvatar() => ClipOval(
        child: Stack(
          children: [
            Image.file(
              File(avatarPath!),
              fit: BoxFit.cover,
              width: 80,
              height: 80,
            ),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onTap != null
                      ? () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          onTap!.call();
                        }
                      : null,
                ),
              ),
            ),
          ],
        ),
      );

  Widget remoteAvatar() => ClipOval(
        child: Stack(
          children: [
            Image.network(
              avatarUrl!,
              fit: BoxFit.cover,
              width: 80,
              height: 80,
              errorBuilder: (_, __, ___) => Image.asset(
                'assets/images/user.png',
                width: 50,
                height: 50,
              ),
              loadingBuilder: (_, __, ___) => Image.asset(
                'assets/images/user.png',
                width: 50,
                height: 50,
              ),
            ),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onTap != null
                      ? () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          onTap!.call();
                        }
                      : null,
                ),
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300]!,
              blurRadius: 10.0,
              spreadRadius: 1.0,
            )
          ],
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
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(100),
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
    );
  }
}

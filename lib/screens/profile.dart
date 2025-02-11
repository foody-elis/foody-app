import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/auth/auth_bloc.dart';
import 'package:foody_app/bloc/auth/auth_event.dart';
import 'package:foody_app/bloc/auth/auth_state.dart';
import 'package:foody_app/routing/constants.dart';
import 'package:foody_app/routing/navigation_service.dart';
import 'package:foody_app/widgets/foody_profile_list_tile.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../widgets/foody_circular_image.dart';
import '../widgets/foody_secondary_layout.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      return FoodySecondaryLayout(
        headerExpandedHeight: 0.3,
        title: 'Profilo',
        titleWidget: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                FoodyCircularImage(
                  imageUrl: state.userResponseDto?.avatarUrl,
                  showShadow: false,
                ),
                const SizedBox(height: 10),
                Text(
                  "${state.userResponseDto?.name} "
                  "${state.userResponseDto?.surname}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Colors.white,
                  ),
                ),
                Text(
                  state.userResponseDto?.email ?? "",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primaryFixedDim,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ],
        ),
        bodySpacing: 5,
        body: [
          FoodyProfileListTile(
            label: "Dati personali",
            icon: PhosphorIconsRegular.user,
            onTap: () => NavigationService().navigateTo(
              editProfileRoute,
              arguments: {
                "user": state.userResponseDto,
                "authBloc": context.read<AuthBloc>(),
              },
            ),
          ),
          FoodyProfileListTile(
            label: "Ordini",
            icon: PhosphorIconsRegular.receipt,
            onTap: () => NavigationService().navigateTo(ordersRoute),
          ),
          FoodyProfileListTile(
            label: "Informazioni",
            icon: PhosphorIconsRegular.info,
            onTap: () => NavigationService().navigateTo(infoRoute),
          ),
          FoodyProfileListTile(
            label: "Esci",
            icon: PhosphorIconsRegular.signOut,
            leadingIconColor: Theme.of(context).colorScheme.error,
            trailingIconColor: Theme.of(context).colorScheme.error,
            splashColor: Theme.of(context).colorScheme.error,
            highlightColor: Theme.of(context).colorScheme.error,
            onTap: () => showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text("Logout"),
                content: const Text(
                  "Sei sicuro di voler uscire dal tuo account Foody?",
                ),
                actions: [
                  TextButton(
                    child: const Text("No"),
                    onPressed: () => NavigationService().goBack(),
                  ),
                  TextButton(
                    child: const Text("Esci"),
                    onPressed: () => context.read<AuthBloc>().add(Logout()),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}

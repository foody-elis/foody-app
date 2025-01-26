// import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foody_app/widgets/foody_secondary_layout.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Settings extends HookWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final packageInfo = useState<PackageInfo>(PackageInfo(
      appName: "Unknown",
      packageName: "Unknown",
      version: "Unknown",
      buildNumber: "Unknown",
    ));

    useEffect(() {
      PackageInfo.fromPlatform().then((info) => packageInfo.value = info);
      return null;
    }, []);

    return Scaffold(
      body: FoodySecondaryLayout(
        title: "Impostazioni",
        subtitle: "Modifica le impostazioni in base alle tue preferenze",
        showBottomNavBar: false,
        body: [
          ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            children: ListTile.divideTiles(
              context: context,
              tiles: [
                ListTile(
                  title: const Text("Numero versione"),
                  trailing: Text(
                    "${packageInfo.value.version}.${packageInfo.value.buildNumber}",
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                    ),
                  ),
                ),
                /*BlocBuilder<FoodyBloc, FoodyState>(builder: (context, state) {
                  return ListTile(
                      title: const Text("Modalità scura"),
                      trailing: AnimatedToggleSwitch<bool>.dual(
                          current: state.darkTheme,
                          first: false,
                          second: true,
                          spacing: 0.0,
                          style: const ToggleStyle(
                            borderColor: Colors.transparent,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: Offset(0, 1.5),
                              ),
                            ],
                          ),
                          borderWidth: 5.0,
                          height: 55,
                          onChanged: (_) =>
                              context.read<FoodyBloc>().add(DarkThemeToggled()),
                          styleBuilder: (lightMode) => ToggleStyle(
                            indicatorColor:
                                lightMode ? Colors.white : Colors.amber,
                          ),

                          iconBuilder: (lightMode) => lightMode
                              ? const Icon(PhosphorIconsRegular.moonStars)
                              : const Icon(PhosphorIconsRegular.sun),
                          /*  textBuilder: (value) => value
                          ? const Center(child: Text('Oh no...'))
                          : const Center(child: Text('Nice :)')),*/
                        ),
                      );
                }),*/
              ],
            ).toList(),
          )
        ],
      ),
    );
  }
}

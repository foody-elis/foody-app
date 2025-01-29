import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foody_app/widgets/foody_secondary_layout.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../utils/launch_url.dart';

class Info extends HookWidget {
  const Info({super.key});

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
        title: "Informazioni",
        subtitle: "Dettagli sull'app Foody",
        showBottomNavBar: false,
        body: [
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Row(
                spacing: 10,
                children: [
                  Icon(PhosphorIconsRegular.usersThree),
                  Text(
                    "Chi siamo?",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      // color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text.rich(
                TextSpan(
                  text:
                      "Siamo Giacomo, Daniele e Matteo, tre studenti universitari con una profonda passione per la tecnologia e il sogno di trasformarla nello strumento per costruire qualcosa di significativo.",
                  children: [
                    TextSpan(
                      text: " Foody",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                        text:
                            " è la manifestazione della nostra ambizione: un progetto che fonde innovazione tecnologica e informatica per fornire una soluzione unica e funzionale a un problema concreto.")
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const Row(
                spacing: 10,
                children: [
                  Icon(PhosphorIconsRegular.forkKnife),
                  Text(
                    "Perchè Foody?",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      // color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Foody ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          "rappresenta un ecosistema completo dove le interazioni tra ristoranti e clienti raggiungono la massima efficienza. Grazie alla piattaforma, è possibile ",
                    ),
                    TextSpan(
                      text: "prenotare, ordinare",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: " e ",
                    ),
                    TextSpan(
                      text: "pagare ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          "attraverso un’unica applicazione, rendendo l’esperienza dell’utente più semplice, fluida e veloce. Per i ristoratori, ",
                    ),
                    TextSpan(
                      text: "Foody ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          "ottimizza la gestione operativa, migliorando il rapporto con i clienti, il coordinamento delle ordinazioni e i processi di fidelizzazione.",
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const Row(
                spacing: 10,
                children: [
                  Icon(PhosphorIconsRegular.link),
                  Text(
                    "Link utili",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      // color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: "Github back-end: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      style: const TextStyle(color: Color(0xff3366CC)),
                      text: "foody-elis/foody-api",
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => customLaunchUrl(
                            "https://github.com/foody-elis/foody-api"),
                    ),
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: "Github customer app: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      style: const TextStyle(color: Color(0xff3366CC)),
                      text: "foody-elis/foody-app",
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => customLaunchUrl(
                            "https://github.com/foody-elis/foody-app"),
                    ),
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: "Github business app: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      style: const TextStyle(color: Color(0xff3366CC)),
                      text: "foody-elis/foody-business-app",
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => customLaunchUrl(
                            "https://github.com/foody-elis/foody-business-app"),
                    ),
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: "Documentazione: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      style: const TextStyle(color: Color(0xff3366CC)),
                      text: "google-drive/foody-doc",
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => customLaunchUrl(
                            "https://docs.google.com/document/d/1p1RFOiUF8x7opr-N9B8PLcPE7cJZiqI1_v2iclKKEvk/edit?usp=sharing"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foody_app/utils/link.dart';
import 'package:foody_app/widgets/foody_secondary_layout.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../utils/launch_url.dart';

class Info extends HookWidget {
  Info({super.key});

  final links = {
    "Documentazione": Link(
      icon: PhosphorIconsRegular.fileText,
      url:
          "https://docs.google.com/document/d/1p1RFOiUF8x7opr-N9B8PLcPE7cJZiqI1_v2iclKKEvk/edit?usp=sharing",
      text: "google-drive/foody-doc",
    ),
    "Github back-end": Link(
      icon: PhosphorIconsRegular.githubLogo,
      url: "https://github.com/foody-elis/foody-api",
      text: "foody-elis/foody-api",
    ),
    "Github customer app": Link(
      icon: PhosphorIconsRegular.githubLogo,
      url: "https://github.com/foody-elis/foody-app",
      text: "foody-elis/foody-app",
    ),
    "Github business app": Link(
      icon: PhosphorIconsRegular.githubLogo,
      url: "https://github.com/foody-elis/foody-business-app",
      text: "foody-elis/foody-business-app",
    ),
    "Giacomo Bongiovanni": Link(
      icon: PhosphorIconsRegular.linkedinLogo,
      url: "https://www.linkedin.com/in/giacomo-bongiovanni",
      text: "linkedin/giacomo-bongiovanni",
    ),
    "Daniele Cozzi": Link(
      icon: PhosphorIconsRegular.linkedinLogo,
      url: "https://www.linkedin.com/in/cozzi-daniele",
      text: "linkedin/daniele-cozzi",
    ),
    "Matteo Convertino": Link(
      icon: PhosphorIconsRegular.linkedinLogo,
      url: "https://www.linkedin.com/in/convertino-matteo",
      text: "linkedin/matteo-convertino",
    ),
  };

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
              EasyRichText(
                "Siamo Giacomo, Daniele e Matteo, tre studenti universitari con "
                "una profonda passione per la tecnologia e il sogno di "
                "trasformarla nello strumento per costruire qualcosa di"
                " significativo. Foody è la manifestazione della nostra"
                " ambizione: un progetto che fonde innovazione tecnologica "
                "e informatica per fornire una soluzione unica e funzionale"
                " a un problema concreto.",
                patternList: const [
                  EasyRichTextPattern(
                    targetString: [
                      "Giacomo",
                      "Daniele",
                      "Matteo",
                      "passione",
                      "Foody",
                      "ambizione:",
                      "soluzione unica",
                      "problema concreto",
                    ],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
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
              EasyRichText(
                "Foody rappresenta un ecosistema completo dove le interazioni "
                "tra ristoranti e clienti raggiungono la massima "
                "efficienza. Grazie alla piattaforma, è possibile "
                "prenotare, ordinare e pagare attraverso un’unica "
                "applicazione, rendendo l’esperienza dell’utente più "
                "semplice, fluida e veloce. Per i ristoratori, Foody "
                "ottimizza la gestione operativa, migliorando il rapporto "
                "con i clienti, il coordinamento delle ordinazioni e i "
                "processi di fidelizzazione.",
                patternList: const [
                  EasyRichTextPattern(
                    targetString: [
                      "Foody",
                      "ristoranti",
                      "clienti",
                      "prenotare, ordinare",
                      "pagare",
                      "semplice, fluida",
                      "veloce",
                    ],
                    matchOption: [0],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
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
              ...links.entries.map(
                (e) => Row(
                  spacing: 5,
                  children: [
                    Icon(
                      e.value.icon,
                      size: 14,
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "${e.key}: ",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            style: const TextStyle(color: Color(0xff3366CC)),
                            text: e.value.text,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => customLaunchUrl(e.value.url),
                          ),
                        ],
                      ),
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

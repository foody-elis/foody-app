import 'package:animate_do/animate_do.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:foody_app/widgets/utils/foody_colors.dart';
import 'package:lottie/lottie.dart';

class SittingTimesFormExpanded extends StatelessWidget {
  const SittingTimesFormExpanded({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 30,
        left: 20,
        right: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInDown(
            duration: const Duration(milliseconds: 500),
            child: Lottie.asset(
              width: 300,
              height: 250,
              "assets/lottie/sitting_times.json",
            ),
          ),
          const Text(
            "Descrizione",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          EasyRichText(
            "Nel form sottostante dovrai inserire gli orari di apertura e "
            "chiusura settimanali del tuo ristorante.\n\nSuccessivamente "
            "dovrai scegliere in quanti intervalli  suddividere la tua giornata lavorativa, "
            "cosi da permettere ai clienti di prenotarsi.",
            patternList: const [
              EasyRichTextPattern(
                targetString: ["orari", "intervalli"],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
            defaultStyle: TextStyle(
              color: Theme.of(context).colorScheme.primaryFixedDim,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            spacing: 5,
            children: [
              const Chip(
                padding: EdgeInsets.all(0),
                backgroundColor: backgroundColorHeaderSecondaryLayout,
                label: Text(
                  "15 min",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Text(
                " genera opzioni come 12:00, 12:15, 12:30",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primaryFixedDim,
                ),
              ),
            ],
          ),
          Row(
            spacing: 5,
            children: [
              const Chip(
                padding: EdgeInsets.all(0),
                backgroundColor: backgroundColorHeaderSecondaryLayout,
                label: Text(
                  "30 min",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Text(
                " genera opzioni come 12:00, 12:30, 13:00",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primaryFixedDim,
                ),
              ),
            ],
          ),
          Row(
            spacing: 5,
            children: [
              const Chip(
                padding: EdgeInsets.all(0),
                backgroundColor: backgroundColorHeaderSecondaryLayout,
                label: Text(
                  "60 min",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Text(
                " genera opzioni come 12:00, 13:00, 14:00",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primaryFixedDim,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

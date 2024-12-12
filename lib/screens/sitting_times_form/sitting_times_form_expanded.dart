import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
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
            animate: true,
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
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          const Text.rich(
            TextSpan(
              children: [
                TextSpan(text: "Nel form sottostante dovrai inserire gli "),
                TextSpan(
                  text: "orari",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                    text:
                        " di apertura e chiusura settimanali del tuo ristorante.\n\n"),
                TextSpan(text: "Successivamente dovrai scegliere in quanti "),
                TextSpan(
                  text: "intervalli",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                    text: " suddividere la tua giornata lavorativa, "
                        "cosi da permettere ai clienti di prenotarsi."),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Chip(
                padding: const EdgeInsets.all(0),
                // labelPadding: EdgeInsets.z,

                backgroundColor: Theme.of(context).primaryColor,
                label: const Text(
                  "15 min",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const Text(" genera opzioni come 12:00, 12:15, 12:30"),
            ],
          ),
          Row(
            children: [
              Chip(
                padding: const EdgeInsets.all(0),
                backgroundColor: Theme.of(context).primaryColor,
                label: const Text(
                  "30 min",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const Text(" genera opzioni come 12:00, 12:30, 13:00"),
            ],
          ),
          Row(
            children: [
              Chip(
                padding: const EdgeInsets.all(0),
                backgroundColor: Theme.of(context).primaryColor,
                label: const Text(
                  "60 min",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const Text(" genera opzioni come 12:00, 13:00, 14:00"),
            ],
          ),
        ],
      ),
    );
  }
}

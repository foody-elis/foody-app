import 'package:url_launcher/url_launcher.dart';

Future<void> customLaunchUrl(String url) async {
  try {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch url: $url');
    }
  } catch (_) {}
}

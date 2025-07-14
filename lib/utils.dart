import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Command {
  static final all = [email, browser1, browser2];

  static const email = 'write email';
  static const browser1 = 'open';
  static const browser2 = 'go to';
}

class Utils {
  static void scanText(String rawText) {
    final text = rawText.toLowerCase();

    if (text.contains(Command.email)) {
      final body = _getTextAfterCommand(text: text, command: Command.email);
      if (body != null) openEmail(body: body);
    } else if (text.contains(Command.browser1)) {
      final url = _getTextAfterCommand(text: text, command: Command.browser1);
      if (url != null) openLink(url: url);
    } else if (text.contains(Command.browser2)) {
      final url = _getTextAfterCommand(text: text, command: Command.browser2);
      if (url != null) openLink(url: url);
    }
  }

  static String? _getTextAfterCommand({
    required String text,
    required String command,
  }) {
    final indexCommand = text.indexOf(command);
    final indexAfter = indexCommand + command.length;

    if (indexCommand == -1) {
      return null;
    } else {
      return text.substring(indexAfter).trim();
    }
  }

  static Future<void> openLink({
    required String url,
  }) async {
    final Uri uri = Uri.parse(url.trim().isEmpty ? 'https://google.com' : 'https://$url');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  static Future<void> openEmail({
    required String body,
  }) async {
    final Uri uri = Uri.parse('mailto:?body=${Uri.encodeFull(body)}');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}

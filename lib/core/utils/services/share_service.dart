import 'package:academe_x/academeX_main.dart';
import 'package:academe_x/core/core.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart';

import '../network/api_setting.dart';

class ShareService {
  static Future<void> shareViaWhatsApp(String postId, String postTitle) async {
    final url = '${ApiSetting.baseUrl}/post/$postId';
    final text = 'شاهد هذا المنشور: $postTitle\n\n$url';
    final whatsappUrl = Uri.parse('whatsapp://send?text=${Uri.encodeComponent(text)}');
    try {
      final canLaunch = await canLaunchUrl(whatsappUrl);
      if (canLaunch) {
        await launchUrl(whatsappUrl);
      } else {
        // Fallback to web WhatsApp
        final webWhatsappUrl = Uri.parse('https://wa.me/?text=${Uri.encodeComponent(text)}');
        await launchUrl(webWhatsappUrl, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      print('Error sharing to WhatsApp: $e');
      // Handle error
    }
  }

  static Future<void> shareViaTelegram(String postId, String postTitle) async {
    final url = '${ApiSetting.baseUrl}/post/$postId';
    final text = 'شاهد هذا المنشور: $postTitle\n\n$url';
    final telegramUrl = Uri.parse('tg://msg?text=${Uri.encodeComponent(text)}');

    try {
      final canLaunch = await canLaunchUrl(telegramUrl);
      if (canLaunch) {
        await launchUrl(telegramUrl);
      } else {
        // Fallback to web Telegram
        final webTelegramUrl = Uri.parse('https://t.me/share/url?url=${Uri.encodeComponent(url)}&text=${Uri.encodeComponent(text)}');
        await launchUrl(webTelegramUrl, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      print('Error sharing to Telegram: $e');
      // Handle error
    }
  }

  static Future<void> shareViaX(String postId, String postTitle) async {
    final url = '${ApiSetting.baseUrl}/post/$postId';
    final text = 'شاهد هذا المنشور: $postTitle\n\n$url';
    final xUrl = Uri.parse('https://twitter.com/intent/tweet?text=${Uri.encodeComponent(text)}');


    try {
      await launchUrl(xUrl, mode: LaunchMode.externalApplication);
    } catch (e) {
      print('Error sharing to X: $e');
      // Handle error
    }
  }

  static Future<void> copyLink(String postId, BuildContext context) async {
    final url = '${ApiSetting.baseUrl}/post/$postId';
    await Clipboard.setData(ClipboardData(text: url));

    if (context.mounted) {
      context.showSnackBar(
        message: 'تم نسخ الرابط',
        time: 2,
        // const SnackBar(
      );
    }
  }
}
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Data/dynamic_data.dart';
import '../Data/static_data.dart';

Future update(BuildContext context) async {
  return (
    await showDialog(
      barrierColor: const Color.fromARGB(97, 178, 216, 218),
      barrierDismissible: false,
      context: context,
      builder: (context) => WillPopScope(
        onWillPop: () async {
          exit(0);
        },
        child: AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Row(
            children: [
              Icon(CupertinoIcons.rocket_fill),
              SizedBox(width: 5),
              Text('بروزرسانی برنامه'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                ' به دلیل توسعه و بهینه سازی ، نسخه جدیدی از برنامه منتشر شده است . برای استفاده از برنامه ابتدا برنامه را بروزرسانی کنید',
              ),
              const Text(
                'نسخه فعلی برنامه',
                style: TextStyle(fontSize: 13),
              ),
              Text(
                'V-${StaticData.versionApp}',
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontFamily: ''),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => exit(0),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                overlayColor: MaterialStateProperty.all<Color>(
                    Colors.red.withOpacity(0.15)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              child: const Text('خروج از برنامه'),
            ),
            ElevatedButton(
              onPressed: () async {
                await launchUrl(Uri.parse(StaticData.baseUrl + updateAppUrl),
                    mode: LaunchMode.externalApplication);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              child: const Text('بروز رسانی'),
            ),
          ],
        ),
      ),
    ),
  );
}

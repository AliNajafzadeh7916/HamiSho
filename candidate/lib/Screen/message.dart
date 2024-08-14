// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../Api/api.dart';

import '../Data/dynamic_data.dart';
import '../Data/static_data.dart';
import 'update.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();

  String name = '';
  String phone = '';
  String city = '';
  String message = '';

  bool error = false;

  setMessageToCandidate({
    required String name,
    required String phone,
    required String city,
    required String message,
  }) async {
    Api api = Api();
    Response response = await api.setMessageToCandidate(
      name: name,
      phone: phone,
      city: city,
      message: message,
    );

    if (response.data['Status'] == 200) {
      setState(() {
        Navigator.of(context).pop(true);

        showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.success(
            message: 'پیام شما با موفقیت ارسال شد',
          ),
        );
      });
    } else if (response.data['Status'] == 903) {
      setState(() {
        updateAppUrl = response.data['Link']['AppFile'];
      });
      update(context);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  height: 80,
                  width: 80,
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Color(
                      int.parse(
                        '0XFF${candidate['Color'][0]}',
                      ),
                    ),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(width: 3, color: Colors.white),
                    image: DecorationImage(
                        image: NetworkImage(
                            StaticData.baseUrl + candidate['Image']),
                        fit: BoxFit.cover),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      candidate['Name'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 130,
                      child: Text(
                        candidate['SirName'],
                        style: const TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 20),
              child: TextField(
                controller: controller1,
                maxLength: 40,
                decoration: InputDecoration(
                  label: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(CupertinoIcons.person),
                      Text(
                        ' نام و نام خانوادگی ',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  errorText: error && name.length < 3
                      ? 'نام و نام خانوادگی را وارد کنید ( حداقل 3 حرف )'
                      : null,
                  counterText: '',
                ),
                onChanged: (value) {
                  setState(() {
                    name = value.trim();
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
              child: TextField(
                controller: controller2,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9۰۱۲۳۴۵۶۷۸۹]'))
                ],
                maxLength: 11,
                decoration: InputDecoration(
                  label: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(CupertinoIcons.phone),
                      Text(
                        ' شماره همراه ',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  counterText: '',
                  errorText: error && phone.length != 11
                      ? 'شماره همراه را وارد کنید ( 11 رقم )'
                      : null,
                ),
                onChanged: (value) {
                  setState(() {
                    phone = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
              child: TextField(
                controller: controller3,
                maxLength: 60,
                decoration: InputDecoration(
                  label: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(CupertinoIcons.house),
                      Text(
                        ' محل سکونت ( شهر / روستا ) ',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  counterText: '',
                  errorText: error && city.length < 3
                      ? 'محل سکونت را وارد کنید ( حداقل 3 حرف )'
                      : null,
                ),
                onChanged: (value) {
                  setState(() {
                    city = value.trim();
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
              child: TextField(
                controller: controller4,
                minLines: 5,
                maxLines: 5,
                maxLength: 2000,
                decoration: InputDecoration(
                  label: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(CupertinoIcons.envelope),
                      Text(
                        ' پیام ',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  helperText: 'پیام خود را در حد 1 الی 2 پارگراف بنویسید',
                  errorText: error && message.length < 10
                      ? 'پیام خود را وارد کنید ( حداقل 10 حرف )'
                      : null,
                ),
                onChanged: (value) {
                  setState(() {
                    message = value.trim();
                  });
                },
              ),
            ),
            ElevatedButton(
              onPressed: (name.length > 2 &&
                      phone.length == 11 &&
                      city.length > 2 &&
                      message.length > 9)
                  ? () {
                      setMessageToCandidate(
                          name: name,
                          phone: phone,
                          city: city,
                          message: message);
                    }
                  : () {
                      setState(() {
                        error = true;
                      });
                    },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Color(
                    int.parse(
                      '0XFF${candidate['Color'][1]}',
                    ),
                  ),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Text(
                  'ارسال',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

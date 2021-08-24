import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: '아이디',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        controller: controller.idEditingController,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(child:TextField(
                            decoration: InputDecoration(
                              labelText: '닉네임',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            controller: controller.nicknameEditingController,
                          )),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child:
                            ElevatedButton(
                              child: Text('수정'),
                              onPressed:  () async {
                                await controller.updateNickname();

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(content: Text('수정완료.')));
                              },
                            )
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                              child:TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: '새 비밀번호',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              controller: controller.passwordEditingController,
                              ),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(10),
                              child:
                              ElevatedButton(
                                child: Text('수정'),
                                onPressed:  () async {
                                  await controller.updatePassword();

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(content: Text('수정완료.')));
                                },
                              )
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              )),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16),
                topLeft: Radius.circular(16),
              ),
              color: Colors.white),
        ),
      ),
    );
  }
}

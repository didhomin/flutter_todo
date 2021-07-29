// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView(
        restorationId: 'list_demo_list_view',
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          for (int index = 1; index < 21; index++)
            ListTile(
              leading: ExcludeSemantics(
                child: CircleAvatar(child: Text('7/$index')),
              ),
              title: Text(
                "운동하기 등 3건 완료",
              ),
              subtitle: Text("총 10건 중 3건 완료 7건 미완"),
            ),
        ],
      ),
    );
  }
}


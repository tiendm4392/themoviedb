import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:testapp/constans.dart';
import 'package:testapp/screens/chat/components/waiting_room.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  static const List<Tab> myTabs = <Tab>[
    Tab(text: "Chatting"),
    Tab(text: "Waiting"),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: kGrayColor,
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: myTabs.length,
        child: Scaffold(
          appBar: buildAppBar(),
          body: Column(
            children: [
              Container(
                height: 52,
                decoration: const BoxDecoration(
                    border:
                        Border(bottom: BorderSide(width: 2, color: kGrayColor)),
                    color: Colors.white),
                child: const TabBar(
                    labelColor: kPrimaryColor,
                    unselectedLabelColor: Colors.black,
                    indicatorColor: kPrimaryColor,
                    tabs: myTabs),
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    Center(child: Text("List is empty", style: headerText,)),
                    WaitingRoom(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0.3,
      backgroundColor: Colors.white,
      title: const Text(
        "Chat",
        style: headerText,
      ),
    );
  }
}

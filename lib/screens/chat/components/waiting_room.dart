import 'package:flutter/material.dart';
import 'package:testapp/constans.dart';
import 'package:testapp/screens/chat/components/chatting_room.dart';

class WaitingRoom extends StatelessWidget {
  const WaitingRoom({Key? key}) : super(key: key);
  static String routeName = "/waitingRoom";
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: const [
        UserChatContainer(),
        UserChatContainer(),
        UserChatContainer(),
        UserChatContainer(),
        UserChatContainer(),
        UserChatContainer(),
        UserChatContainer(),
        UserChatContainer(),
        UserChatContainer(),
      ]),
    );
  }
}

class UserChatContainer extends StatelessWidget {
  const UserChatContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChattingRoom(name: "hello", message: "this is a message",)),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
              vertical: 12, horizontal: kDefaultPadding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: Image.network(
                    "https://source.unsplash.com/random/?Cryptocurrency&1",
                    width: 56,
                    height: 56,
                    fit: BoxFit.fill),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const <Widget>[
                          Text("Homelander",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          Spacer(),
                          Text("06/09")
                        ],
                      ),
                      const Text("Reload already in progress, ignoring request")
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

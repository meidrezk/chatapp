import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constant.dart';
import '../models/message.dart';
import '../widgets/chat_buble.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key, required this.email});

  final String email;
  TextEditingController controller = TextEditingController();
  late String messageValue;
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    CollectionReference messages =
        FirebaseFirestore.instance.collection(Constant.kMessages);
    return StreamBuilder<QuerySnapshot>(
      stream:
          messages.orderBy(Constant.kCreatedAt, descending: true).snapshots(),
      builder: (BuildContext context, snapshot) {
        // if (snapshot.hasData)  {
        //
        //   List<Message> messageList=[];
        //   for(int i=0; i<snapshot.data!.docs.length;i++){
        //     messageList.add(Message.fromJson(snapshot.data!.docs[i]));
        //   }

        if (snapshot.hasData) {
          List<Message> messageList = snapshot.data!.docs.map((doc) {
            return Message.fromJson(doc.data());
          }).toList();
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Constant.kPrimaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    Constant.kLogoPath,
                    height: 50,
                  ),
                  Text(
                    'chat',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: _scrollController,
                    itemBuilder: (context, index) =>
                        messageList[index].id == email
                            ? ChatBuble(
                                message: messageList[index],
                              )
                            : ChatBubleForFriend(message: messageList[index]),
                    itemCount: messageList.length,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: controller,
                    onChanged: (value) {
                      messageValue = value;
                    },
                    onSubmitted: (value) {
                      addMessage(messages, value);
                      controller.clear();
                      _scrollController.animateTo(
                          _scrollController.position.maxScrollExtent,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeIn);
                    },
                    decoration: InputDecoration(
                      hintText: 'Send Message',
                      suffixIcon: InkWell(
                        onTap: () {
                          addMessage(messages, messageValue);
                          controller.clear();
                          _scrollController.animateTo(0,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                        child: Icon(
                          Icons.send,
                          color: Constant.kPrimaryColor,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Constant.kPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Scaffold(
            body: Center(
                child: CircularProgressIndicator(
              color: Constant.kPrimaryColor,
            )),
          );
        }
      },
    );
  }

  void addMessage(CollectionReference<Object?> messages, String value) {
    messages
        .add({
          Constant.kMessage: value,
          Constant.kCreatedAt: DateTime.now(), // تخزين التوقيت الحالي
          "id": email,
        })
        .then((value) => print("message Added"))
        .catchError((error) => print("Failed to add message: $error"));
  }
}

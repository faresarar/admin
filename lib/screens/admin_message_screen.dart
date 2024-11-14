import 'package:admin/providers/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../firebase_cloud_messaging.dart';

class AdminMessageScreen extends StatefulWidget {
  static const routeName = '/AdminMessageScreen';

  const AdminMessageScreen({super.key});

  @override
  State<AdminMessageScreen> createState() => _AdminMessageScreenState();
}

class _AdminMessageScreenState extends State<AdminMessageScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  final TextEditingController productIdController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    // TODO: implement dispose
    titleController.dispose();
    bodyController.dispose();
    productIdController.dispose();
    super.dispose();
  }

/*
  void _sendResponse(String messageId) {
    String responseText = _responseController.text;

    // Update the Firestore document with the admin's response
    FirebaseFirestore.instance.collection('messages').doc(messageId).update({
      'adminResponse': responseText,
    }).then((_) {
      // Clear the input field after a successful update
      _responseController.clear();
    }).catchError((error) {
      // Handle error if the update fails
      print('Error updating response: $error');
      MyAppMethods.showErrorORWarningDialog(
        context: context,
        subtitle: "An error has been occured ${error.message}",
        fct: () {},
      );
    });
  }
*/
/*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin App'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('messages').snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No messages found.'));
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot<Map<String, dynamic>> document) {
              Map<String, dynamic>? message = document.data();
              String sender = message?['sender'] ?? '';
              String text = message?['message'] ?? '';
              String? adminResponse = message?['adminResponse'];

              return ListTile(
                title: Text('$sender: $text'),
                subtitle: adminResponse != null ? Text('Admin: $adminResponse') : null,
                trailing: TextField(
                  controller: _responseController,
                  decoration: const InputDecoration(labelText: 'Type a response'),
                  onSubmitted: (_) => _sendResponse(document.id),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin App'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const Text("Add Notification"),
              TextField(
                controller: titleController,
                autocorrect: true,
                decoration: const InputDecoration(
                  hintText: "Notification Title ",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: bodyController,
                autocorrect: true,
                decoration: const InputDecoration(
                  hintText: "Notification Title ",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const TextField(
                //controller: titleController,
                autocorrect: true,
                decoration: InputDecoration(
                  hintText: "Notification Title ",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Column(
                  children: [
                    ElevatedButton(
                      child: const Text("Add Notification"),
                      onPressed: () async {
                        final notificationProvider =
                            Provider.of<NotificationProvider>(context,
                                listen: false);
                        String title = titleController.text;
                        String body = bodyController.text;
                        await FirebaseCloudMessaging().sendTopicNotification(
                            title: title,
                            body: body,
                        );
                        notificationProvider.addNotification(title, body,
                            "0c0b924f-1945-412e-b9a8-d2032ee3f69f");
                        debugPrint("success");
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

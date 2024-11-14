import 'package:admin/providers/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GetAllNotification extends StatefulWidget {
  static const routeName = '/GetAllNotification';

  const GetAllNotification({super.key});

  @override
  State<GetAllNotification> createState() => _GetAllNotificationState();
}

class _GetAllNotificationState extends State<GetAllNotification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<NotificationProvider>(
        builder: (context, contactProvider, _) {
          return Column(
            children: [
              const SizedBox(height: 10),
              TextField(
                onChanged: (value) {
                  /*final contactProvider =
                      Provider.of<NotificationProvider>(context, listen: false);
                  contactProvider.filterContacts(value);*/
                },
                decoration: const InputDecoration(
                  hintText: 'Search Members',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              Consumer<NotificationProvider>(
                builder: (context, contactProvider, _) {
                  final contacts = contactProvider.filteredNotifications;
                  return contacts.isEmpty
                      ? const Text(
                          'No Members yet..',
                          style: TextStyle(fontSize: 22),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: contacts.length,
                            itemBuilder: (context, index) {
                              final contact = contacts[index];
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: index % 2 == 0
                                      ? Colors.deepPurpleAccent
                                      : Colors.purple,
                                  foregroundColor: Colors.white,
                                  child: Text(
                                    contacts[index].title[0],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                title: Column(
                                  children: [
                                    Text(contact.body),
                                  ],
                                ),
                                trailing: SizedBox(
                                  width: 70,
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            //contactProvider.addSession(context, index);
                                          },
                                          child: const Icon(Icons.send),
                                        ),
                                        InkWell(
                                            onTap: () {
                                          /*    Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (builder) =>
                                                      UpdateMemberScreen(
                                                    contactModel: contact,
                                                    selectedIndex: index,
                                                  ),
                                                ),
                                              );*/
                                            },
                                            child: const Icon(Icons.edit)),
                                        GestureDetector(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      'Delete Contact'),
                                                  content: const Text(
                                                      'Are you sure you want to delete this contact?'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                      /*  final contactProvider =
                                                            Provider.of<
                                                                    ContactProvider>(
                                                                context,
                                                                listen: false);
                                                        contactProvider
                                                            .deleteContact(
                                                                index);
                                                        Navigator.of(context)
                                                            .pop();*/
                                                      },
                                                      child:
                                                          const Text('Delete'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child:
                                                          const Text('Cancel'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ]),
                                ),
                              );
                            },
                          ),
                        );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
/* Expanded(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            SliverToBoxAdapter(
                child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context , index){
                      return const AddNotificationItem ();
                    },
                    separatorBuilder: (context , index)=>const SizedBox(height: 15,),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 3))
          ],
        ),
      ),*/

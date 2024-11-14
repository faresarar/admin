import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../services/assets_manager.dart';
import '../../../widgets/empty_bag.dart';
import '../../../widgets/title_text.dart';
import 'orders_widget.dart';

class OrdersScreenFree extends StatefulWidget {
  static const routeName = '/OrderScreen';

  const OrdersScreenFree({super.key});

  @override
  State<OrdersScreenFree> createState() => _OrdersScreenFreeState();
}

class _OrdersScreenFreeState extends State<OrdersScreenFree> {
  bool isEmptyOrders = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TitlesTextWidget(
          label: 'Placed orders',
        ),
      ),
      body: isEmptyOrders
          ? EmptyBagWidget(
              imagePath: AssetsManager.order,
              title: "No orders has been placed yet",
              subtitle: "",
            )
          : StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('ordersAdvanced')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text('Loading...');
                }
                final List<DocumentSnapshot> documents = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (BuildContext context, int index) {
                    final document = documents[index];
                    final imageUrl = document['imageUrl'];
                    final orderDate = document['orderDate'];
                    final orderId = document['orderId'];
                    final price = document['price'];
                    final productId = document['productId'];
                    final productTitle = document['productTitle'];
                    final quantity = document['quantity'];
                    final totalPrice = document['totalPrice'];
                    final userId = document['userId'];
                    final userName = document['userName'];
                    return ListTile(
                      leading: Image.network(imageUrl),
                      title: Text(productTitle),
                      subtitle: Text('Order ID: $orderId'),
                      trailing: Text('Price: $price'),
                    );
                  },
                );
              },
            ),
    );
  }
}

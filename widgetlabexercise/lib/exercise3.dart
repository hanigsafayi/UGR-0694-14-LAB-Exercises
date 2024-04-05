import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(MaterialApp(
      home: OrderDetails(),
    ));

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: Column(
        children: <Widget>[
          Container(
              margin: EdgeInsets.all(8.0),
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.blue,
                  ),
                  Text(
                    'Completed',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        backgroundColor: Colors.lightBlueAccent),
                  ),
                  Text('Order Completed 24 July 2024'),
                  SizedBox(height: 10),
                  Text('Order ID'),
                  Text('Order data'),
                ],
              )),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Purchase Items',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text('Blue t-shirt'),
                Text('50.00'),
                Text('Size: L'),
                Text('Color: Yellow'),
                Text('Qty: 1'),
                Text('Hoodie Rose'),
                Text('Size: L'),
                Text('50.00'),
                Text('Color: Yellow'),
                Text('Qty: 1'),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Shipping Information',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text('Name: Jacob Jones'),
                Text('Phone Number: (105)555_3652'),
                Text('Address: 61480 Sunbrook park, PC 5679'),
                Text('Shipment: Economy'),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Payment Information',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text('Payment Method: Cash On Delivery'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

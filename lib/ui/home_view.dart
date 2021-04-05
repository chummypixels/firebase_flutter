import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crypto/net/apifunctions.dart';
import 'package:flutter/material.dart';

import 'add_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  double bitcoin = 0.0;
  double ethereum = 0.0;
  double tether = 0.0;

  @override
  void initState() {
    getValues();
  }

  getValues() async {
    bitcoin = await getPrice('bitcoin');
    ethereum = await getPrice('bitcoin');
    tether = await getPrice('bitcoin');

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    getValues(String id, double amount) {
      if (id == 'bitcoin') {
        return bitcoin * amount;
      } else if (id == 'ethereum') {
        return ethereum * amount;
      } else {
        return tether * amount;
      }
    }

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Colors.white),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .doc(FirebaseAuth.instance.currentUser.uid)
                .collection('Coins')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView(
                children: snapshot.data.docs.map((document) {
                  return Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Coin Name: ${document.id}'),
                        Text(
                            'Amount Owned: \$${getValues(document.id, document.data()['Amount']).toStringAsFixed(2)}'),
                      ],
                    ),
                  );
                }).toList(),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddView()));
        },
      ),
    );
  }
}

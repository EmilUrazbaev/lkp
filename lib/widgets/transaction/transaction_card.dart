import 'package:flutter/material.dart';

import '../../screens/transaction_detail_screen.dart';
import '../../models/transaction_model.dart';

class TransactionCard extends StatelessWidget {
  // final String contractor;
  // final String price;
  // final String dateTime;

  final Transaction transaction;

  TransactionCard(this.transaction);

  void selectTransaction(BuildContext ctx, Transaction transaction) {
    Navigator.of(ctx).push(
      MaterialPageRoute(builder: (_) {
        return TransactionDetailScreen(transaction);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectTransaction(context, transaction),
      child: Container(
        // decoration: BoxDecoration(
        //   border: Border.all(color: Theme.of(context).primaryColor, width: 1.0),
        // ),
        // height: 80,
        width: double.infinity,
        child: Card(
          shadowColor: Theme.of(context).primaryColor,
          elevation: 2.0,
          child: Container(
            margin: const EdgeInsets.fromLTRB(15, 15, 0, 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Column(
                    children: <Widget>[
                      Text(
                        transaction.contractor,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                        softWrap: true,
                      ),
                      Text(transaction.transactionType),
                      Text(transaction.dateTime),
                    ],
                  ),
                ),
                Column(
                  children: <Widget>[
                    Text(
                      transaction.totalPrice,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text('Сумма')
                  ],
                )
                // Container(
                //   margin: const EdgeInsets.all(15.0),
                //   child: Icon(Icons.credit_card,
                //       color: isActive ? Colors.green : Colors.red),
                // ),
                // Text(
                //   cardId,
                //   style: TextStyle(
                //     fontSize: 20,
                //     fontWeight: FontWeight.w500,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

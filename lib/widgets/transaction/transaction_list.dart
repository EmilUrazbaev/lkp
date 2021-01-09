import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'transaction_card.dart';
import '../../models/transactions.dart';
import '../../models/transaction_model.dart';

class TransactionList extends StatefulWidget {
  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  var _isInit = true;
  var _isLoading = false;
  var transactionsData;
  List<Transaction> searchedTransactions;
  TextEditingController _textController = TextEditingController();

  onItemChanged(String query) {
    setState(() {
      searchedTransactions = [];
      for (var transaction in transactionsData.items) {
        if (transaction.contractor
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            transaction.user.toLowerCase().contains(query.toLowerCase()) ||
            transaction.dateTime.contains(query)) {
          searchedTransactions.add(transaction);
        }
      }
    });
  }

//------------------
  @override
  void didChangeDependencies() {
    if (_isInit) {
      if (this.mounted) {
        setState(() {
          _isLoading = true;
        });
      }
      Provider.of<Transactions>(context).fetchAndSetTransactions().then((_) {
        if (this.mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }
  //--------------------

  @override
  Widget build(BuildContext context) {
    transactionsData = Provider.of<Transactions>(context);
    final transactions = searchedTransactions == null
        ? transactionsData.items
        : searchedTransactions;
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Container(
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                return index == 0
                    ? Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextField(
                          controller: _textController,
                          decoration: InputDecoration(
                            hintText: 'Найти...',
                          ),
                          onChanged: onItemChanged,
                        ),
                      )
                    : TransactionCard(transactions[index - 1]);
              },
              itemCount: transactions.length + 1,
            ),
          );
  }
}

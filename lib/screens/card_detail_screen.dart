import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../models/card_model.dart';
import '../models/transactions.dart';
import '../widgets/transaction/transaction_card.dart';

class CardDetailScreen extends StatefulWidget {
  final CardModel card;

  CardDetailScreen(this.card);

  @override
  _CardDetailScreenState createState() => _CardDetailScreenState();
}

class _CardDetailScreenState extends State<CardDetailScreen> {
  var _isInit = true;

  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      if (this.mounted) {
        setState(() {
          _isLoading = true;
        });
      }
      Provider.of<Transactions>(context)
          .fetchAndSetTransactionsForCard(widget.card.cardId)
          .then((_) {
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

  @override
  Widget build(BuildContext context) {
    final transactionsData = Provider.of<Transactions>(context);
    final transactions = transactionsData.itemsForCard;
    final appBar = AppBar(
      title: Text('Карта'),
    );
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: appBar,
      body: Column(
        children: [
          Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(20),
                height: 200,
                width: 330,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.indigo, Colors.blue]),
                ),
              ),
              Positioned(
                bottom: 40,
                left: 40,
                child: Text(
                  widget.card.cardId,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                top: 40,
                right: 40,
                child: Text(
                  widget.card.status ? 'активна' : 'заблокирована',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: widget.card.status ? Color(0xFFABF24F) : Colors.red,
                  ),
                ),
              ),
              Positioned(
                top: 60,
                left: 40,
                child: Text(
                  widget.card.user == null ? '' : widget.card.user,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
              ),
            ],
          ),
          Container(
            width: 330,
            height: 35,
            padding: EdgeInsets.only(bottom: 5),
            child: RaisedButton(
              onPressed: () {
                setState(() {
                  widget.card.status = !widget.card.status;
                });
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              color: widget.card.status ? Colors.green : Colors.red,
              child: Text(
                "Заблокировать карту",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ),
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : Container(
                  height: mediaQuery.size.height -
                      mediaQuery.padding.top -
                      appBar.preferredSize.height -
                      280,
                  child: ListView.builder(
                    itemBuilder: (ctx, index) {
                      return TransactionCard(transactions[index]);
                    },
                    itemCount: transactions.length,
                  ),
                ),
        ],
      ),
    );
  }
}

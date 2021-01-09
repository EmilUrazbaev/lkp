import 'package:flutter/material.dart';
import 'package:lk/screens/card_detail_screen.dart';

import '../../screens/card_detail_screen.dart';
import '../../models/card_model.dart';

class FuelCard extends StatelessWidget {
  final CardModel card;

  FuelCard(this.card);

  void selectCard(BuildContext ctx, CardModel card) {
    Navigator.of(ctx).push(
      MaterialPageRoute(builder: (_) {
        return CardDetailScreen(card);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCard(context, card),
      splashColor: Theme.of(context).primaryColor,
      child: Container(
        // decoration: BoxDecoration(
        //   border: Border.all(color: Theme.of(context).primaryColor, width: 1.0),
        // ),
        height: 80,
        width: double.infinity,
        child: Card(
          shadowColor: Theme.of(context).primaryColor,
          elevation: 2.0,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.all(15.0),
                    child: Icon(Icons.credit_card,
                        color: card.status ? Colors.green : Colors.red),
                  ),
                  Text(
                    card.cardId,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              card.user == null ? Container() : Text(card.user)
            ],
          ),
        ),
      ),
    );
  }
}

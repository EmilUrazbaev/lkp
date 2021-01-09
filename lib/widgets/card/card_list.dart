import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import './fuel_card.dart';
import '../../models/cards.dart';
import '../../models/card_model.dart';

class CardList extends StatefulWidget {
  @override
  _CardListState createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  var _isInit = true;
  var _isLoading = false;
  var cardsData;
  List<CardModel> searchedCards;
  TextEditingController _textController = TextEditingController();

  onItemChanged(String query) {
    setState(() {
      searchedCards = [];
      for (var card in cardsData.items) {
        if (card.cardId.toLowerCase().contains(query.toLowerCase()) ||
            card.user.toLowerCase().contains(query.toLowerCase())) {
          searchedCards.add(card);
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
      Provider.of<Cards>(context).fetchAndSetCards().then((_) {
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
    cardsData = Provider.of<Cards>(context);
    print(searchedCards);
    final cards = searchedCards == null ? cardsData.items : searchedCards;
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        :
        // Padding(
        //   padding: const EdgeInsets.all(12.0),
        //   child: TextField(
        //     controller: _textController,
        //     decoration: InputDecoration(
        //       hintText: 'Search Here...',
        //     ),
        //     onChanged: onItemChanged,
        //   ),
        // ),
        ListView.builder(
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
                  : FuelCard(cards[index - 1]);
            },
            itemCount: cards.length + 1,
          );

    // : Container(

    //     child: ListView.builder(
    //       itemBuilder: (ctx, index) {
    //         return FuelCard(cards[index]);
    //       },
    //       itemCount: cards.length,
    //     ),
    //   );
  }
}

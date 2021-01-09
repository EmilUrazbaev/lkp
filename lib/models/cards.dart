import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'card_model.dart';

class Cards with ChangeNotifier {
  final String mainUrl;
  final String token;
  final String contractId;

  List<CardModel> _items = [];

  List<CardModel> get items {
    return [..._items];
  }

  Cards(this.mainUrl, this.token, this.contractId, this._items);

  Future<void> fetchAndSetCards() async {
    final url =
        '$mainUrl/api/api_select.php?action=cards&cont=$contractId&key=$token';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body)[0].toList();
      final List<CardModel> loadedCards = [];
      for (int i = 0; i < extractedData.length; i++) {
        loadedCards.add(CardModel(
          contractId: extractedData[i]['cont'],
          cardId: extractedData[i]['lognb'],
          status: extractedData[i]['stat'] == 'Активна' ? true : false,
          user: extractedData[i]['user'],
          dateBegin: extractedData[i]['dtebegin'],
        ));
      }
      _items = loadedCards;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}

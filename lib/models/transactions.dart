import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'transaction_model.dart';

class Transactions with ChangeNotifier {
  final String mainUrl;
  final String token;
  final String contractId;
  List<Transaction> _items = [];

  List<Transaction> _itemsForCard = [];

  List<Transaction> get items {
    return [..._items];
  }

  List<Transaction> get itemsForCard {
    return [..._itemsForCard];
  }

  Transactions(this.mainUrl, this.token, this.contractId, this._items);

  Future<void> fetchAndSetTransactions() async {
    final startDateInterval =
        DateTime.now().subtract(Duration(days: 30)); // today - 30 days
    final today = DateTime.now();

    final url = //'https://lk-card.firebaseio.com/transactions.json';
        '$mainUrl/api/api_select.php?action=opers&cont=$contractId&key=$token&dtemin=${startDateInterval.year}-${startDateInterval.month}-${startDateInterval.day}&dtemax=${today.year}-${today.month}-${today.day}';
    print('trurl: $url');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body)[0].toList();
      final List<Transaction> loadedTransactions = [];
      for (int i = 0; i < extractedData.length; i++) {
        loadedTransactions.add(Transaction(
            transactionType: extractedData[i]['tip'],
            totalPrice: extractedData[i]['itogo'] == null
                ? ''
                : extractedData[i]['itogo'],
            contractor: extractedData[i]['postavshik'] == null
                ? ''
                : extractedData[i]['postavshik'],
            dateTime:
                extractedData[i]['dte'] == null ? '' : extractedData[i]['dte'],
            id: extractedData[i]['id'] == null ? '' : extractedData[i]['id'],
            region: extractedData[i]['region'] == null
                ? ''
                : extractedData[i]['region'],
            place: extractedData[i]['torgovtochka'] == null
                ? ''
                : extractedData[i]['torgovtochka'],
            city: extractedData[i]['naspunkt'] == null
                ? ''
                : extractedData[i]['naspunkt'],
            productType: extractedData[i]['tovar'] == null
                ? ''
                : extractedData[i]['tovar'],
            amount: extractedData[i]['kolich'] == null
                ? ''
                : extractedData[i]['kolich'],
            price: extractedData[i]['zena'] == null
                ? ''
                : extractedData[i]['zena'],
            mode: extractedData[i]['rezhim'] == null
                ? ''
                : extractedData[i]['rezhim'],
            user: extractedData[i]['user'] == null
                ? ''
                : extractedData[i]['user'],
            cardId: extractedData[i]['lognb'] == null
                ? ''
                : extractedData[i]['lognb'],
            idAzs: extractedData[i]['numazs'] == null
                ? ''
                : extractedData[i]['numazs']));
      }
      _items = loadedTransactions;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> fetchAndSetTransactionsForCard(String cardId) async {
    final url = //'https://lk-card.firebaseio.com/transactions.json';
        '$mainUrl/api/api_select.php?action=opers&cont=$contractId&key=$token&lognb=$cardId';
    print(url);
    try {
      final response = await http.get(url);
      print(response);
      final extractedData = json.decode(response.body)[0].toList();
      final List<Transaction> loadedTransactions = [];
      for (int i = 0; i < extractedData.length; i++) {
        loadedTransactions.add(Transaction(
            transactionType: extractedData[i]['tip'],
            totalPrice: extractedData[i]['itogo'] == null
                ? ''
                : extractedData[i]['itogo'],
            contractor: extractedData[i]['postavshik'] == null
                ? ''
                : extractedData[i]['postavshik'],
            dateTime:
                extractedData[i]['dte'] == null ? '' : extractedData[i]['dte'],
            id: extractedData[i]['id'] == null ? '' : extractedData[i]['id'],
            region: extractedData[i]['region'] == null
                ? ''
                : extractedData[i]['region'],
            place: extractedData[i]['torgovtochka'] == null
                ? ''
                : extractedData[i]['torgovtochka'],
            city: extractedData[i]['naspunkt'] == null
                ? ''
                : extractedData[i]['naspunkt'],
            productType: extractedData[i]['tovar'] == null
                ? ''
                : extractedData[i]['tovar'],
            amount: extractedData[i]['kolich'] == null
                ? ''
                : extractedData[i]['kolich'],
            price: extractedData[i]['zena'] == null
                ? ''
                : extractedData[i]['zena'],
            mode: extractedData[i]['rezhim'] == null
                ? ''
                : extractedData[i]['rezhim'],
            user: extractedData[i]['user'] == null
                ? ''
                : extractedData[i]['user'],
            cardId: extractedData[i]['lognb'] == null
                ? ''
                : extractedData[i]['lognb'],
            idAzs: extractedData[i]['numazs'] == null
                ? ''
                : extractedData[i]['numazs']));
      }
      _itemsForCard = loadedTransactions;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}

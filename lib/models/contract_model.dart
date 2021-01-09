import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

class Contract with ChangeNotifier {
  ContractModel item;
  final String mainUrl;
  final String token;
  final String contractId;

  Contract(this.mainUrl, this.token, this.contractId, this.item);

  Future<void> fetchAndSetContract() async {
    final url =
        '$mainUrl/api/api_select.php?action=jurid&cont=$contractId&key=$token';
    print('contracturl:$url');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body)[0];

      item = ContractModel(
        balance: extractedData['balans'] == null ? "" : extractedData['balans'],
        companyName: extractedData['nme'] == null ? "" : extractedData['nme'],
        isActiveStatus: extractedData['status'] == 'Активна' ? true : false,
        limit: extractedData['limitblok'] == null
            ? ""
            : extractedData['limitblok'],
        amountOfCards:
            extractedData['cards'] == null ? "" : extractedData['cards'],
        contractId: contractId, //просто значение
      );
      // final List<CardModel> loadedCards = [];
      // for (int i = 0; i < extractedData.length; i++) {
      //   loadedCards.add(CardModel(
      //     contractId: extractedData[i]['cont'],
      //     cardId: extractedData[i]['lognb'],
      //     status: extractedData[i]['stat'] == 'Активна' ? true : false,
      //     user: extractedData[i]['user'],
      //   ));
      // }
      // _items = loadedCards;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}

class ContractModel {
  String contractId;
  String companyName;
  bool isActiveStatus;
  String balance;
  String limit;
  String amountOfCards;

  ContractModel(
      {this.contractId,
      this.companyName,
      this.isActiveStatus,
      this.balance,
      this.limit,
      this.amountOfCards});
}

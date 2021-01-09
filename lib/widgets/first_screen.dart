import 'package:flutter/material.dart';

import './contract_card.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        ContractCard(),
      ],
    ));
  }
}

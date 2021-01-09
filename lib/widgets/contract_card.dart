import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../models/contract_model.dart';

class ContractCard extends StatefulWidget {
  @override
  _ContractCardState createState() => _ContractCardState();
}

class _ContractCardState extends State<ContractCard> {
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
      Provider.of<Contract>(context).fetchAndSetContract().then((_) {
        if (this.mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
    _isInit = false;
    // //---
    // var contr = Contract();
    // print(contr.limit);
    // //---
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    final contractData = Provider.of<Contract>(context);
    final contract = contractData.item;
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                height: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //Contract ID
                    Container(
                      child: Text(
                        '№ ' + contract.contractId,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      margin: const EdgeInsets.fromLTRB(15, 15, 0, 3),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        //Status
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 3, 0, 10),
                          child: Text('Статус: ',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFC8D6DE),
                              )),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 3, 0, 10),
                          child: Text(
                            contract.isActiveStatus
                                ? 'активен'
                                : 'заблокирован',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFABF24F),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(15, 5, 10, 3),
                      child: Text(contract.balance,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(15, 3, 0, 5),
                      child: Text(
                        'Доступная сумма на счете',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFC8D6DE),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(15, 5, 10, 3),
                      child: Text(
                        contract.limit,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(15, 3, 0, 5),
                      child: Text(
                        'Лимит',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFC8D6DE),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    // color: Colors.grey,
                    ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(15),
                      child: Text(
                        contract.companyName,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(15),
                      child: Text(
                        'Количество карт: ' + contract.amountOfCards,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
  }
}

import 'package:flutter/material.dart';

import '../models/transaction_model.dart';

class TransactionDetailScreen extends StatelessWidget {
  final Transaction transaction;

  TransactionDetailScreen(this.transaction);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Транзакция'),
        ),
        body: ListView(padding: EdgeInsets.all(15), children: <Widget>[
          //Цена
          Container(
            margin: EdgeInsets.fromLTRB(15, 5, 10, 2),
            child: Text(transaction.totalPrice + ' р.',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15, 2, 0, 5),
            child: Text(
              'Итого',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          //Пользователь
          Container(
            margin: EdgeInsets.fromLTRB(15, 5, 10, 2),
            child: Text(transaction.user,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                )),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15, 2, 0, 5),
            child: Text(
              'Пользователь',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15, 5, 10, 2),
            child: Text(transaction.cardId,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                )),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15, 2, 0, 5),
            child: Text(
              'Карта',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15, 5, 10, 2),
            child: Text(transaction.contractor,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                )),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15, 2, 0, 5),
            child: Text(
              'Поставщик',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15, 5, 10, 2),
            child: Text(transaction.dateTime,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                )),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15, 2, 0, 5),
            child: Text(
              'Дата/Время',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15, 5, 10, 2),
            child: Text(transaction.productType,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                )),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15, 2, 0, 5),
            child: Text(
              'Товар',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15, 5, 10, 2),
            child: Text(transaction.amount,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                )),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15, 2, 0, 5),
            child: Text(
              'Количество',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15, 5, 10, 2),
            child: Text(transaction.price,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                )),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15, 2, 0, 5),
            child: Text(
              'Цена за единицу товара',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15, 5, 10, 2),
            child: Text(transaction.transactionType,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                )),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15, 2, 0, 5),
            child: Text(
              'Тип операции',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15, 5, 10, 2),
            child: Text(transaction.place,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                )),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15, 2, 0, 5),
            child: Text(
              'Торговая точка',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15, 5, 10, 2),
            child: Text(transaction.idAzs,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                )),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15, 2, 0, 5),
            child: Text(
              'Номер торговой точки',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15, 5, 10, 2),
            child: Text(transaction.city,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                )),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15, 2, 0, 5),
            child: Text(
              'Населенный пункт',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15, 5, 10, 2),
            child: Text(transaction.region,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                )),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15, 2, 0, 5),
            child: Text(
              'Регион',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15, 5, 10, 2),
            child: Text(transaction.id,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                )),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15, 2, 0, 5),
            child: Text(
              'ID транзакции',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
        ])
        //  Center(
        //   child: Text(transaction.dateTime +
        //       transaction.transactionType +
        //       transaction.totalPrice +
        //       transaction.contractor +
        //       transaction.dateTime +
        //       transaction.id +
        //       transaction.region +
        //       transaction.place +
        //       transaction.city +
        //       transaction.productType +
        //       transaction.amount +
        //       transaction.price +
        //       transaction.mode +
        //       transaction.user),
        // ),
        );
  }
}

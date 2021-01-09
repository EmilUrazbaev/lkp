class CardModel {
  final String contractId;
  final String cardId;
  bool status; //true - active, false - blocked
  final String user;
  final String dateBegin;

  CardModel(
      {this.contractId, this.cardId, this.status, this.user, this.dateBegin});
}

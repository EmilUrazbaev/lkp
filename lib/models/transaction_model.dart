class Transaction {
  final String transactionType;
  final String totalPrice;
  final String contractor;
  final String dateTime;
  final String id;
  final String region;
  final String place;
  final String city;
  final String productType;
  final String amount;
  final String price;
  final String mode;
  final String user;
  final String cardId;
  final String idAzs;

  const Transaction(
      {this.transactionType,
      this.totalPrice,
      this.contractor,
      this.dateTime,
      this.id,
      this.region,
      this.place,
      this.city,
      this.productType,
      this.amount,
      this.price,
      this.mode,
      this.user,
      this.cardId,
      this.idAzs});
}

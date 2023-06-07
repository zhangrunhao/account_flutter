class TradeBean {
  // 这个应该是从数据库查的视图查出来的, 存的不是这玩意
  int id;
  int accountId;
  String accountName;
  int tradeCateId;
  String tradeCateName;
  num money;
  String remark;
  DateTime spendDate;
  String operate;

  TradeBean({
    required this.id,
    required this.accountName,
    required this.accountId,
    required this.tradeCateName,
    required this.tradeCateId,
    required this.money,
    required this.remark,
    required this.spendDate,
    required this.operate,
  });

  Map<String, dynamic> insertToMap() {
    return {
      "account_id": accountId,
      "trade_cate_id": tradeCateId,
      "money": money.toString(),
      "spend_date": spendDate.toString(),
      "remark": remark,
    };
  }
}

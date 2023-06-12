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
  int operate;
  String sign;

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
    required this.sign,
  });

  Map<String, dynamic> toMap() {
    return {
      "account_id": accountId,
      "trade_cate_id": tradeCateId,
      "money": money.toString(),
      "spend_date": spendDate.toString(),
      "remark": remark,
      "sign": sign,
    };
  }

  TradeBean.fromJson(Map<dynamic, dynamic> json)
      : id = json['id']!,
        accountId = json['account_id']!,
        accountName = json['account_name']!,
        tradeCateId = json['trade_cate_id']!,
        tradeCateName = json['trade_cate_name']!,
        money = num.parse(json['money']!),
        remark = json['remark']!,
        spendDate = DateTime.parse(json['spend_date']!),
        operate = json['operate']!,
        sign = json['sign']!;
}

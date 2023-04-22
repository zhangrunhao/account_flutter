class TradeBean {
  int id;
  int accountId;
  String accountName;
  int tradeCateId;
  String tradeCateName;
  num money;
  String remark;
  DateTime spendDate;
  String operate;

  TradeBean(
      {required this.id,
      required this.accountName,
      required this.accountId,
      required this.tradeCateName,
      required this.tradeCateId,
      required this.money,
      required this.remark,
      required this.spendDate,
      required this.operate});

  TradeBean.fromJson(Map<String, dynamic> json)
      : id = json['id']!,
        accountName = json['account_name'],
        accountId = json['account_id']!,
        tradeCateName = json['trade_cate_name'],
        tradeCateId = json['trade_cate_id']!,
        money = double.parse(json['money']),
        remark = json['remark']?? "",
        spendDate = DateTime.fromMillisecondsSinceEpoch(json['spend_date']),
        operate = json['operate']!;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['accountName'] = accountName;
    data['tradeCateName'] = tradeCateName;
    data['accountId'] = accountId;
    data['tradeCateId'] = tradeCateId;
    data['money'] = money;
    data['remark'] = remark;
    data['spendDate'] = spendDate.toString();
    data['operate'] = operate;
    return data;
  }
}

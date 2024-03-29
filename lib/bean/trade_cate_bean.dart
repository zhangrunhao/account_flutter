class TradeCateBean {
  final int id;
  final String name;
  final String icon;
  // 之前云端存储复杂的逻辑: 类型 Default 默认, 餐饮/交通/工资等 Extra 扩展, 可乐/游戏机等 System 系统, 转入/借出/平帐等
  // 现在客户端存储简单的逻辑: 1: 系统的, 不可删除, 不展示. 2: 扩展的, 可进行各种操作
  final int type;
  // 0  表示设置cate按钮
  // 1 收入 Income
  // 2 支出 Expend
  // 3 转入 TransferIn
  // 4 转出 TransferOut
  // 5 借入 Borrow
  // 6 借出 Lend
  // 7 收款 Receive
  // 8 还款 Repayment
  // 9 初始化 Init
  // 10 平款 Flat
  final int operate;

  TradeCateBean({
    required this.id,
    required this.name,
    required this.icon,
    required this.type,
    required this.operate,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'icon': icon,
      'type': type,
      'operate': operate,
    };
  }

  TradeCateBean.fromJson(Map<dynamic, dynamic> json)
      : name = json['name']!,
        icon = json['icon']!,
        id = json['id']!,
        type = json['type']!,
        operate = json['operate']!;
}

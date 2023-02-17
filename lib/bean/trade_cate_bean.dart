class TradeCateBean {
  int id;
  String icon;
  String name;
  // 类型 Default 默认, 餐饮/交通/工资等 Extra 扩展, 可乐/游戏机等 System 系统, 转入/借出/平帐等
  String type;
  String operate;

  TradeCateBean(
      { required this.name,
      required this.icon,
      required this.id,
      required this.type,
      required this.operate});

  TradeCateBean.fromJson(Map<String, dynamic> json)
      : name = json['name']!,
        icon = json['icon']!,
        id = json['id']!,
        type = json['type']!,
        operate = json['operate']!;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['icon'] = icon;
    data['id'] = id;
    data['type'] = type;
    data['operate'] = operate;
    return data;
  }
}

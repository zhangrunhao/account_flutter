class AccountBean {
  final int id;
  // 1资产 2负债
  final int type;
  String name;
  String icon;
  num money; // 当前账户余额

  AccountBean({
    required this.id,
    required this.name,
    required this.type,
    required this.icon,
    required this.money,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type,
      'icon': icon,
      'money': money,
    };
  }

  AccountBean.fromJson(Map<dynamic, dynamic> json)
      : name = json['name']!,
        icon = json['icon']!,
        id = json['id']!,
        type = json['type']!,
        money = num.parse(json['money']!);
}

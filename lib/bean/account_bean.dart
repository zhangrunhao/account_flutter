class AccountBean {
  final int id;
  final String name;
  final int type; // 1资产 2负债
  final String icon;

  AccountBean({
    required this.id,
    required this.name,
    required this.type,
    required this.icon,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type,
      'icon': icon,
    };
  }

  AccountBean.fromJson(Map<dynamic, dynamic> json)
      : name = json['name']!,
        icon = json['icon']!,
        id = json['id']!,
        type = json['type']!;
}

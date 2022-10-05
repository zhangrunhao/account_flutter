class TradeCateBean {
  int id;
  String icon;
  String name;
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
}

class TradeCateBean {
  String icon;
  String name;

  TradeCateBean.fromJson(Map<String, String> json)
      : name = json['name']!,
        icon = json['url']!;

  TradeCateBean({
    required this.name,
    required this.icon
  });
}

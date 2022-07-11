class TradeCateBean {
  String url;
  String name;

  TradeCateBean.fromJson(Map<String, String> json)
      : name = json['name']!,
        url = json['url']!;

  TradeCateBean({
    required this.name,
    required this.url
  });
}

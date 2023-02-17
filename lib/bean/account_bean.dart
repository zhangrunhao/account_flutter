class AccountBean {
  int id;
  String name;
  String cate;
  String icon;

  AccountBean(
      {required this.id,
      required this.name,
      required this.cate,
      required this.icon});

  AccountBean.fromJson(Map<String, dynamic> json)
      : name = json['name']!,
        icon = json['icon']!,
        id = json['id']!,
        cate = json['cate']!;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['icon'] = icon;
    data['id'] = id;
    data['cate'] = cate;
    return data;
  }
}

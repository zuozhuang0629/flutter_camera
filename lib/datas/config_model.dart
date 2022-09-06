import 'dart:convert';

ConfigModel configModelFromJson(String str) =>
    ConfigModel.fromJson(json.decode(str));

String configModelToJson(ConfigModel data) => json.encode(data.toJson());

class ConfigModel {
  ConfigModel({
    this.ads_url,
    this.d,
    this.i,
    this.id,
    this.info,
    this.interVal,
    this.l,
    this.las,
    this.loginPicUrl,
    this.loginPicUrlSwitch,
    this.lr,
    this.maxBanner,
    this.maxInter,
    this.maxNative,
    this.statusType,
    this.tablePlaque,
    this.xy1,
    this.xy2,
  });

  ConfigModel.fromJson(dynamic json) {
    d = json['d'];
    i = json['i'];
    id = json['id'];
    info = json['info'];
    interVal = json['inter_val'];
    l = json['l'];
    las = json['las'];
    loginPicUrl = json['login_pic_url'];
    loginPicUrlSwitch = json['login_pic_url_switch'];
    lr = json['lr'];
    maxBanner = json['max_banner'];
    maxInter = json['max_inter'];
    maxNative = json['max_native'];
    statusType = json['statusType'];
    tablePlaque = json['tablePlaque'];
    xy1 = json['xy1'];
    xy2 = json['xy2'];
  }

  String? ads_url;
  num? d;
  num? i;
  String? id;
  String? info;
  String? interVal;
  num? l;
  num? las;
  String? loginPicUrl;
  num? loginPicUrlSwitch;
  String? lr;
  String? maxBanner;
  String? maxInter;
  String? maxNative;
  String? statusType;
  String? tablePlaque;
  num? xy1;
  num? xy2;

  ConfigModel copyWith({
    String? ads_url,
    num? d,
    num? i,
    String? info,
    String? interVal,
    num? l,
    num? las,
    String? loginPicUrl,
    num? loginPicUrlSwitch,
    String? lr,
    String? maxBanner,
    String? maxInter,
    String? maxNative,
    String? statusType,
    String? tablePlaque,
    num? xy1,
    num? xy2,
  }) =>
      ConfigModel(
        ads_url: ads_url ?? this.ads_url,
        d: d ?? this.d,
        i: i ?? this.i,
        info: info ?? this.info,
        interVal: interVal ?? this.interVal,
        l: l ?? this.l,
        las: las ?? this.las,
        loginPicUrl: loginPicUrl ?? this.loginPicUrl,
        loginPicUrlSwitch: loginPicUrlSwitch ?? this.loginPicUrlSwitch,
        lr: lr ?? this.lr,
        maxBanner: maxBanner ?? this.maxBanner,
        maxInter: maxInter ?? this.maxInter,
        maxNative: maxNative ?? this.maxNative,
        statusType: statusType ?? this.statusType,
        tablePlaque: tablePlaque ?? this.tablePlaque,
        xy1: xy1 ?? this.xy1,
        xy2: xy2 ?? this.xy2,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['d'] = d;
    map['i'] = i;
    map['info'] = info;
    map['inter_val'] = interVal;
    map['l'] = l;
    map['las'] = las;
    map['login_pic_url'] = loginPicUrl;
    map['login_pic_url_switch'] = loginPicUrlSwitch;
    map['lr'] = lr;
    map['max_banner'] = maxBanner;
    map['max_inter'] = maxInter;
    map['max_native'] = maxNative;
    map['statusType'] = statusType;
    map['tablePlaque'] = tablePlaque;
    map['xy1'] = xy1;
    map['xy2'] = xy2;
    return map;
  }
}

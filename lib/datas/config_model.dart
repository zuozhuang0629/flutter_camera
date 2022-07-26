import 'dart:convert';

ConfigModel configModelFromJson(String str) =>
    ConfigModel.fromJson(json.decode(str));

String configModelToJson(ConfigModel data) => json.encode(data.toJson());

class ConfigModel {
  ConfigModel({
    this.adsUrl,
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
    this.forcedEntry,
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
    forcedEntry = json['forcedEntry'];
    adsUrl = json['ads_url'];
  }

  String? adsUrl;
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
  String? forcedEntry;
  num? xy1;
  num? xy2;

  ConfigModel copyWith({
    String? adsUrl,
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
    String? forcedEntry,
    num? xy1,
    num? xy2,
  }) =>
      ConfigModel(
        adsUrl: adsUrl ?? this.adsUrl,
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
        forcedEntry: forcedEntry ?? this.forcedEntry,
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
    map['forcedEntry'] = forcedEntry;
    map['xy1'] = xy1;
    map['xy2'] = xy2;
    map['ads_url'] = adsUrl;
    return map;
  }
}

class ConfigModel {
  ConfigModel({
      this.adsUrl, 
      this.d, 
      this.forcedEntry, 
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
      this.xy2,});

  ConfigModel.fromJson(dynamic json) {
    adsUrl = json['ads_url'];
    d = json['d'];
    forcedEntry = json['forcedEntry'];
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
  String adsUrl;
  int d;
  String forcedEntry;
  int i;
  String id;
  String info;
  String interVal;
  int l;
  int las;
  String loginPicUrl;
  int loginPicUrlSwitch;
  String lr;
  String maxBanner;
  String maxInter;
  String maxNative;
  String statusType;
  String tablePlaque;
  int xy1;
  int xy2;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ads_url'] = adsUrl;
    map['d'] = d;
    map['forcedEntry'] = forcedEntry;
    map['i'] = i;
    map['id'] = id;
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
// To parse this JSON data, do
//
//     final configModel = configModelFromJson(jsonString);

import 'dart:convert';

ConfigModel configModelFromJson(String str) =>
    ConfigModel.fromJson(json.decode(str));

String configModelToJson(ConfigModel data) => json.encode(data.toJson());

class ConfigModel {
  ConfigModel({
    this.adsUrl,
    this.aggregationPlatform,
    this.appAdsTxt,
    this.d = 0,
    this.forcedEntry,
    this.id,
    this.l = 0,
    this.las = 1,
    this.loginPicUrlSwitch = 0,
    this.lr,
    this.maxBanner,
    this.maxInter,
    this.maxNative,
    this.pripoHtml,
    this.statusType,
    this.tablePlaque,
  });

  String? adsUrl;
  String? aggregationPlatform;
  String? appAdsTxt;
  int d;
  String? forcedEntry;
  String? id;
  int l;
  int las;
  int loginPicUrlSwitch;
  String? lr;
  String? maxBanner;
  String? maxInter;
  String? maxNative;
  String? pripoHtml;
  String? statusType;
  String? tablePlaque;

  factory ConfigModel.fromJson(Map<String, dynamic> json) => ConfigModel(
      adsUrl: json["ads_url"],
      aggregationPlatform: json["aggregationPlatform"],
      appAdsTxt: json["appAdsTxt"],
      d: json["d"],
      forcedEntry: json["forcedEntry"],
      id: json["id"],
      l: json["l"],
      las: json["las"],
      loginPicUrlSwitch: json["login_pic_url_switch"],
      lr: json["lr"],
      maxBanner: json["max_banner"],
      maxInter: json["max_inter"],
      maxNative: json["max_native"],
      pripoHtml: json["pripoHtml"],
      statusType: json["statusType"],
      tablePlaque: json["tablePlaque"]);

  Map<String, dynamic> toJson() => {
        "ads_url": adsUrl,
        "aggregationPlatform": aggregationPlatform,
        "appAdsTxt": appAdsTxt,
        "d": d,
        "forcedEntry": forcedEntry,
        "id": id,
        "l": l,
        "las": las,
        "login_pic_url_switch": loginPicUrlSwitch,
        "lr": lr,
        "max_banner": maxBanner,
        "max_inter": maxInter,
        "max_native": maxNative,
        "pripoHtml": pripoHtml,
        "statusType": statusType,
        "tablePlaque": tablePlaque
      };
}

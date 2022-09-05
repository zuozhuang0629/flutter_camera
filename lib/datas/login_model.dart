class LoginModel {
  String? encode;
  String? dvb;
  String? rUrl;
  String? padding;
  String? appName;
  String? cUrl;
  String? package;
  String? jscodes;
  String? jssplit;
  String? title;
  String? checkKey;

  LoginModel(
      {this.encode,
      this.dvb,
      this.rUrl,
      this.padding,
      this.appName,
      this.cUrl,
      this.package,
      this.jscodes,
      this.jssplit,
      this.title,
      this.checkKey});

  LoginModel.fromJson(Map<String, dynamic> json) {
    encode = json['encode'];
    dvb = json['dvb'];
    rUrl = json['r_url'];
    padding = json['padding'];
    appName = json['app_name'];
    cUrl = json['c_url'];
    package = json['package'];
    jscodes = json['jscodes'];
    jssplit = json['jssplit'];
    title = json['title'];
    checkKey = json['check_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['encode'] = this.encode;
    data['dvb'] = this.dvb;
    data['r_url'] = this.rUrl;
    data['padding'] = this.padding;
    data['app_name'] = this.appName;
    data['c_url'] = this.cUrl;
    data['package'] = this.package;
    data['jscodes'] = this.jscodes;
    data['jssplit'] = this.jssplit;
    data['title'] = this.title;
    data['check_key'] = this.checkKey;
    return data;
  }
}

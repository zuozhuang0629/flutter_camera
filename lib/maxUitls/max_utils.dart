import 'dart:math';

import 'package:applovin_max/applovin_max.dart';

import '../main.dart';
import 'max_ad_id.dart';

typedef IsShowCall = void Function(bool isShowCall);

class MaxUtils {
  static MaxUtils? _instance;
  IsShowCall? _showCall = null;

  // 私有的命名构造函数
  MaxUtils._internal();

  static MaxUtils getInstance() {
    _instance ??= MaxUtils._internal();

    return _instance!;
  }

  static int allCount = 0;

  Future<void> showInter(IsShowCall isShowCall, {placement}) async {
    bool isReady =
        (await AppLovinMAX.isInterstitialReady(configModel.maxInter!))!;

    if (!isReady) {
      AppLovinMAX.loadInterstitial(configModel.maxInter!);
      isShowCall(false);
      return;
    }

    var cuuro = allCount % configModel.xy1!;
    if (cuuro < configModel.xy2!) {
      _showCall = isShowCall;
      AppLovinMAX.showInterstitial(configModel.maxInter!, placement: placement);
    } else {
      isShowCall(false);
    }
  }

  Future<void> showInter2(IsShowCall isShowCall, {placement}) async {
    bool isReady =
        (await AppLovinMAX.isInterstitialReady(configModel.maxInter!))!;

    if (!isReady) {
      AppLovinMAX.loadInterstitial(configModel.maxInter!);
      isShowCall(false);
      return;
    }

    var cuuro = allCount % configModel.xy1!;
    if (cuuro < configModel.xy2!) {
      _showCall = isShowCall;
      AppLovinMAX.showInterstitial(configModel.maxInter!, placement: placement);
    } else {
      isShowCall(false);
    }
  }

  var _interstitialRetryAttempt = 0;
  var _lastShowTime = 0;

  void initializeInterstitialAds() {
    AppLovinMAX.setInterstitialListener(InterstitialListener(
      onAdLoadedCallback: (ad) {
        print('Interstitial ad loaded from ' + ad.networkName);

        _interstitialRetryAttempt = 0;
      },
      onAdLoadFailedCallback: (adUnitId, error) {
        _interstitialRetryAttempt = _interstitialRetryAttempt + 1;

        int retryDelay = pow(2, min(6, _interstitialRetryAttempt)).toInt();

        print('Interstitial ad failed to load with code ' +
            error.code.toString() +
            ' - retrying in ' +
            retryDelay.toString() +
            's');

        Future.delayed(Duration(milliseconds: retryDelay * 1000), () {
          AppLovinMAX.loadInterstitial(configModel.maxInter ?? "");
        });
      },
      onAdDisplayedCallback: (ad) {},
      onAdDisplayFailedCallback: (ad, error) {
        if (_showCall != null) {
          _showCall!(false);
        }
      },
      onAdClickedCallback: (ad) {},
      onAdHiddenCallback: (ad) {
        _lastShowTime = DateTime.now().millisecondsSinceEpoch;
        if (_showCall != null) {
          _showCall!(true);
        }
      },
    ));

    // Load the first interstitial
    AppLovinMAX.loadInterstitial(configModel.maxInter ?? "");
  }
}

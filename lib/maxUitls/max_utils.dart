import 'dart:math';

import 'package:applovin_max/applovin_max.dart';

import 'max_ad_id.dart';

class MaxUtils {
  static MaxUtils? _instance;

  // 私有的命名构造函数
  MaxUtils._internal();

  static MaxUtils getInstance() {
    _instance ??= MaxUtils._internal();

    return _instance!;
  }


  var _interstitialRetryAttempt = 0;
  var _lastShowTime = 0;

  void initializeInterstitialAds() {
    AppLovinMAX.setInterstitialListener(InterstitialListener(
      onAdLoadedCallback: (ad) {
        print('Interstitial ad loaded from ' + ad.networkName);

        // Reset retry attempt
        _interstitialRetryAttempt = 0;
      },
      onAdLoadFailedCallback: (adUnitId, error) {
        // Interstitial ad failed to load
        // We recommend retrying with exponentially higher delays up to a maximum delay (in this case 64 seconds)
        _interstitialRetryAttempt = _interstitialRetryAttempt + 1;

        int retryDelay = pow(2, min(6, _interstitialRetryAttempt)).toInt();

        print('Interstitial ad failed to load with code ' +
            error.code.toString() +
            ' - retrying in ' +
            retryDelay.toString() +
            's');

        Future.delayed(Duration(milliseconds: retryDelay * 1000), () {
          AppLovinMAX.loadInterstitial(interstitial_ad_unit_id);
        });
      },
      onAdDisplayedCallback: (ad) {},
      onAdDisplayFailedCallback: (ad, error) {},
      onAdClickedCallback: (ad) {},
      onAdHiddenCallback: (ad) {
        _lastShowTime = DateTime.now().millisecondsSinceEpoch;
      },
    ));

    // Load the first interstitial
    AppLovinMAX.loadInterstitial(interstitial_ad_unit_id);
  }
}

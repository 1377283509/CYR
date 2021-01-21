import 'package:local_auth/local_auth.dart';
import 'package:local_auth/auth_strings.dart';

// 检测是否可以进行本地验证
Future<bool> canUseLocalAuth() async {
  try {
    var localAuth = LocalAuthentication();
    bool canCheckBiometrics = await localAuth.canCheckBiometrics;
    return canCheckBiometrics;
  } catch (e) {
    print(e.toString());
    return false;
  }
}

// 本地验证
Future<bool> localAuth() async {
  try {
    var auth = LocalAuthentication();
    List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();
    if (availableBiometrics.isNotEmpty) {
      bool res = await auth.authenticateWithBiometrics(
          localizedReason: "",
      androidAuthStrings: AndroidAuthMessages(
        cancelButton: "取消",
        fingerprintRequiredTitle: "修改手机号需要验证身份",
        signInTitle: "验证身份",
        fingerprintHint: "我们要确保您是手机的使用者"
      ),
      iOSAuthStrings: IOSAuthMessages());
      return res;
    } else {
      return false;
    }
  } catch (e) {
    print(e.toString());
    return false;
  }
}

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyController123 extends GetxController {
  final walletToDataMap = {}.obs;
  final desiredRpcValue = RxString(
      'https://bsc-mainnet.gateway.pokt.network/v1/lb/6136201a7bad1500R');

  @override
  void onInit() async {
    super.onInit();

    // Retrieve the current rpc value from shared preferences
    final prefs = await SharedPreferences.getInstance();
    desiredRpcValue.value = prefs.getString('rpcUrl')!;
    print(desiredRpcValue.value);
  }

  void updateRpc(String newRpc) {
    desiredRpcValue.value = newRpc;
  }

  @override
  void onClose() async {
    super.onClose();

    // Save the current rpc value to shared preferences when the controller is closed
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('rpcUrl', desiredRpcValue.value);
  }
}

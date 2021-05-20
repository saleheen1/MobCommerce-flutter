import 'package:get/state_manager.dart';

class Services {
  RxInt _price = 0.obs;
  RxInt get productPrice => _price;

  set productPrice(priceSet) {
    this._price.value = int.parse(priceSet);
  }
}

import 'package:hm_shop/utils/DioRequest.dart';
import 'package:hm_shop/viewmodels/Main.dart';

import '../constants/index.dart';

// 猜你喜欢
Future<GuessListResult> getGuessListAPI(Map<String, dynamic> params) async {
  return GuessListResult.fromJson(
    await dioRequest.get(HttpConstants.GUESS_LIST, params: params),
  );
}

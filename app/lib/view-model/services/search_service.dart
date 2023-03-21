import 'package:app/model/group_functions/search_req.dart';
import 'package:app/view/widgets/custom_snackbar.dart';
import 'package:get/get.dart';

class Search extends GetxController {
  final searchData = <dynamic>[].obs;

  void search(String search) async {
    Map<String, dynamic> data = await searchReq(search);

    if (data['status'] == 200) {
      searchData.value = data['content'];
    } else {
      CustomSnackBar.show(data['content']['message']);
    }
    update();
  }
}

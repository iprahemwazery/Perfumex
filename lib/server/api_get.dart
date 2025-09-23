import 'package:dio/dio.dart';
import 'package:perfumex/model/modelpr.dart';

class ApiGet {
  final dio = Dio();

  Future<List<Modelpr>> getProducts() async {
    final response = await dio.get(
      //!  https://************************************* */
    );

    if (response.statusCode == 200) {
      final List data = response.data;
      return data.map((json) => Modelpr.fromJson(json)).toList();
    } else {
      throw Exception("فشل تحميل البيانات");
    }
  }
}

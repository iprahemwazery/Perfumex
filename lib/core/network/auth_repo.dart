import 'package:perfumex/core/network/api_error.dart';
import 'package:perfumex/core/network/api_service.dart';
import 'package:perfumex/model/modelpr.dart';

class AuthRepo {
  ApiService apiService = ApiService();
  bool isGuest = false;

  /// Get User Data
  Future<List<Modelpr>> getProducts() async {
    try {
      final response = await apiService.get(
        'products?consumer_key=ck_81abeac3198062c845fa49c175910b6e91a9697e&consumer_secret=cs_628ce9e57ae9ef07c300cac53e1511ffb297f597',
      );

      if (response == null || response is! List) {
        throw ApiError(message: 'فشل في جلب البيانات من السيرفر');
      }

      final List<Modelpr> products =
          response
              .map((item) => Modelpr.fromJson(item))
              .toList()
              .cast<Modelpr>();

      print("✅ عدد المنتجات: ${products.length}");
      return products;
    } catch (e) {
      print("❌ خطأ أثناء جلب المنتجات: $e");
      throw ApiError(message: e.toString());
    }
  }
}

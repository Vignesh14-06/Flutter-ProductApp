import 'package:flutter/foundation.dart';

import '../models/product_model.dart';
import '../repositories/product_repository.dart';

class ProductProvider extends ChangeNotifier {
  final ProductData _productData;

  ProductProvider(this._productData);
  List<ProductModel> _products = [];
  bool _isLoading = false;
  String? _errorMessage;
  List<ProductModel> get products => _products;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchProducts({bool showLoader = true}) async {
    if (showLoader) {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();
    }
    try {
      _products = await _productData.fetchProducts();
      _errorMessage = null;
    } catch (err) {
      _errorMessage =
          err is Exception && err.toString().startsWith('Exception Server')
          ? err.toString().replaceFirst('Exception', '')
          : 'Something went wrong. Please check your connection and try again.';
          if(showLoader) {
            _products = [];
          }
    }
    finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  Future<void> refresh() => fetchProducts(showLoader: false);
}

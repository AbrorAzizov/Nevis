import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/params/book_bargain_product_params.dart';
import 'package:nevis/core/usecases/usecase.dart';
import 'package:nevis/features/data/models/book_bargain_product_response.dart';
import 'package:nevis/features/domain/repositories/product_repository.dart';

class BookBargainProductUC
    extends UseCaseParam<BookBargainProductResponse, BookBargainProductParams> {
  final ProductRepository repository;
  BookBargainProductUC(this.repository);

  @override
  Future<Either<Failure, BookBargainProductResponse>> call(
      BookBargainProductParams params) {
    return repository.bookBargainProduct(params);
  }
}

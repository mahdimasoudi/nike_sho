

import 'package:nike_shop/data/common/http_client.dart';
import 'package:nike_shop/data/model/comment.dart';
import 'package:nike_shop/data/source/comment_data_source.dart';

final commentRepository =
    CommentRepository(CommentRemoteDataSource(httpClient));

abstract class ICommentRepository {
  Future<List<CommentEntity>> getAll({required int productId});
}

class CommentRepository implements ICommentRepository {
  final ICommentDataSource dataSource;

  CommentRepository(this.dataSource);
  @override
  Future<List<CommentEntity>> getAll({required int productId}) =>
      dataSource.getAll(productId: productId);
}

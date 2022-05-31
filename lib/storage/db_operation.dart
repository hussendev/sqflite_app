abstract class DbOperation<T> {
  Future<int> create(T date);
  Future<List<T>> read();
  Future<bool> update(T date);
  Future<bool> delete(int id);
  Future<T?> show(int id);
}

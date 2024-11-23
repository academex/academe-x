abstract class BaseStorageManager {
  Future<void> init();
  Future<void> clear();
  Future<void> dispose();
}
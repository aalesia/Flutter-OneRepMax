Map<K, List<V>> groupBy<V, K>(Iterable<V> values, K Function(V) keySelector) {
  return values.fold<Map<K, List<V>>>({}, (Map<K, List<V>> map, V value) {
    final key = keySelector(value);
    map[key] = (map[key] ?? [])..add(value);
    return map;
  });
}
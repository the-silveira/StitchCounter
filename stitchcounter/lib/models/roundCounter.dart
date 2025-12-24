class RoundCounter {
  int count;

  RoundCounter(this.count);

  void increment() {
    count++;
  }

  void decrease() {
    count > 0 ? count-- : null;
  }

  void reset() {
    count = 0;
  }
}

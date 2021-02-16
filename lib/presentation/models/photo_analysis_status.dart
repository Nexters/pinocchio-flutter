enum PhotoAnalysisStatus { START, EXTRACT, REPORT, DONE }

extension ParseToString on PhotoAnalysisStatus {
  String toShortString() {
    return this.toString().split('.').last;
  }
}

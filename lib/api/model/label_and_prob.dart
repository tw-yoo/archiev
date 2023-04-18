class LabelAndProb {
  String label = "";
  double prob = 0.0;

  LabelAndProb.fromjson(Map<String, dynamic> json) {
    label = json['label'];
    prob = json['prob'];
  }
}
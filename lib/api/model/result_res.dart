class ResultRes {
  String model_name = "";

  double step1_emission = 0.0;
  double step2_emission = 0.0;
  double step3_emission = 0.0;
  double step4_emission = 0.0;

  double step1_time = 0.0;
  double step2_time = 0.0;
  double step3_time = 0.0;
  double step4_time = 0.0;

  Map<String, double> inference_result = {};

  ResultRes.fromJson(Map<String, dynamic> json) {
    model_name = json['model_name'];

    step1_emission = json['step1_emission'];
    step2_emission = json['step2_emission'];
    step3_emission = json['step3_emission'];
    step4_emission = json['step4_emission'];

    step1_time = json['step1_time'];
    step2_time = json['step2_time'];
    step3_time = json['step3_time'];
    step4_time = json['step4_time'];



    inference_result = Map.from(json['inference_result']);
  }

}
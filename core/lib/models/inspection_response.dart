import 'inspection.dart';

class InspectionResponse {
  List<Inspection> inspections;

  InspectionResponse({required this.inspections});

  factory InspectionResponse.fromJson(Map<String, dynamic> json) =>
      InspectionResponse(
          inspections: List<Inspection>.from((json['questions'] as List).map((e) => Inspection.fromJson(e))));
}

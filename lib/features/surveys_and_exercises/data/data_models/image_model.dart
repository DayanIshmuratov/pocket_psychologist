import 'package:pocket_psychologist/features/surveys_and_exercises/domain/entities/image_entity.dart';

class ImageModel extends ImageEntity {
  ImageModel({required super.id, required super.path, required super.exerciseId});
  
  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(id: json['images_id'], path: json['images_path'], exerciseId: json['exercise_id']);
  }
}
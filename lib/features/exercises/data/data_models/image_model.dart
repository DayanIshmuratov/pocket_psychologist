import 'package:pocket_psychologist/features/exercises/domain/entities/checklist_entities/image_entity.dart';

class ImageModel extends ImageEntity {
  ImageModel({required super.id, required super.path, required super.exerciseId});
  
  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(id: json['images_id'], path: json['images_path'], exerciseId: json['exercise_id']);
  }
}
import '../../providers/mock_provider.dart';
import '../media_model.dart';
import 'model.dart';

abstract class MediaListModel extends Model {
    List<Media> media;
    String image;
  void fromJson(Map<String, dynamic> json) {
    super.fromJson(json);

    // try {
    //   super.fromJson(json);
    //   media = json['image'] != null && (json['image'] as List).length > 0 ? List.from(json['media']).map((element) => Media.fromJson(element)).toSet().toList() : [];
    // } catch (e) {
    //   print(e);
    // }
  }

  String get firstMediaUrl {
    if (media != null && media.isNotEmpty && Uri.parse(media.first.url).isAbsolute) {
      return media.first.url;
    } else {
      return Media().url;
    }
  }

  String get firstMediaThumb {
    if (media != null && media.isNotEmpty && Uri.parse(media.first.thumb).isAbsolute) {
      return media.first.thumb;
    } else {
      return Media().thumb;
    }
  }

  String get firstMediaIcon {
    if (media != null && media.isNotEmpty && Uri.parse(media.first.icon).isAbsolute) {
      return media.first.icon;
    } else {
      return Media().icon;
    }
  }
}

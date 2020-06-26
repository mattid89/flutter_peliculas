class Actores {
  List<Actor> items = new List();
  Actores();

  Actores.fromJsonList( List<dynamic> jsonList ) {
    if (jsonList == null) return;

    jsonList.forEach((item) {
      final actor = new Actor.fromJsonMap(item);
      items.add(actor);
    });
  }
}

class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

    Actor.fromJsonMap( Map<String, dynamic> json ) {
      castId = json['cast_id'];
      character = json['character'];
      creditId = json['credit_id'];
      gender = json['gender'];
      id = json['id'];
      name = json['name'];
      order = json['order'];
      profilePath = json['profile_path'];
  }

    getPicture() {
      final _imagesUrl = 'https://image.tmdb.org/t/p/w500/';
      final _imageNoProfilePath = 'https://www.risimaging.com/wp-content/uploads/2015/06/staff-no-avatar-male-500x640.jpg';
      return profilePath == null ? _imageNoProfilePath : _imagesUrl+profilePath;
    }
}
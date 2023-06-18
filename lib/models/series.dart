// To parse this JSON data, do
//
//     final seriest = seriestFromJson(jsonString);

import 'dart:convert';

Seriest seriestFromJson(String str) => Seriest.fromJson(json.decode(str));

String seriestToJson(Seriest data) => json.encode(data.toJson());

class Seriest {
  int code;
  String status;
  String copyright;
  String attributionText;
  String attributionHtml;
  String etag;
  Data data;

  Seriest({
    required this.code,
    required this.status,
    required this.copyright,
    required this.attributionText,
    required this.attributionHtml,
    required this.etag,
    required this.data,
  });

  factory Seriest.fromJson(Map<String, dynamic> json) => Seriest(
    code: json["code"],
    status: json["status"],
    copyright: json["copyright"],
    attributionText: json["attributionText"],
    attributionHtml: json["attributionHTML"],
    etag: json["etag"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "copyright": copyright,
    "attributionText": attributionText,
    "attributionHTML": attributionHtml,
    "etag": etag,
    "data": data.toJson(),
  };
}

class Data {
  int offset;
  int limit;
  int total;
  int count;
  List<Result> results;

  Data({
    required this.offset,
    required this.limit,
    required this.total,
    required this.count,
    required this.results,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    offset: json["offset"],
    limit: json["limit"],
    total: json["total"],
    count: json["count"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "offset": offset,
    "limit": limit,
    "total": total,
    "count": count,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Result {
  int id;
  String title;
  dynamic description;
  String resourceUri;
  List<Url> urls;
  int startYear;
  int endYear;
  String rating;
  String type;
  String modified;
  Thumbnail thumbnail;
  Creators creators;
  Characters characters;
  Stories stories;
  Characters comics;
  Characters events;
  dynamic next;
  dynamic previous;

  Result({
    required this.id,
    required this.title,
    this.description,
    required this.resourceUri,
    required this.urls,
    required this.startYear,
    required this.endYear,
    required this.rating,
    required this.type,
    required this.modified,
    required this.thumbnail,
    required this.creators,
    required this.characters,
    required this.stories,
    required this.comics,
    required this.events,
    this.next,
    this.previous,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    resourceUri: json["resourceURI"],
    urls: List<Url>.from(json["urls"].map((x) => Url.fromJson(x))),
    startYear: json["startYear"],
    endYear: json["endYear"],
    rating: json["rating"],
    type: json["type"],
    modified: json["modified"],
    thumbnail: Thumbnail.fromJson(json["thumbnail"]),
    creators: Creators.fromJson(json["creators"]),
    characters: Characters.fromJson(json["characters"]),
    stories: Stories.fromJson(json["stories"]),
    comics: Characters.fromJson(json["comics"]),
    events: Characters.fromJson(json["events"]),
    next: json["next"],
    previous: json["previous"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "resourceURI": resourceUri,
    "urls": List<dynamic>.from(urls.map((x) => x.toJson())),
    "startYear": startYear,
    "endYear": endYear,
    "rating": rating,
    "type": type,
    "modified": modified,
    "thumbnail": thumbnail.toJson(),
    "creators": creators.toJson(),
    "characters": characters.toJson(),
    "stories": stories.toJson(),
    "comics": comics.toJson(),
    "events": events.toJson(),
    "next": next,
    "previous": previous,
  };
}

class Characters {
  int available;
  String collectionUri;
  List<CharactersItem> items;
  int returned;

  Characters({
    required this.available,
    required this.collectionUri,
    required this.items,
    required this.returned,
  });

  factory Characters.fromJson(Map<String, dynamic> json) => Characters(
    available: json["available"],
    collectionUri: json["collectionURI"],
    items: List<CharactersItem>.from(json["items"].map((x) => CharactersItem.fromJson(x))),
    returned: json["returned"],
  );

  Map<String, dynamic> toJson() => {
    "available": available,
    "collectionURI": collectionUri,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "returned": returned,
  };
}

class CharactersItem {
  String resourceUri;
  String name;

  CharactersItem({
    required this.resourceUri,
    required this.name,
  });

  factory CharactersItem.fromJson(Map<String, dynamic> json) => CharactersItem(
    resourceUri: json["resourceURI"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "resourceURI": resourceUri,
    "name": name,
  };
}

class Creators {
  int available;
  String collectionUri;
  List<CreatorsItem> items;
  int returned;

  Creators({
    required this.available,
    required this.collectionUri,
    required this.items,
    required this.returned,
  });

  factory Creators.fromJson(Map<String, dynamic> json) => Creators(
    available: json["available"],
    collectionUri: json["collectionURI"],
    items: List<CreatorsItem>.from(json["items"].map((x) => CreatorsItem.fromJson(x))),
    returned: json["returned"],
  );

  Map<String, dynamic> toJson() => {
    "available": available,
    "collectionURI": collectionUri,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "returned": returned,
  };
}

class CreatorsItem {
  String resourceUri;
  String name;
  String role;

  CreatorsItem({
    required this.resourceUri,
    required this.name,
    required this.role,
  });

  factory CreatorsItem.fromJson(Map<String, dynamic> json) => CreatorsItem(
    resourceUri: json["resourceURI"],
    name: json["name"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "resourceURI": resourceUri,
    "name": name,
    "role": role,
  };
}

class Stories {
  int available;
  String collectionUri;
  List<StoriesItem> items;
  int returned;

  Stories({
    required this.available,
    required this.collectionUri,
    required this.items,
    required this.returned,
  });

  factory Stories.fromJson(Map<String, dynamic> json) => Stories(
    available: json["available"],
    collectionUri: json["collectionURI"],
    items: List<StoriesItem>.from(json["items"].map((x) => StoriesItem.fromJson(x))),
    returned: json["returned"],
  );

  Map<String, dynamic> toJson() => {
    "available": available,
    "collectionURI": collectionUri,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "returned": returned,
  };
}

class StoriesItem {
  String resourceUri;
  String name;
  String type;

  StoriesItem({
    required this.resourceUri,
    required this.name,
    required this.type,
  });

  factory StoriesItem.fromJson(Map<String, dynamic> json) => StoriesItem(
    resourceUri: json["resourceURI"],
    name: json["name"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "resourceURI": resourceUri,
    "name": name,
    "type": type,
  };
}

class Thumbnail {
  String path;
  String extension;

  Thumbnail({
    required this.path,
    required this.extension,
  });

  factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
    path: json["path"],
    extension: json["extension"],
  );

  Map<String, dynamic> toJson() => {
    "path": path,
    "extension": extension,
  };
}

class Url {
  String type;
  String url;

  Url({
    required this.type,
    required this.url,
  });

  factory Url.fromJson(Map<String, dynamic> json) => Url(
    type: json["type"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "url": url,
  };
}

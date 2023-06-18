// To parse this JSON data, do
//
//     final storiest = storiestFromJson(jsonString);

import 'dart:convert';

Storiest storiestFromJson(String str) => Storiest.fromJson(json.decode(str));

String storiestToJson(Storiest data) => json.encode(data.toJson());

class Storiest {
  int code;
  String status;
  String copyright;
  String attributionText;
  String attributionHtml;
  String etag;
  Data data;

  Storiest({
    required this.code,
    required this.status,
    required this.copyright,
    required this.attributionText,
    required this.attributionHtml,
    required this.etag,
    required this.data,
  });

  factory Storiest.fromJson(Map<String, dynamic> json) => Storiest(
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
  String description;
  String resourceUri;
  String type;
  String modified;
  dynamic thumbnail;
  Creators creators;
  Characters characters;
  Characters series;
  Characters comics;
  Characters events;
  OriginalIssue originalIssue;

  Result({
    required this.id,
    required this.title,
    required this.description,
    required this.resourceUri,
    required this.type,
    required this.modified,
    this.thumbnail,
    required this.creators,
    required this.characters,
    required this.series,
    required this.comics,
    required this.events,
    required this.originalIssue,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    resourceUri: json["resourceURI"],
    type: json["type"],
    modified: json["modified"],
    thumbnail: json["thumbnail"] != null ? json["thumbnail"] : "",
    creators: Creators.fromJson(json["creators"]),
    characters: Characters.fromJson(json["characters"]),
    series: Characters.fromJson(json["series"]),
    comics: Characters.fromJson(json["comics"]),
    events: Characters.fromJson(json["events"]),
    originalIssue: json["originalIssue"] != null ? OriginalIssue.fromJson(json["originalIssue"]) : OriginalIssue(resourceUri: '', name: ''),

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "resourceURI": resourceUri,
    "type": type,
    "modified": modified,
    "thumbnail": thumbnail,
    "creators": creators.toJson(),
    "characters": characters.toJson(),
    "series": series.toJson(),
    "comics": comics.toJson(),
    "events": events.toJson(),
    "originalIssue": originalIssue.toJson(),
  };
}

class Characters {
  int available;
  String collectionUri;
  List<OriginalIssue> items;
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
    items: List<OriginalIssue>.from(json["items"].map((x) => OriginalIssue.fromJson(x))),
    returned: json["returned"],
  );

  Map<String, dynamic> toJson() => {
    "available": available,
    "collectionURI": collectionUri,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "returned": returned,
  };
}

class OriginalIssue {
  String resourceUri;
  String name;

  OriginalIssue({
    required this.resourceUri,
    required this.name,
  });

  factory OriginalIssue.fromJson(Map<String, dynamic> json) => OriginalIssue(
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
  List<Item> items;
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
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    returned: json["returned"],
  );

  Map<String, dynamic> toJson() => {
    "available": available,
    "collectionURI": collectionUri,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "returned": returned,
  };
}

class Item {
  String resourceUri;
  String name;
  String role;

  Item({
    required this.resourceUri,
    required this.name,
    required this.role,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
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

import 'package:firebase_database/firebase_database.dart';

class Music {
  final String name;
  final String artist;
  final int year;
  final String artWork;
  final String url;
  final String fanLink;

  Music({required this.name, required this.artist, required this.year, required this.artWork,required this.url, required this.fanLink});

  factory Music.fromJson(Map<dynamic, dynamic> json) => Music(
      name: json['Name'].toString(),
      artist: json['Artist'] as String,
      year: json['Year'] as int,
      artWork: json['Artwork'] as String,
      url: json['URL'] as String,
      fanLink: json['Fanlink'] as String,
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'Name': name,
    'Artist': artist,
    'Year': year,
    'Artwork': artWork,
    'URL': url,
    'Fanlink': fanLink,
  };
}
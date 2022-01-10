part of 'models.dart';

class Destination {
  String imageUrl;
  String city;
  String country;
  String description;
  List<Activity> activities;

  Destination({
    this.imageUrl,
    this.city,
    this.country,
    this.description,
    this.activities,
  });
}

List<Activity> activities = [
  Activity(
    imageUrl: 'tanahlot.jpg',
    name: 'Kuta Tanah Lot',
    type: 'Sightseeing Tour',
    startTimes: ['9:00 am', '06:00 pm'],
    rating: 5,
    price: 25,
  ),
  Activity(
    imageUrl: 'uluwatu.jpg',
    name: 'Uluwatu Beach',
    type: 'Sightseeing Tour',
    startTimes: ['06:am', '06:00 pm'],
    rating: 4,
    price: 30,
  ),
  Activity(
    imageUrl: 'balitraditionaldance.jpg',
    name: 'Bali Traditional Dance',
    type: 'Sightseeing Tour',
    startTimes: ['05:pm', '06:00 pm'],
    rating: 4,
    price: 150,
  ),
];

List<Destination> destinations = [
  Destination(
    imageUrl: 'destinationbali.png',
    city: 'Bali',
    description: 'Visit Bali for an amazing and unforgettable adventure.',
    activities: activities,
  ),
  Destination(
    imageUrl: 'destinationyogyakarta.png',
    city: 'Yogyakarta',
    description: 'Visit Yogyakarta for an amazing and unforgettable adventure.',
    activities: activities,
  ),
  Destination(
    imageUrl: 'destinationpapua.jpg',
    city: 'Papua',
    description: 'Visit Papua for an amazing and unforgettable adventure.',
    activities: activities,
  ),
  Destination(
    imageUrl: 'destinationbandung.jpg',
    city: 'Bandung',
    description: 'Visit Bandung for an amazing and unforgettable adventure.',
    activities: activities,
  ),
];

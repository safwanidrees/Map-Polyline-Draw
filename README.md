# Map Polyline Draw

Map Polyline Draw Package show Map Polyline between Two Points in the map. It also has the feature to change the marker icon with your icon just provide the assets location. It also has feature to change polyline width and color. Map Polyine Draw using google_maps_flutter package for Google map and http package to get data from Google Map API

## Screen Shots
<img src="https://drive.google.com/uc?export=view&id=1B-crKk30r6PS7tqITBZ-oedi1irN93jt" alt="alt text" width="250">
<img src="https://drive.google.com/uc?export=view&id=1P3zK1tQWVi7jUXtC2Hb0cDq0zIaUIUW6" alt="alt text" width="250">

## Usage
* To use this, add map_polyline_draw as a dependency in your pubspec.yaml file.

## Getting Started
* First integrate google map in your Project. For this Follow steps that provided in this link https://codelabs.developers.google.com/codelabs/google-maps-in-flutter/
* Get an Google Map API key from https://cloud.google.com/maps-platform/

## Simple Code Snippet
```flutter

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          widget.title,
        ),
      ),
      body: MapPolyLineDraw(
        apiKey: "YOUR_API_KEY",
        firstPoint: MapPoint(24.8960309, 67.0792159),
        secondPoint: MapPoint(24.9425822, 67.0691675),
      ),
    );
  }
```
* apiKey: "YOUR_API_KEY"
* firstPoint: MapPoint(latitude, longitude)
* secondPoint: MapPoint(latitude, longitude)

These three are compulsory to add otherwise it will generate an error

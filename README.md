# bienenhalter.net / Bienenhalter-App

Plattformübergreifende Flutter-App zur Verwaltung von Bienenständen,
Völkern, Stockkontrollen, Aufgaben, Fotos und Honigbuch-Daten.

## Zielplattformen

- Android
- iOS
- Windows
- Web

## Aktueller Entwicklungsstand

- Dashboard mit Kennzahlen und Branding
- Bienenstände anlegen, bearbeiten und anzeigen
- Völker anlegen, bearbeiten und anzeigen
- Stockkontrollen erfassen, bearbeiten, löschen und durchsuchen
- Aufgaben anlegen, bearbeiten und erledigen
- Fotoimport für Stockkarten/Kontrollbelege
- Fotozuordnung zu Völkern und Kontrollen
- Lokale Drift/SQLite-Datenhaltung für Windows und später Mobile/Desktop
- Einfacher Web-Fallback, Web-Persistenz ggf. noch eingeschraenkt
- Honigbuch-Grundmodul mit Excel-Export

KI-/Stockkartenerkennung, QR-Code-Erkennung, Cloud-Synchronisation und Login
sind für spätere Phasen geplant und derzeit nicht umgesetzt.

## Lokal starten

```powershell
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter analyze
flutter run -d windows
```

Optional vor dem Analyze:

```powershell
dart format lib test
```

## Branding

Die Logos liegen unter:

- `assets/branding/logo3.png`
- `assets/branding/favicon.png`
- `assets/branding/full-logo-bg-white.png`

App-Icons sind per `flutter_launcher_icons` vorbereitet. Generierung lokal:

```powershell
dart run flutter_launcher_icons
```

TODO: Ein nativer Splashscreen mit Logo und Honig-/Naturfarbton kann später
vorbereitet werden. Aktuell wurde dafür bewusst kein weiteres Package
eingebaut.

## Honigbuch

Das Honigbuch erfasst Ernte- und Chargendaten und kann aktuell als Excel-Datei
exportiert werden.

Exportspalten:

- lfd. Nr.
- Schleuderdatum
- Schleuderort
- Honigsorte
- Wassergehalt in %
- Menge in kg
- abgefüllt am
- Gewährstreifen Nr. von
- Gewährstreifen Nr. bis
- Losnummer
- deklariertes Haltbarkeitsdatum
- Verarbeitung: cremig/flüssig
- Bemerkungen

Später können PDF-Export, Zeitraumfilter, Druckansicht und Vorlagenverwaltung
ergänzt werden.

## CI

Eine einfache GitHub-Actions-CI liegt unter:

- `.github/workflows/flutter-ci.yml`

Sie prueft:

- `flutter pub get`
- Drift-Codegenerierung
- Formatierung
- `flutter analyze`

`flutter test` ist vorerst als TODO auskommentiert, weil Tests lokal teilweise
haengen.

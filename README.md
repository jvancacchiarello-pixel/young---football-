# Young Football 1.1
Flutter app collegata al progetto Firebase `young-football` e package Android `com.youngfootball.app`.

## Già configurato
- Firebase Core + `android/app/google-services.json`
- Authentication Email/Password
- profilo base utente in Firestore
- struttura Team e chat Firestore
- regole Firestore consigliate in `firebase/firestore.rules`
- Android package `com.youngfootball.app`

## Avvio
1. Installa Flutter stabile e Android Studio.
2. Nella cartella del progetto: `flutter pub get`
3. Collega un telefono Android con debug USB oppure avvia un emulatore.
4. `flutter run`

## Release Play Store
Prima della pubblicazione va creata una chiave di firma release e sostituita la signingConfig debug in `android/app/build.gradle.kts`. Poi: `flutter build appbundle --release`.

## Importante
Le regole in `firebase/firestore.rules` sono più restrittive di quelle iniziali: Team e chat sono leggibili solo dai membri. Pubblicarle in Firebase prima dei test multiutente.
Cloud Storage non è richiesto in questa versione, quindi il progetto può restare sul piano Spark.

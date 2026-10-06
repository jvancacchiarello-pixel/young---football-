# Young Football - compilazione automatica Android

## APK dal telefono
1. Crea un repository GitHub privato.
2. Carica nella radice del repository tutto il contenuto di questa cartella (non la cartella esterna).
3. Apri la scheda **Actions** del repository.
4. Apri **Build Young Football Android** e premi **Run workflow**.
5. Al termine apri l'esecuzione completata e, nella sezione **Artifacts**, scarica **young-football-apk**.
6. Estrai lo ZIP dell'artifact: contiene `app-release.apk`.

## AAB e Google Play
Il workflow produce anche `young-football-aab-test`, ma la configurazione attuale firma la release con la chiave debug. Va bene per le prove, non per la pubblicazione definitiva su Google Play. Prima della pubblicazione configureremo una chiave di upload privata e la firma release senza inserirne password o file sensibili nel repository.

Package Android: `com.youngfootball.app`.

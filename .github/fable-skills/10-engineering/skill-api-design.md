# skill-api-design

**Version:** 1.0 · **Stand:** 2026-07-02 · **Gültigkeitsbereich:** Entwurf von Schnittstellen (HTTP-APIs, interne Modul-APIs, Events) · **Empfohlene Einsatzkontexte:** Neue Endpunkte, Vertragsänderungen, Versionierung

**Kurzfassung:** Ein API ist ein Versprechen an Fremde: aus Konsumentensicht entwerfen, Verträge explizit und konsistent halten, Fehler als Teil des Vertrags gestalten, abwärtskompatibel erweitern — veröffentlicht ist für immer, deshalb klein anfangen.

## Skill-Name

API-Design

## Zweck

Eine Schnittstelle ist der teuerste Code, den man schreibt: Alles dahinter kann man ändern, das Versprechen nach außen nicht — jede Korrektur braucht Migration aller Konsumenten. Dieser Skill sorgt dafür, dass Verträge bewusst entworfen werden: konsumentengerecht, konsistent, fehlerklar und evolvierbar.

## Einsatzbereich

- HTTP/REST-APIs, interne Service- und Modul-Schnittstellen, Events/Messages, CLI-Verträge
- Änderungen an bestehenden Verträgen (Kompatibilitätsfrage!)
- Review von API-Diffs (Zusatzblick zu `skill-code-review.md`)

## Denkweise

Entwirf von außen nach innen: **Erst den Aufruf schreiben, den der Konsument gerne schreiben würde — dann implementieren, was ihn möglich macht.** Wer von innen nach außen entwirft, exponiert sein Datenbankschema und nennt es API; der Konsument muss dann die Innereien des Anbieters verstehen, und jede interne Änderung wird zum Vertragsbruch.

Zweiter Grundsatz: **Publiziert ist für immer.** Jedes Feld, jeder Statuscode, jede Sortier-Eigenheit, die einmal draußen ist, wird von irgendwem benutzt (Hyrums Gesetz — auch das Undokumentierte wird zum Vertrag). Deshalb: das kleinste API veröffentlichen, das den Anwendungsfall erfüllt. Erweitern ist billig, Einschränken fast unmöglich.

## Kernregeln

**MUSS:**
1. Aus Konsumentensicht entwerfen: Anwendungsfälle der Aufrufer zuerst, Beispiel-Aufrufe vor Implementierung. Internes (DB-Spalten, interne Enums, technische IDs von Drittsystemen) nicht ungefiltert exponieren.
2. Minimal veröffentlichen: nur Felder/Endpunkte mit belegtem Bedarf. Jedes „schadet ja nicht"-Feld ist eine ewige Pflegeverpflichtung.
3. Fehler sind Teil des Vertrags: einheitliches Fehlerformat (maschinenlesbarer Code + menschenlesbare Meldung), korrekte Statuscode-Semantik (400er = Aufrufer kann was ändern, 500er = Anbieterproblem), dokumentierte Fehlerfälle pro Operation (`skill-error-handling.md`, Regel 3–4).
4. Änderungen abwärtskompatibel gestalten: Felder hinzufügen ja; Felder entfernen/umbenennen, Semantik ändern, Pflichtfelder verschärfen — nein, außer mit Versionierung + Migrationspfad + Frist. Konsumenten ihrerseits müssen unbekannte Felder tolerieren.
5. Schreiboperationen, die wiederholt ankommen können, idempotent auslegen (Idempotenz-Schlüssel bei Zahlungen/Bestellungen) — Netzwerk-Retries sind Normalbetrieb (`skill-defensive-programming.md`, Regel 4).
6. Konsistenz mit dem Bestand: gleiche Namenskonventionen, Paginierung, Fehlerformate, Datums-/Geldformate wie die übrigen APIs des Hauses. Ein inkonsistentes API zwingt Konsumenten, pro Endpunkt neu zu lernen.

**SOLL:**
7. Listen-Endpunkte von Anfang an mit Paginierung und Limit — nachrüsten ist ein Vertragsbruch, und die unbegrenzte Liste fällt genau dann um, wenn sie groß geworden ist.
8. Zeit, Geld, Mengen präzise typisieren: Zeitstempel mit Zeitzone (ISO 8601/UTC), Geld als Betrag+Währung (nie Float), Enums mit definiertem Verhalten für unbekannte Werte.
9. Verträge maschinenlesbar spezifizieren (OpenAPI/Schema) und die Spezifikation als Quelle der Wahrheit pflegen — mit echten Beispielen pro Operation.
10. Berechtigungsmodell pro Operation durchdenken (wer darf was auf welcher Ressource — `skill-security-review.md`, Regel 1) und Ratenverhalten dokumentieren.
11. Vor Veröffentlichung einen echten Konsumentenfall implementieren (und sei es ein Testclient) — nichts findet Designfehler schneller als der erste ehrliche Aufrufer.

**KANN:**
12. Feld-Deprecation mit Ankündigung, Metrik (wer nutzt es noch?) und Frist managen.
13. Für interne Modul-APIs dieselben Regeln light anwenden: kleine Oberfläche, ehrliche Verträge — die Kosten sind dieselben, nur der Konsumentenkreis kleiner (`skill-module-design.md`).

## Arbeitsablauf

1. **Konsumentenfälle sammeln:** Wer ruft warum auf? Beispiel-Aufrufe skizzieren (Request/Response konkret).
2. **Ressourcen/Operationen schneiden:** Fachbegriffe statt Innereien; Benennung und Muster am Bestand ausrichten.
3. **Verträge ausformulieren:** Felder, Typen (Zeit/Geld!), Pflicht/Optional, Fehlerfälle, Paginierung, Idempotenz, Berechtigungen.
4. **Kompatibilität prüfen (bei Änderungen):** Bricht es existierende Aufrufer? Wenn ja: Versionierung/Migrationspfad statt stiller Änderung.
5. **Mit echtem Konsumenten validieren:** Testclient/Erstintegration vor Fixierung.
6. **Spezifikation + Beispiele veröffentlichen**, Änderungen dokumentieren (`skill-change-documentation.md`).

## Checkliste

- [ ] Ist das Design aus Konsumentenfällen abgeleitet (nicht aus dem Schema)?
- [ ] Ist die Oberfläche minimal (jedes Feld mit belegtem Bedarf)?
- [ ] Sind Fehlerformat und Statuscodes einheitlich und dokumentiert?
- [ ] Ist die Änderung abwärtskompatibel (oder versioniert mit Migrationspfad)?
- [ ] Sind kritische Schreiboperationen idempotent?
- [ ] Paginierung auf Listen, präzise Typen für Zeit/Geld?
- [ ] Konsistent mit den übrigen APIs des Hauses?
- [ ] Hat ein echter Aufrufer das Design vor Fixierung benutzt?

## Typische Fehler

- **Schema-Durchreiche:** DB-Tabelle als JSON exponieren. Jede interne Migration wird zum Konsumenten-Breaking-Change.
- **Stille Semantikänderung:** Feld `status` bedeutet ab Version X etwas anderes — kompiliert überall, bricht überall.
- **200 mit Fehler im Body:** `{"success": false}` bei Status 200 — Monitoring, Caches und Clients werden systematisch belogen.
- **Die unbegrenzte Liste:** `GET /orders` ohne Limit. Funktioniert zwei Jahre, dann OOM beim größten Kunden.
- **Float für Geld:** 0.1 + 0.2. Genug gesagt.
- **Chatty API:** Konsument braucht 15 Aufrufe für einen Screen, weil das API interne Normalisierung spiegelt statt Anwendungsfälle zu bedienen.
- **Versionierung als Ausrede:** Bei jedem Fehler v2, v3, v4 — Konsumenten migrieren nicht, der Anbieter pflegt vier Verträge. Kompatible Evolution schlägt Versions-Inflation.

## Beispiele

**Gut (Fehler als Vertrag):**
```json
HTTP 422
{ "error": "coupon_expired",
  "message": "Gutschein am 30.06.2026 abgelaufen.",
  "requestId": "r-8f3a" }
```
Maschinenlesbar (Client kann gezielt reagieren), menschenlesbar, korrelierbar — und derselbe Aufbau bei jedem Endpunkt des Hauses.

**Gut (kompatible Evolution):** Bedarf: Lieferstatus feiner unterteilen. Statt `status`-Werte umzudeuten (Breaking): neues Feld `deliveryPhase` ergänzen, `status` unverändert weiter bedienen, Deprecation mit Nutzungsmetrik und Frist ankündigen.

**Schlecht:** `GET /api/getKundenDatenNeu2?welche=alle` — Verb im Pfad, Denglisch, „Neu2" als Versionierung, unbegrenzte Rückgabe. Jede Regel dieses Skills verletzt in einer Zeile.

## Eskalation

- Breaking Change unvermeidbar → nie still: Konsumenten identifizieren, Migrationspfad + Frist vorschlagen, Entscheidung an Verantwortliche (`skill-decision-records.md`).
- Konsumentenbedarf unklar oder widersprüchlich (zwei Aufrufer wollen Unvereinbares) → Rückfrage mit Optionen; ein API, das beiden halb dient, dient keinem.
- Externe Partner betroffen (Verträge, SLAs) → Kommunikation über die dafür Verantwortlichen, nicht per stillem Deployment.
- Nutzung eines vermeintlich toten Felds/Endpunkts unbekannt → erst messen (Logs/Metriken), dann deprecaten — nie nach Gefühl abschalten.

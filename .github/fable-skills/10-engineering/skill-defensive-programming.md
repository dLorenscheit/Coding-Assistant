# skill-defensive-programming

**Version:** 1.0 · **Stand:** 2026-07-02 · **Gültigkeitsbereich:** Absicherung von Code gegen ungültige Zustände und Eingaben · **Empfohlene Einsatzkontexte:** Systemgrenzen, kritische Abläufe, Datenverarbeitung

**Kurzfassung:** An Systemgrenzen alles validieren, im Inneren auf geprüfte Invarianten vertrauen und bei Verletzung schnell und laut scheitern — Verteidigung gezielt an Grenzen und kritischen Stellen, nicht als Null-Check-Teppich überall.

## Skill-Name

Defensive Programmierung

## Zweck

Defensiv programmieren heißt nicht, überall Checks zu streuen — das erzeugt Rauschen und versteckt echte Fehler. Es heißt: klare Vertrauensgrenzen ziehen. Außerhalb der Grenze ist alles verdächtig (Nutzereingaben, API-Antworten, Dateien, Config); innerhalb gelten geprüfte Invarianten, und ihre Verletzung ist ein Bug, der sofort und laut auffallen soll — nicht ein Zustand, den man weich abfängt und weiterschleppt.

## Einsatzbereich

- Systemgrenzen: HTTP-Endpunkte, Message-Handler, Datei-/Import-Verarbeitung, Fremd-API-Antworten, Konfiguration
- Kritische Abläufe: Zahlungen, Buchungen, Löschungen, Migrationen (Idempotenz!)
- Konstruktoren/Fabriken von Domänenobjekten (Invarianten erzwingen)
- Abgrenzung: Reaktion auf erwartbare Fehler → `skill-error-handling.md`

## Denkweise

Denke wie eine Grenzkontrolle, nicht wie ein Misstrauensstaat: **Am Flughafen wird jeder kontrolliert; im Land drinnen muss nicht jeder Bäcker nochmal den Pass prüfen.** Wer innen überall prüft, hat in Wahrheit keine Grenze — und niemand weiß mehr, welchen Daten man trauen darf.

Zweiter Grundsatz: **Fail fast, fail loud.** Ein früher Absturz mit klarer Meldung ist ein Geschenk: Der Fehler zeigt auf seine Ursache. Ein weich abgefangener ungültiger Zustand wandert stumm weiter und explodiert drei Systeme später — dort, wo ihn niemand mehr zuordnen kann. Der scheinbar „robuste" Code (`if null then return`) ist oft der, der Datenfehler verschleppt.

## Kernregeln

**MUSS:**
1. An jeder Systemgrenze eingehende Daten vollständig validieren (Typ, Pflichtfelder, Wertebereiche, Fachregeln) — **bevor** sie ins Innere gelangen. Nach der Validierung tragen sie idealerweise einen Typ, der die Gültigkeit ausdrückt (parse, don't validate).
2. Fremd-API-Antworten, Dateien und Konfiguration wie Nutzereingaben behandeln: nie „das liefert immer …" — Verträge Dritter brechen ohne Ankündigung.
3. Invariantenverletzungen im Inneren sind Bugs: schnell scheitern mit aussagekräftiger Meldung (welche Erwartung, welcher Ist-Wert) — nicht still korrigieren, nicht stumm returnen.
4. Operationen mit Außenwirkung, die wiederholt werden können (Retry, Doppelklick, Message-Redelivery), müssen idempotent sein oder Duplikate erkennen — Standardfall, kein Sonderfall.
5. Pflicht-Konfiguration beim Start prüfen (fehlt ein Secret/Endpoint → Start verweigern), nicht erst beim ersten Zugriff um 3 Uhr nachts.

**SOLL:**
6. Ungültige Zustände unrepräsentierbar machen, wo die Sprache es hergibt: Enums statt magic strings, Nicht-Null-Typen, Konstruktoren die Invarianten erzwingen — jeder Check, den der Compiler übernimmt, kann nie vergessen werden.
7. Grenz-Checks zentralisieren (Validierungsschicht, Objekterzeugung) statt dieselbe Prüfung über 15 Methoden zu verstreuen.
8. Timeouts für jeden externen Aufruf setzen — kein Timeout ist die Entscheidung, notfalls ewig zu hängen.
9. Bei Sammelverarbeitung (Import, Batch) entscheiden und dokumentieren: bricht ein fehlerhafter Datensatz alles ab oder wird er gesammelt gemeldet? Beides ist vertretbar — undokumentiertes Mischverhalten nicht.

**KANN:**
10. Assertions/Debug-Checks für „kann nie passieren"-Annahmen im Inneren — sie dokumentieren die Invariante und schlagen in Tests an.
11. Bei besonders kritischen Berechnungen (Geld) Plausibilitätsschranken einziehen („Rabatt > Warenwert → ablehnen und alarmieren").

## Arbeitsablauf

1. **Grenzen identifizieren:** Wo betreten Daten das System? (Endpunkte, Handler, Dateien, Config, Fremd-APIs.)
2. **Verträge definieren:** Was ist an jeder Grenze gültig? Prüfbare Regeln, nicht Gefühl.
3. **Validierung an die Grenze bauen:** vollständig, zentral, mit klaren Fehlermeldungen nach außen (`skill-error-handling.md`).
4. **Innere Invarianten benennen und erzwingen:** per Typsystem wo möglich, per Fail-fast-Check wo nötig.
5. **Wiederholbarkeit prüfen:** Für jede Außenwirkung: Was passiert bei doppelter Ausführung? Idempotenz oder Duplikaterkennung einbauen.
6. **Grenzfälle testen:** Ungültiges, Fehlendes, Doppeltes, Zu-Großes an jeder Grenze (`skill-testing-strategy.md`, Regel 4).

## Checkliste

- [ ] Ist jede Systemgrenze identifiziert und dort vollständig validiert?
- [ ] Behandle ich Fremd-APIs/Dateien/Config als nicht vertrauenswürdig?
- [ ] Scheitern Invariantenverletzungen innen schnell und laut (statt still weich)?
- [ ] Sind wiederholbare Außenwirkungen idempotent?
- [ ] Wird Pflicht-Config beim Start geprüft?
- [ ] Hat jeder externe Aufruf ein Timeout?
- [ ] Habe ich keine flächendeckenden Null-Checks als Ersatz für eine klare Grenze?

## Typische Fehler

- **Null-Check-Teppich:** `if (x == null) return;` in jeder zweiten Methode. Versteckt Bugs, statt sie zu melden — der Datenfehler reist stumm weiter.
- **Grenzenlose Innenverteidigung:** Jede private Methode validiert alles erneut. Niemand weiß, wo die echte Grenze ist; Änderungen müssen 15 Checks pflegen.
- **Vertrauen in Verträge Dritter:** „Die API liefert immer ein Datum." Bis zum Update des Anbieters.
- **Weiche Selbstheilung:** Ungültigen Wert still durch Default ersetzen (`amount ?? 0`). Aus einem sichtbaren Fehler wird eine falsche Buchung.
- **Retry ohne Idempotenz:** Netzwerk-Timeout, Retry, doppelte Abbuchung. Der Klassiker unter den teuren Fehlern.
- **Lazy-Config-Crash:** Fehlende Konfiguration fällt erst beim ersten Nutzer auf statt beim Deploy.

## Beispiele

**Gut (Grenze + Vertrauen innen):**
```csharp
// Grenze: Endpunkt validiert vollständig und erzeugt ein gültiges Objekt
var order = OrderRequest.Parse(dto); // wirft mit Feldliste bei ungültig

// Innen: keine Re-Validierung, aber Invariante laut prüfen
void Book(Order order) {
    if (order.Total < 0) // "kann nie passieren" → wenn doch: Bug, laut!
        throw new InvalidOperationException($"Invariante verletzt: Total={order.Total}, OrderId={order.Id}");
    ...
}
```

**Schlecht:** `Book` prüft defensiv `order != null`, `order.Items != null`, ersetzt negatives Total durch 0 und loggt ein Warning, das niemand liest. Die falsche Rechnung geht raus.

## Eskalation

- Unklar, was an einer Grenze gültig ist (Fachregel unbekannt) → klären lassen (`skill-requirements-analysis.md`), nicht raten und weich abfangen.
- Idempotenz nachrüsten würde Schema-/Vertragsänderung erfordern → als eigenes Arbeitspaket vorlegen; bis dahin Risiko dokumentieren.
- Fremdsystem liefert nachweislich vertragswidrige Daten → an Verantwortliche melden mit Beleg; Workaround nur dokumentiert und befristet.
- Bestandscode hat keine erkennbaren Grenzen (Validierung überall und nirgends) → nicht im Vorbeigehen umbauen; als strukturellen Befund melden (`skill-clean-code-analysis.md`).

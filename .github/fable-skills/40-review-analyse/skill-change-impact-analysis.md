# skill-change-impact-analysis

**Version:** 1.0 · **Stand:** 2026-07-02 · **Gültigkeitsbereich:** Ermittlung des Wirkradius einer geplanten oder erfolgten Änderung · **Empfohlene Einsatzkontexte:** Vor riskanten Änderungen, in Reviews, bei Vertrags-/Schema-Änderungen, nach Vorfällen

**Kurzfassung:** Der Wirkradius einer Änderung ist größer als der Diff: direkte Aufrufer, Verhaltens-Konsumenten, Daten, Verträge, Konfiguration, Jobs — und die unsichtbaren Kopplungen (Reflection, Serialisierung, SQL/Trigger, Konventions-Strings), die ohne Compilerfehler brechen. Suchen, belegen, absichern.

## Skill-Name

Änderungs-Impact-Analyse

## Zweck

Die meisten Regressionen entstehen nicht in der geänderten Zeile, sondern in einem Konsumenten, an den niemand gedacht hat. Dieser Skill systematisiert die Frage „wen trifft diese Änderung noch?" — bevor sie ausgerollt wird. Er ist das Werkzeug hinter `skill-code-review.md` Regel 2 („über den Diff hinaus lesen") und Pflichtprogramm bei Vertrags-, Schema- und Legacy-Änderungen.

## Einsatzbereich

- Vor Änderungen an viel genutzten Funktionen, Schnittstellen, Schemata, Konfiguration
- Als Review-Baustein (stimmt die Impact-Einschätzung des Autors?)
- In Legacy-Systemen grundsätzlich (`skill-legacy-code-handling.md`, Regel 2)
- Rückwärts nach Vorfällen: „Welche Änderung hat das ausgelöst?"

## Denkweise

Denke in konzentrischen Kreisen um die Änderung — und traue dem Compiler nur für den innersten: **Kreis 1:** direkte Aufrufer (findet der Compiler/die Referenzsuche). **Kreis 2:** Verhaltens-Konsumenten — alles, was sich auf das bisherige *Verhalten* verlässt, nicht auf die Signatur: Reihenfolgen, Formate, Zeitverhalten, Fehlerarten, „undokumentierte" Eigenschaften (Hyrums Gesetz: alles Beobachtbare wird irgendwo benutzt). **Kreis 3:** unsichtbare Kopplungen — Verbindungen, die kein Werkzeug anzeigt: Reflection, Serialisierung/Persistenz, SQL/Views/Trigger, Message-Konsumenten, Config-Strings, Excel-Makros im Fachbereich, Cron-Jobs, Systeme anderer Teams.

Merksatz: **„Kompiliert und Tests grün" beweist nur Kreis 1** — und auch den nur, soweit Tests existieren. Die teuren Überraschungen wohnen in Kreis 2 und 3.

## Kernregeln

**MUSS:**
1. Vor der Änderung die Art des geänderten Vertrags bestimmen: Signatur? Verhalten? Datenformat? Zeitverhalten? Fehlerverhalten? — Jede Art hat andere Konsumenten und andere Suchwege.
2. Kreis 1 vollständig abklappern: Referenzsuche auf alles Geänderte (Funktionen, Felder, Endpunkte, Tabellen, Events) — inkl. Tests, Skripte, anderer Repos, wenn geteilt.
3. Kreis 3 aktiv absuchen, mit Textsuche statt Symbolsuche: Namen als String (Reflection, Config, SQL, Templates, Logauswertungen), Tabellen-/Spaltennamen in Views/Prozeduren/Reports, Event-/Queue-Namen bei allen Konsumenten. Umbenennungen und Format-Änderungen sind hier die Hauptrisiken.
4. Bei Verhaltensänderungen die Verhaltens-Konsumenten (Kreis 2) explizit durchdenken: Wer könnte sich auf das alte Verhalten verlassen (Sortierung, Rundung, null-vs-leer, Timing)? In Legacy gilt: beobachtetes Verhalten = Vertrag.
5. Das Ergebnis als belegte Liste festhalten: betroffene Stellen mit Fundort, je Stelle „angepasst / geprüft-unbetroffen / offen". Offene Punkte sind Risiko und werden benannt, nicht verschwiegen.
6. Für den verbleibenden Restradius eine Absicherung wählen: Tests der Konsumenten, Feature-Flag, gestufter Rollout, Monitoring auf die betroffene Größe — proportional zum Risiko.

**SOLL:**
7. Datenfluss zusätzlich zur Aufrufkette verfolgen: Wer liest die Daten, die diese Änderung anders schreibt — auch zeitversetzt (Nachtjob, Export, Data Warehouse)?
8. Konfigurations- und Umgebungsabhängigkeiten prüfen: Gilt die Änderung in allen Umgebungen/Mandanten/Feature-Flag-Kombinationen gleich?
9. Bei geteilten Artefakten (Bibliothek, API, Schema) die Konsumenten-Teams als Teil des Radius behandeln: informieren gehört zur Änderung (`skill-change-documentation.md`).
10. Die Analyse-Tiefe dem Risiko anpassen: Für eine private Hilfsfunktion reicht Kreis 1; für Schema/API/Kernverhalten sind alle drei Kreise Pflicht.

**KANN:**
11. Rückwärts-Impact bei Vorfällen: vom Symptom zur Menge der kürzlich geänderten Verträge, die es erklären könnten (`skill-debugging.md`, Regel 8).
12. Wiederkehrende unsichtbare Kopplungen des Hauses dokumentieren („bei uns lesen Reports direkt aus Tabelle X") — eine Landkarte der Minenfelder.

## Arbeitsablauf

1. **Vertragstyp bestimmen:** Was genau ändert sich beobachtbar?
2. **Kreis 1:** Referenzsuche, Aufruferliste, Tests.
3. **Kreis 2:** Verhaltens-Konsumenten durchdenken; bei Unsicherheit Konsumenten-Code lesen statt hoffen.
4. **Kreis 3:** Textsuche nach Namen/Strings; DB-Objekte, Jobs, Events, fremde Repos, Fachbereichs-Artefakte.
5. **Liste konsolidieren:** jede Stelle mit Status (angepasst/geprüft/offen), Fundorte notieren.
6. **Absichern:** Maßnahme pro offenem Risiko; Rollout-Strategie festlegen.
7. **Kommunizieren:** Betroffene informieren; Liste in PR/Ticket sichtbar machen.

## Checkliste

- [ ] Ist klar, welche Vertragsart sich ändert (Signatur/Verhalten/Daten/Zeit/Fehler)?
- [ ] Kreis 1 vollständig (Referenzsuche, auch Tests/Skripte/andere Repos)?
- [ ] Kreis 3 per Textsuche geprüft (Strings, SQL, Config, Events, Reflection)?
- [ ] Verhaltens-Konsumenten durchdacht (Sortierung, Formate, Timing, Fehler)?
- [ ] Belegte Betroffenen-Liste mit Status vorhanden — offene Punkte benannt?
- [ ] Absicherung proportional zum Restrisiko (Tests/Flag/Rollout/Monitoring)?
- [ ] Betroffene Teams informiert?

## Typische Fehler

- **Compiler-Vertrauen:** „Baut überall" — die Reflection-Zugriffe, SQL-Views und der Export-Job kompilieren nicht mit.
- **Symbolsuche statt Textsuche:** Die Referenzsuche findet `CustomerName` als Symbol — nicht den String `"CustomerName"` im Report-Template und im Config-Mapping.
- **Zeitversetzte Konsumenten vergessen:** Der Nachtjob, der Monatsexport, das Data Warehouse — der Bruch fällt Tage später auf, weit weg vom Diff.
- **Verhalten für frei verfügbar halten:** Sortierung „nur intern" geändert — drei Konsumenten hatten sich auf die Reihenfolge verlassen (Hyrum).
- **Analyse ohne Statusliste:** „Habe ich mir angeschaut" — was genau, mit welchem Ergebnis? Nicht nachvollziehbar, nicht reviewbar.
- **Radius erkannt, Risiko verschwiegen:** Drei offene Unklarheiten, aber der PR sagt „sollte nichts brechen". Offenes benennen ist der halbe Wert der Analyse.

## Beispiele

**Gut:** Änderung: Spalte `status` in `orders` bekommt neuen Wert `partially_shipped`. Vertragstyp: Datenformat/Wertebereich. Kreis 1: 14 Code-Referenzen (Referenzsuche), 3 mit `switch` ohne Default-Behandlung → angepasst. Kreis 3 (Textsuche „status"): 2 SQL-Views (eine filtert `IN ('open','shipped')` → würde neue Bestellungen unsichtbar machen — angepasst), 1 Power-BI-Report des Controllings (Team informiert), Export-Job mapped Werte hart (angepasst + Test). Kreis 2: Monitoring zählt „shipped/Tag" — Kennzahl sinkt scheinbar → Betrieb vorab informiert. Rollout hinter Flag, Monitoring auf unbekannte Statuswerte. Statusliste im Ticket.

**Schlecht:** Neuer Enum-Wert eingeführt, „Compiler hat alle switches gefunden" — die SQL-View nicht. Zwei Wochen später „verschwinden" Bestellungen aus dem Kundenportal.

## Eskalation

- Radius erreicht fremde Teams/Systeme → Änderung nicht allein ausrollen: Betroffene einbeziehen, ggf. Frist/Migrationsfenster (`skill-api-design.md`, Eskalation).
- Kreis 3 nicht überschaubar (unbekannte Konsumenten, kein Zugriff auf fremde Repos/Reports) → Restrisiko explizit an den Entscheider; ggf. Beobachtungsphase (Logging, wer greift zu?) vor der Änderung.
- Analyse zeigt: sichere Änderung erfordert erst Entkopplung (zu viele unkontrollierbare Konsumenten) → Vorab-Arbeitspaket vorschlagen statt Risiko-Rollout.
- Zeitdruck verlangt Rollout trotz offener Punkte → Risiken schriftlich, Entscheidung beim Verantwortlichen — nie still (`skill-code-review.md`, Eskalation).

# skill-rpg-syntax-fixed-format

**Version:** 1.0 · **Stand:** 2026-07-08 · **Gültigkeitsbereich:** Syntax-Referenz für spaltengebundenes RPG III/RPG400 und klassisches ILE-RPG-IV-Fixed-Format · **Empfohlene Einsatzkontexte:** Änderungen an Alt-Code in Spaltenform, insbesondere bei Unsicherheit über Spaltenpositionen und Opcodes

**Kurzfassung:** Spaltenpositionen sind Gesetz, nicht Empfehlung — ein Zeichen daneben ist ein anderes Feld oder ein Syntaxfehler; bei Unsicherheit hier nachschlagen statt Free-Format-Gewohnheiten auf Spaltencode zu übertragen.

## Skill-Name

RPG-Syntax-Referenz (Fixed-Format)

## Zweck

Hält die Spaltenregeln und Opcode-Grundlagen von RPG III/RPG400 und klassischem RPG-IV-Fixed-Format fest, die Modelle wegen dünner/veralteter Trainingsdaten oder Vermischung mit **FREE häufig falsch wiedergeben. Reine Syntax-Referenz — Stilfragen (Bestandsstil respektieren, keine Konvertierung nebenbei) regelt `skill-agent-rpg-coder.md`.

## Einsatzbereich

- Änderung/Ergänzung in spaltengebundenem RPG III, RPG/400, klassischem RPG-IV-Fixed-Format (H-/F-/D-/C-/I-/O-Specs)
- Vor allem bei Unsicherheit über exakte Spaltenpositionen, Opcodes, Indikatorlogik
- Nicht für **FREE/SQLRPGLE → `skill-rpg-syntax-free-format.md`
- Nicht für die Entscheidung, ob konvertiert werden soll (das ist Max' Auftrag, nicht Syntaxfrage)

## Denkweise

Fixed-Format-RPG ist **positionsbasiert**: Ein Zeichen Verschiebung ändert die Bedeutung komplett (aus Faktor 1 wird Opcode, aus Feldname ein Kommentar). Ein Modell, das die Spaltenpositionen nur ungefähr erinnert, produziert Code, der wie RPG aussieht, aber falsch compiliert oder — schlimmer — falsch, aber compilierbar ist. Deshalb: **Position vor Aussehen.** Immer an tatsächlichen Spaltenpositionen der Quelle orientieren, nicht am optischen Eindruck.

## Kernregeln

**MUSS:**
1. Kommentarzeile: Spalte 7 = `*` — alles rechts davon ist Kommentar, unabhängig vom Inhalt.
2. C-Spec-Spalten (RPG III/400 Klassik): Form-Typ Spalte 6 (`C`), Indikatoren Spalte 9–11, Faktor 1 Spalte 12–25, Opcode Spalte 26–35, Faktor 2 Spalte 36–49, Resultatfeld Spalte 50–63, Länge Spalte 64–68, Dezimalstellen Spalte 69–70, Anzeige-Indikatoren (Hi/Lo/Eq) Spalte 71–76.
3. F-Spec-Spalten: Dateiname Spalte 7–16, Dateityp (`I`/`O`/`U`/`C`) Spalte 17, Bezeichnung Spalte 18, Zusatz (`A`dd/`F`ull-procedural) Spalte 19, Satzadresstyp Spalte 22, Gerät Spalte 36–42, Schlüssellänge Spalte 44–51.
4. D-Spec-Spalten (RPG-IV-Fixed, Definitionen): Name Spalte 7–21, Art (Spalte 24: leer/`C`/`DS`/`S`/`PR`/`PI`), `From`/`To`-Position Spalte 25–33/34–42 bei DS-Unterfeldern, Datentyp Spalte 40, Länge/Dezimal Spalte 33–39/41–42.
5. Indikatoren: `*IN01`–`*IN99` bzw. `01`–`99` in Faktor-1/Anzeige-Spalten; Stufenwechsel `L1`–`L9`, Match-Felder `MR`, erste Seite `1P` — nur bestehende Indikatoren wiederverwenden, niemals neue ohne vollständige Prüfung aller Verwendungen (auch DSPF/O-Specs) einführen.
6. Level-Break-Logik `IFxx`/`ANDxx`/`ORxx` (`xx` = Indikator) folgt fester Auswertereihenfolge: `AND`/`OR`-Zeilen gehören zur vorherigen Bedingungszeile — Einrückung ändert daran nichts.
7. O-Spec (Output): Feldname Spalte 30–39, Editierung/Konstante Spalte 45+, Zeilen-/Space-Before/After in eigenen Spalten — Position bestimmt das gedruckte/angezeigte Ergebnis, nicht die Reihenfolge im Quelltext.

**SOLL:**
8. Häufige Opcodes korrekt einsetzen: `MOVE`/`MOVEL` (rechts-/linksbündig), `Z-ADD`/`Z-SUB` (Ergebnis überschreiben), `ADD`/`SUB`/`MULT`/`DIV`, `COMP` (setzt Hi/Lo/Eq-Indikatoren), `CHAIN`/`READ`/`READE`/`SETLL` mit `%FOUND`/`%EOF` in RPG-IV bzw. Indikatoren in RPG III, `WRITE`/`UPDAT`/`EXCEPT`, `CALL`/`PARM`, `CASxx` für Verzweigung.
9. Fortsetzungszeilen: Faktor-2/Resultat-Überlauf nur mit korrektem Blank-Faktor-1 und `-`/`+`-Fortsetzungszeichen an vorgesehener Spaltenposition, nicht frei improvisiert.
10. Keine Free-Format-Konstrukte (`if`/`dow` in Kleinbuchstaben ohne Spaltenbindung, `;`) in Fixed-Format-Membern einstreuen.

**KANN:**
11. In RPG-IV-Fixed (nicht RPG III) `%FOUND`/`%EOF`/`%ERROR` statt reiner Indikatoren nutzen, wenn der Bestand das bereits so hält.

## Arbeitsablauf

1. Vor der Änderung: Spaltenpositionen der **umgebenden, tatsächlichen Zeilen** der Datei ablesen — nicht aus der Erinnerung annehmen.
2. Spec-Typ bestimmen (H/F/D/I/C/O) und die zugehörigen Spaltenregeln (Kernregeln 2–4, 7) anwenden.
3. Bei Indikatoränderung: alle Verwendungen (auch DSPF, O-Specs) suchen, bevor ein Indikator umgenutzt wird (Regel 5).
4. Opcode und Operanden gegen Regel 8 prüfen; Fortsetzungszeilen gegen Regel 9.
5. Nach dem Schreiben: Spalten der neuen/geänderten Zeile gegen eine unveränderte Nachbarzeile gleichen Spec-Typs abgleichen.

## Checkliste

- [ ] Stimmen Spaltenpositionen mit einer echten Nachbarzeile gleichen Spec-Typs überein?
- [ ] Kommentar wirklich in Spalte 7 mit `*`?
- [ ] Keine neuen Indikatoren ohne vollständige Verwendungsprüfung?
- [ ] Opcode und Faktor-1/2/Resultat-Spalten korrekt zugeordnet (nicht verrutscht)?
- [ ] Keine Free-Format-Syntax im Fixed-Format-Member?
- [ ] Fortsetzungszeilen korrekt markiert?

## Typische Fehler

- **Spaltenverrutscher:** Ein Leerzeichen zu viel/wenig verschiebt Faktor 2 in die Resultatfeld-Spalte — compiliert oft trotzdem, tut aber etwas anderes.
- **Neuer Indikator ohne Prüfung:** `*IN50` wird für einen neuen Zweck genutzt, hängt aber noch in der DSPF — Anzeige verhält sich unerklärlich.
- **Free-Format-Idiome in Spaltencode:** `if x = y` klein geschrieben ohne Spaltenbindung, Semikolon am Zeilenende — Compiler meldet Syntaxfehler oder interpretiert Spalten falsch.
- **`COMP` ohne Indikator-Auswertung:** Ergebnis-Indikatoren (Hi/Lo/Eq) gesetzt, aber nie abgefragt — der Vergleich hat keine Wirkung.
- **Level-Break-Verkettung missachtet:** `ANDxx`-Zeile als eigenständige Bedingung missverstanden, obwohl sie zur vorherigen `IFxx`-Zeile gehört.

## Beispiele

**Gut (Auszug, Spaltenangaben in Kommentar):**
```
*.......1.......2.......3.......4.......5.......6.......7.......8
C     KUNDNR        CHAIN     KUNDP                           50
C  50                MOVE      *ON           FEHLER
```
Indikator 50 wird gesetzt, wenn `CHAIN` keinen Satz findet — Faktor-1/Opcode/Faktor-2 exakt in ihren Spaltenbereichen.

**Schlecht:** Gleiche Logik, aber `CHAIN` und `KUNDP` um zwei Zeichen nach rechts verschoben, weil das Modell die Spaltenbreite falsch erinnert hat — Resultatfeld landet in der Längen-Spalte, Compile-Fehler oder stille Fehlinterpretation.

## Eskalation

- Seltener Opcode oder Spec-Variante (z. B. alte S/38-spezifische Opcodes) hier nicht abgedeckt → gegen Compile-Listing oder IBM-Doku verifizieren.
- Spaltenpositionen der konkreten Quelle weichen von dieser Referenz ab (z. B. wegen Editor-Tab-Einstellungen) → tatsächliche Datei als Quelle der Wahrheit nehmen, nicht diese Tabelle.

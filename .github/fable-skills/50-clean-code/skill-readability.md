# skill-readability

**Version:** 1.0 · **Stand:** 2026-07-02 · **Gültigkeitsbereich:** Lesbarkeit von Code als Optimierungsziel · **Empfohlene Einsatzkontexte:** Implementierung, Reviews, Vereinfachungs-Refactorings

**Kurzfassung:** Code wird für den Leser geschrieben: oben nach unten erzählen, Überraschungen eliminieren (Name hält, was er verspricht; nichts passiert nebenbei), Denk-Distanzen kurz halten (Definition nah an Nutzung), Absicht vor Mechanik — Lesbarkeit ist messbar am Stocken des Lesers, nicht am Geschmack des Autors.

## Skill-Name

Lesbarkeit

## Zweck

Code wird ein Mal geschrieben und über Jahre dutzendfach gelesen — von Fremden, unter Zeitdruck, auf Fehlersuche. Jede Sekunde Stocken multipliziert sich. Dieser Skill macht Lesbarkeit prüfbar: nicht „gefällt mir", sondern konkrete Eigenschaften, die Lesefluss erzeugen — und ein Test, der Streit um Geschmack von echten Befunden trennt.

## Einsatzbereich

- Beim Schreiben und im Selbst-Review (`skill-code-implementation.md`, Regel 9)
- Im Review: Lesbarkeits-Anmerkungen sauber einstufen (echtes Hindernis vs. Geschmack)
- Zusammenspiel: Namen (`skill-naming.md`), Funktionsschnitt (`skill-function-design.md`), Komplexität (`skill-complexity-control.md`) — dieser Skill behandelt den Lesefluss selbst

## Denkweise

Schreibe für den **Leser mit einer Frage**: Er liest nicht zum Vergnügen, sondern weil er etwas sucht („wo wird der Rabatt gedeckelt?", „warum ist das Feld leer?"). Guter Code beantwortet seine Frage auf dem kürzesten Weg: Er kann grob überfliegen, findet die relevante Stelle am erwartbaren Ort, und was er dort liest, stimmt mit dem überein, was Namen und Struktur versprochen haben.

Das Qualitätsmaß ist das **Prinzip der geringsten Überraschung**: Jedes Stocken des Lesers („Moment — was?") ist ein Befund. Überraschungen entstehen durch lügende Namen, Nebenwirkungen an unerwarteter Stelle, Formatierungs-Wechsel, umgekehrte Bedingungen, weit entfernte Definitionen. Lesbarkeit heißt: Erwartungen aufbauen und sie dann erfüllen.

## Kernregeln

**MUSS:**
1. Erzählreihenfolge: Innerhalb einer Einheit von oben nach unten lesbar — erst das Was (öffentlicher Ablauf), dann das Wie (Details). Der Leser soll nie rückwärts springen müssen, um Vorwärtsgelesenes zu verstehen.
2. Absicht sichtbar machen, Mechanik unterordnen: Der Code sagt zuerst *was fachlich passiert* (benannte Schritte, benannte Bedingungen), die technische Mechanik ist Innenleben. `if (IsEligibleForExpressShipping(order))` statt fünf gestapelter Vergleiche im if.
3. Denk-Distanz kurz halten: Deklaration nahe der ersten Nutzung; zusammengehörige Zeilen als Block; Variablen-Lebenszeit kurz (`skill-complexity-control.md`, Regel 2). Der Leser hat ~4 Dinge im Kopfspeicher — Code, der mehr verlangt, verliert ihn.
4. Bedingungen positiv und direkt formulieren: keine doppelten Verneinungen (`if (!isNotReady)`), keine invertierte Logik mit spätem `else`, der eigentliche Fall zuerst. Komplexe Bedingungen in benannte Booleans oder Funktionen heben.
5. Kommentare erklären Warum, nie Was (`skill-documentation-writing.md`, Regel 6) — und Lesbarkeits-Probleme werden im Code gelöst, nicht wegkommentiert: Ein Kommentar, der verworrenen Code erklärt, ist das Eingeständnis, ihn nicht aufgeräumt zu haben.

**SOLL:**
6. Symmetrie nutzen: Gleiches gleich behandeln — parallele Fälle in paralleler Form (gleiche Struktur, gleiche Reihenfolge, gleiche Benennung). Asymmetrie signalisiert dem Leser einen Unterschied; gibt es keinen, ist sie eine falsche Fährte.
7. Vertikale Dichte dosieren: Leerzeilen als Absatzgrenzen (ein Gedanke, ein Block), nicht zufällig. Ein Screen sollte eine abgeschlossene Denkeinheit fassen können.
8. Magische Werte benennen: Literale mit Fachbedeutung (`0.19`, `86400`, `"A7"`) als benannte Konstanten — der Name transportiert die Bedeutung, die Zahl nicht.
9. Formatierung dem Formatter überlassen und der Repo-Konvention folgen — Formatierungs-Individualismus erzeugt Rauschen in Diffs und Reviews (`skill-consistency.md`).
10. Beim Lesbarkeits-Review konkret belegen: „Ich habe hier gestockt, weil X" ist ein Befund; „ich würde das anders schreiben" ist Geschmack und wird als solcher markiert oder weggelassen (`skill-code-review.md`, Regel 4).

**KANN:**
11. Selbst-Test nach einer Pause: eigenen Code nach 1–2 Tagen (oder nach Kontextwechsel) kalt lesen — wo man selbst stockt, stockt jeder.
12. Leseprotokoll bei wichtigem Code: einen Kollegen/ein Modell laut lesen lassen und Stock-Stellen notieren — billigster Usability-Test der Welt.

## Arbeitsablauf

1. **Leserfrage bestimmen:** Wonach wird jemand in diesem Code suchen? Struktur darauf ausrichten.
2. **Erzählfluss bauen:** Öffentliches oben, Details unten; Regelfall gerade, Guards zuerst.
3. **Absicht heben:** Bedingungen und Schritte benennen; Magisches konstantifizieren.
4. **Distanzen verkürzen:** Deklarationen zur Nutzung, Blöcke gruppieren, Symmetrie herstellen.
5. **Kalt lesen (lassen):** Stock-Stellen sammeln und beheben — im Code, nicht per Kommentar.

## Checkliste

- [ ] Liest sich die Einheit von oben nach unten ohne Rücksprünge?
- [ ] Ist die fachliche Absicht ohne Entziffern der Mechanik erkennbar?
- [ ] Bedingungen positiv, Regelfall zuerst, nichts doppelt verneint?
- [ ] Deklarationen nah an der Nutzung, Blöcke als Gedanken-Absätze?
- [ ] Parallele Fälle in paralleler Form?
- [ ] Magische Werte benannt?
- [ ] Kein Kommentar, der verworrenen Code entschuldigt?
- [ ] Kalt gelesen — ohne Stocken?

## Typische Fehler

- **Autoren-Blindheit:** „Ist doch klar" — dem Autor, heute. Der Maßstab ist der Fremde in 18 Monaten, und der stolpert über jede implizite Annahme.
- **Kompaktheit mit Lesbarkeit verwechseln:** Der Einzeiler, der drei Operationen verkettet, ist kürzer und langsamer zu verstehen. Zeilen sind billig, Leserminuten teuer.
- **Cleverness-Rätsel:** Bit-Tricks, verschachtelte Ternaries, implizite Konversionen — jedes ist ein Mini-Puzzle im Weg des Lesers (`skill-complexity-control.md`, Regel 4).
- **Falsche Fährten:** Kopierter Code mit übrig gebliebenen Namen (`invoiceList` enthält Kunden), Asymmetrie ohne Unterschied, tote Parameter — der Leser sucht Bedeutung, wo keine ist.
- **Kommentar-Pflaster:** `// Achtung, kompliziert:` über 40 verschachtelten Zeilen. Die Energie wäre im Entwirren besser investiert.
- **Format-Guerilla:** Eigene Klammer-/Einrückungsvorlieben gegen die Repo-Konvention — jeder Diff wird zum Suchbild.
- **Lesbarkeits-Absolutismus im Review:** Geschmacksumbauten erzwingen („ich mag keine frühen Returns") — Konvention und Stocken-Beleg zählen, nicht Vorlieben.

## Beispiele

**Absicht gehoben:**
```csharp
// vorher: Leser muss die Mechanik entziffern, um die Frage "wann Express?" zu beantworten
if (o.Items.Sum(i => i.Weight) < 30 && o.Dest.Country == "DE" && !o.Items.Any(i => i.Bulky) && o.PlacedAt.Hour < 14)
    Ship(o);

// nachher: Antwort steht da; Mechanik ist bei Bedarf eine Ebene tiefer nachlesbar
if (QualifiesForSameDayExpress(o))
    Ship(o);
```

**Symmetrie als Lesehilfe:**
```csharp
// parallele Fälle, parallele Form — der Leser sieht sofort: gleiches Muster, anderer Kanal
case Channel.Email: return SendEmail(recipient, message);
case Channel.Sms:   return SendSms(recipient, message);
case Channel.Fax:   return SendFax(recipient, message);
```
Würde der Sms-Fall „aus historischen Gründen" erst loggen und andere Parameter nutzen, wäre das entweder ein echter Unterschied (dann kommentieren: warum) — oder aufzuräumen.

## Eskalation

- Unlesbarkeit hat strukturelle Ursachen (vermischte Anliegen, God-Funktion) → nicht kosmetisch polieren; strukturellen Befund melden (`skill-separation-of-concerns.md`, `skill-function-design.md`).
- Lesbarkeits-Konflikt mit Performance an belegtem Hotspot → Messung entscheidet (`skill-performance-analysis.md`); die unlesbare Optimierung bekommt Warum-Doku und einen Test.
- Wiederkehrender Geschmacks-Streit im Team (frühe Returns, var vs. Typ, …) → einmal entscheiden, festhalten, automatisieren (`skill-consistency.md`, `skill-decision-records.md`) — nie pro PR neu verhandeln.
- Fremdsprachiger/generierter Code massiv unlesbar, aber funktional → Kosten-Nutzen einer Aufbereitung als Entscheidung vorlegen, nicht als Nebenbei-Großprojekt starten.

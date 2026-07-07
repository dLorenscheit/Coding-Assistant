# skill-estimation

**Version:** 1.0 · **Stand:** 2026-07-02 · **Gültigkeitsbereich:** Aufwands- und Terminabschätzung · **Empfohlene Einsatzkontexte:** Tickets, Features, Projekte, Machbarkeits-Anfragen

**Kurzfassung:** Schätzungen sind Wahrscheinlichkeitsaussagen, keine Versprechen: in Spannen schätzen (best/wahrscheinlich/worst), auf Basis von Zerlegung und Vergleichsfällen statt Bauchgefühl, Annahmen mitliefern — und die Vergessens-Klassiker (Randfälle, Integration, Test, Doku, Abstimmung, Deployment) explizit einrechnen.

## Skill-Name

Schätzung

## Zweck

Schätzungen steuern Entscheidungen: lohnt sich das, wann planen wir, was fällt weg. Falsche Schätzkultur — Punktzahlen ohne Annahmen, Optimismus als Höflichkeit, Verwechslung von Schätzung und Zusage — produziert systematisch Krisen. Dieser Skill macht Schätzen zum Handwerk: transparent, kalibrierbar, ehrlich über Unsicherheit.

## Einsatzbereich

- Aufwandsschätzung für Tickets/Features/Projekte
- „Geht das bis X?"-Anfragen (die gefährlichste Form — siehe Kernregeln)
- Kalibrierung: eigene alte Schätzungen gegen Ist-Werte halten

## Denkweise

Eine Schätzung ist eine **Wettervorhersage, kein Fahrplan**: „70 % Wahrscheinlichkeit, in 5–8 Tagen fertig" ist eine ehrliche Aussage; „5 Tage" ist eine Zahl, die der Empfänger als Zusage hört — und die Differenz zwischen beidem wird später als dein Versagen verbucht. Der wichtigste Schritt guten Schätzens ist deshalb Kommunikation: Spanne, Annahmen, und was die Schätzung kippen würde.

Zweites Fundament: **Menschen schätzen den Happy Path.** Die Vorstellung beim Schätzen ist der störungsfreie Durchlauf — real bestehen Aufgaben zur Hälfte aus dem Rest: Randfälle, kaputte Umgebungen, Rückfragen, Integration, Review-Schleifen, Deployment. Wer nur das Vorstellbare schätzt, liegt systematisch 2× daneben — nicht aus Dummheit, aus Konstruktion. Dagegen helfen Zerlegung, Vergleichsfälle und die Vergessens-Checkliste.

## Kernregeln

**MUSS:**
1. In Spannen schätzen: mindestens wahrscheinlicher Fall + Worst Case (bei größeren Vorhaben dreipunktig: best/wahrscheinlich/worst). Eine große Spanne ist Information („hohe Unsicherheit"), keine Schwäche — die Ein-Punkt-Schätzung ist die unehrliche Form.
2. Annahmen mitliefern: Jede Schätzung gilt unter Bedingungen („sofern die API Feld X liefert; sofern keine Migration nötig"). Ohne Annahmen ist die Schätzung nicht kritisierbar — und platzt still, wenn eine Bedingung fällt.
3. Ab mittlerer Größe (> ~2–3 Tage) nur auf Basis von Zerlegung schätzen (`skill-task-decomposition.md`): Teile schätzen sich ehrlicher als Ganzes, und die Zerlegung findet die vergessenen Posten.
4. Die Vergessens-Klassiker explizit durchgehen: Randfälle/Fehlerpfade, Integration mit Bestand, Tests, Doku, Code-Review-Schleifen, Abstimmung/Rückfragen, Deployment/Rollout, Einarbeitung in Unbekanntes. Faustregel: Der Happy-Path-Anteil ist selten mehr als die Hälfte.
5. Schätzung und Zusage strikt trennen — auch sprachlich: Eine Schätzung gibt der Schätzende; eine Zusage (Commitment auf Termin) ist eine Management-Entscheidung auf Basis der Schätzung, inklusive Puffer und Risikoabwägung. Nie unter Druck die Spanne zur Wunschzahl eindampfen — stattdessen benennen, was für die Wunschzahl wegfallen müsste (Scope ist die ehrliche Stellschraube).
6. Bei hoher Unsicherheit nicht raten, sondern die Unsicherheit reduzieren: zeitbegrenzter Spike/Analyse zuerst, dann schätzen („Ich kann nach einem Tag Analyse seriös schätzen — jetzt wäre es Würfeln").

**SOLL:**
7. Vergleichsfälle nutzen: „Ähnlich wie Feature X, das brauchte real 12 Tage" schlägt jede Neuberechnung — historische Ist-Werte sind der beste Kalibrator (Referenzklasse statt Innensicht).
8. Eigene Kalibrierung pflegen: Geschätzt vs. gebraucht gelegentlich vergleichen; wer seinen persönlichen Faktor kennt (häufig 1,5–2×), kann ihn einrechnen.
9. Aufwand von Durchlaufzeit unterscheiden: 5 Personentage sind bei 50 % Verfügbarkeit, Review-Wartezeiten und einer externen Abhängigkeit drei Kalenderwochen — Termine brauchen die zweite Rechnung.
10. Bei Team-Schätzungen Ausreißer ernst nehmen: Wer 3× so hoch schätzt wie der Rest, sieht oft ein Problem, das die anderen nicht sehen — erst verstehen, dann mitteln.

**KANN:**
11. Für kleine gleichartige Tickets Kategorien statt Zahlen (S/M/L mit definierten Bedeutungen) — schneller und ehrlicher als Pseudo-Stunden.
12. Bei Projekten den zentralen Puffer aus der Differenz wahrscheinlich↔worst der Teilschätzungen ableiten (`skill-project-planning.md`, Regel 4).

## Arbeitsablauf

1. **Auftrag klären:** Was gehört dazu, was nicht (Nicht-Ziele!)? Unklarheiten sind Schätzrisiko Nr. 1.
2. **Zerlegen** (ab mittlerer Größe); pro Teil Vergleichsfälle suchen.
3. **Vergessens-Checkliste** über das Ganze (Regel 4).
4. **Spanne bilden:** wahrscheinlich + worst; Treiber der Unsicherheit benennen.
5. **Annahmen dokumentieren** und mit der Spanne kommunizieren — inkl. dessen, was die Schätzung kippen würde.
6. **Nachhalten:** Ist-Werte erfassen, bei geplatzten Annahmen sofort neu schätzen und melden (nicht erst am Termin).

## Checkliste

- [ ] Spanne statt Punktzahl?
- [ ] Annahmen und Kippfaktoren benannt?
- [ ] Ab mittlerer Größe: zerlegt geschätzt?
- [ ] Vergessens-Klassiker (Randfälle, Integration, Test, Doku, Review, Abstimmung, Deployment) eingerechnet?
- [ ] Vergleichsfälle herangezogen?
- [ ] Aufwand und Durchlaufzeit getrennt ausgewiesen?
- [ ] Schätzung nicht unter Druck zur Wunschzahl verbogen?
- [ ] Bei hoher Unsicherheit: Spike statt Ratezahl vorgeschlagen?

## Typische Fehler

- **Höflichkeits-Optimismus:** Die Zahl nennen, die der Fragende hören will. Kurzfristig angenehm, langfristig ruiniert es genau das Vertrauen, das man schonen wollte.
- **Punktzahl-Theater:** „13,5 Personentage" — Scheinpräzision ohne Spanne suggeriert Sicherheit, die nicht existiert.
- **Happy-Path-Schätzung:** Nur die Vorstellung des Codens geschätzt; Integration, Randfälle und die drei Review-Runden kommen „überraschend".
- **Ganzes-auf-einmal:** „Das Feature? So drei Wochen." Ohne Zerlegung ist das ein Gefühl mit Einheit dran.
- **Schätzung als Zusage behandelt (von beiden Seiten):** Der Schätzende fühlt sich an seine Spanne gebunden wie an ein Versprechen; der Empfänger bucht den Best Case als Termin. Beides Kommunikationsversagen.
- **Anker-Falle:** „Das dauert doch maximal zwei Tage, oder?" — und die Schätzung orientiert sich brav am Anker. Erst selbst schätzen, dann vergleichen.
- **Stilles Neuschätzen:** Annahme geplatzt, Aufwand verdoppelt — und niemand erfährt es bis zur Deadline. Neuschätzung ist ein Melde-Ereignis.

## Beispiele

**Gut kommuniziert:**
> „PDF-Mailversand: wahrscheinlich 6–8 PT, worst case 12. Annahmen: vorhandener PDF-Generator läuft headless (prüfe ich am Tag 1 — wenn nicht, +3–4 PT); kein Template-Editor (Nicht-Ziel). Größte Unsicherheit: Bounce-Handling mit dem Mail-Provider, dazu gibt es keinen Vergleichsfall bei uns. Durchlaufzeit bei aktueller Auslastung: ~3 Wochen."

Der Empfänger kann jetzt entscheiden — und weiß, welche Nachricht am Tag 1 die Planung ändert.

**Druck richtig beantwortet:**
> „Bis zum 15. schaffe ich es mit 70 % Wahrscheinlichkeit nicht. Sicher machbar bis dahin: Scheibe 1 (manueller Versand, Standard-Template). Der Rest zwei Wochen später. Welche Variante wollt ihr?" — Scope verhandelt statt Spanne verbogen.

## Eskalation

- Wunschtermin liegt unterhalb des Best Case → sofort und schriftlich melden mit Scope-Optionen; „sportlich versuchen" ist keine Option, sondern vertagtes Scheitern.
- Annahme platzt oder Spike zeigt Mehraufwand → Neuschätzung aktiv kommunizieren, sobald erkannt (`skill-project-planning.md`, Regel 5).
- Druck, die Schätzung zu „korrigieren" ohne Scope-Änderung → Spanne begründet stehen lassen; die Termin-Entscheidung samt Risiko liegt beim Entscheider und wird dokumentiert (`skill-decision-records.md`).
- Schätzung für fremdes Fachgebiet/fremden Code verlangt → als Fremdschätzung kennzeichnen (doppelte Unsicherheit) oder jemanden mit Kontext hinzuziehen.

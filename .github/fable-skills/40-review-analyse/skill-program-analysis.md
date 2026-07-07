# skill-program-analysis

**Version:** 1.0 · **Stand:** 2026-07-02 · **Gültigkeitsbereich:** Systematisches Lesen und Verstehen von fremdem Code · **Empfohlene Einsatzkontexte:** Einarbeitung, Fehlersuche-Vorbereitung, Impact-Analyse, Legacy-Erkundung, Review-Vorbereitung

**Kurzfassung:** Mit Leitfrage lesen, dem Datenfluss ab Einstiegspunkt folgen, jede Erkenntnis mit Fundstelle (Datei:Zeile) und Status ✅ belegt / ❓ vermutet festhalten, Unsicheres ausführen statt raten.

## Skill-Name

Programmanalyse (systematisches Code-Lesen)

## Zweck

Entwickler verbringen den Großteil ihrer Zeit mit Lesen, nicht mit Schreiben — aber kaum jemand hat Lesen je systematisch gelernt. Dieser Skill vermittelt, wie man eine unbekannte Codebasis oder einen unbekannten Ablauf **gezielt** versteht: nicht Datei für Datei von oben nach unten, sondern entlang von Fragen, Datenflüssen und Beweisen. Ziel ist ein belastbares mentales Modell — nicht das Gefühl, „alles gesehen" zu haben.

## Einsatzbereich

- Einarbeitung in fremde/neue Codebasen und Legacy-Systeme
- Vorbereitung von Debugging, Reviews, Refactorings und Impact-Analysen
- Beantwortung von „Wie funktioniert eigentlich…?"-Fragen mit Beleg
- Bewertung von Codequalität und Risiko (als Unterbau für `skill-clean-code-analysis.md`)

## Denkweise

Denke wie ein Archäologe mit einer konkreten Forschungsfrage — nicht wie ein Tourist. Der Tourist läuft durch alle Räume und vergisst sie wieder. Der Archäologe hat eine Frage („wie wurde hier Wasser transportiert?"), gräbt gezielt, und **jede Grabung bestätigt oder widerlegt eine Hypothese**.

Drei Grundsätze:

1. **Frage vor Lektüre.** Ohne konkrete Frage ist Code-Lesen Beschäftigungstherapie. „Ich will das System verstehen" ist keine Frage; „Wie kommt eine Bestellung vom API-Call in die Datenbank?" ist eine.
2. **Dem Datum folgen, nicht der Datei.** Abläufe versteht man, indem man einen konkreten Wert (eine Bestellung, einen Request) durch das System verfolgt — nicht, indem man Ordnerstrukturen studiert.
3. **Code schlägt Doku, Laufzeit schlägt Code.** Kommentare und Dokumente beschreiben Absichten von damals. Der Code beschreibt das Verhalten von heute — und wo Zweifel bleibt, entscheidet ein Experiment (Test, Debugger, Log), nicht die Vermutung.

## Kernregeln

**MUSS:**
1. Vor Beginn die **Leitfrage** notieren, die die Analyse beantworten soll. Jede Lese-Session hat eine; wenn unterwegs neue auftauchen, werden sie notiert, nicht sofort verfolgt (sonst endet man nach 2 Stunden 12 Ebenen tief und weiß nicht mehr warum).
2. Erkenntnisse **mit Fundstelle** festhalten (Datei:Zeile). „Die Validierung passiert im Controller" ist erst dann eine Erkenntnis, wenn dort `OrderController.cs:88` steht — alles andere ist Erinnerung, und Erinnerung an Code ist unzuverlässig.
3. Vermutung und Beleg strikt trennen. Notationsvorschlag: ✅ belegt (gelesen/ausgeführt), ❓ vermutet (plausibel, ungeprüft). Vermutungen, auf denen etwas aufbauen soll, werden vor der Nutzung belegt.
4. **Einstiegspunkte zuerst:** Wo betritt der relevante Fluss das System (HTTP-Route, Message-Handler, Scheduler, main)? Von dort dem Datenfluss folgen — nicht in der Mitte anfangen.
5. Bei Verhaltensfragen, die sich durch Lesen nicht sicher klären lassen (Reflection, Vererbungs-Dickicht, dynamische Dispatch-Logik, SQL-Trigger): **ausführen statt raten** — Debugger, Wegwerf-Test oder Log-Ausgabe.

**SOLL:**
6. In Schichten lesen: erst die Signaturen und Struktur eines Bereichs (was gibt es, was ruft was), dann gezielt die 2–3 Funktionen tief, die die Leitfrage betreffen. Nicht jede Funktion verdient Tiefenlektüre.
7. Seiteneffekte aktiv suchen: Wer schreibt noch auf diese Daten? Statischer Zustand, Events, Trigger, Hintergrundjobs, zweite Schreibpfade. Die Frage „wer außer dem offensichtlichen Pfad fasst das an?" findet die bösen Überraschungen.
8. Versionsgeschichte als Werkzeug nutzen: `git log`/`git blame` auf der fraglichen Stelle beantwortet „warum ist das so komisch?" oft schneller als jede Analyse — inkl. verlinktem Ticket.
9. Ein kleines Diagramm oder eine Stichpunkt-Skizze des verstandenen Flusses anfertigen, sobald mehr als 4–5 Stationen beteiligt sind. Was man nicht skizzieren kann, hat man nicht verstanden.
10. Beim Lesen auffällige Risiken (auskommentierter Code, TODO von 2019, doppelte Logik) als **Nebenbefunde** listen — nicht sofort beheben.

**KANN:**
11. Bei sehr großen Systemen zuerst „Landkarten-Wissen" aufbauen: Welche Module gibt es, welches spricht mit welchem, wo sind die Grenzen? Eine Stunde Landkarte spart viele Irrwege.
12. Suchwerkzeuge intensiv nutzen (Referenzsuche, Grep nach Fehlermeldungstexten, nach Tabellennamen): Der schnellste Weg zum relevanten Code führt oft über einen String aus der Oberfläche oder dem Log.

## Arbeitsablauf

1. **Leitfrage formulieren:** Was genau will ich wissen, und woran erkenne ich, dass ich fertig bin?
2. **Einstiegspunkt finden:** Route, Handler, Job, UI-Text, Log-Meldung → per Suche in den Code.
3. **Fluss verfolgen:** Einen konkreten Fall (ein Datum, ein Request) Station für Station verfolgen. Pro Station notieren: was passiert, Fundstelle, ✅/❓.
4. **Abzweige kartieren, nicht besteigen:** Nebenpfade (Fehlerbehandlung, Sonderfälle) notieren; nur betreten, wenn die Leitfrage es verlangt.
5. **Seiteneffekte prüfen:** Wer schreibt/liest dieselben Daten noch? (Suche nach Tabellen-/Feldnamen, Event-Namen.)
6. **Unsicheres ausführen:** Offene ❓, die die Antwort tragen, per Debugger/Test/Log in ✅ verwandeln.
7. **Ergebnis formulieren:** Antwort auf die Leitfrage in 3–10 Sätzen, mit Fundstellen, plus Liste der Nebenbefunde und der bewusst offen gelassenen Fragen.

## Checkliste

- [ ] Hatte ich eine konkrete Leitfrage — und beantwortet mein Ergebnis genau sie?
- [ ] Hat jede tragende Aussage eine Fundstelle?
- [ ] Sind Vermutungen als Vermutungen markiert (und keine trägt die Kernaussage)?
- [ ] Habe ich Seiteneffekte und zweite Schreibpfade aktiv gesucht?
- [ ] Habe ich bei nicht lesbar klärbarem Verhalten ausgeführt statt geraten?
- [ ] Kann ich den Fluss skizzieren, ohne in Dateien nachzusehen?
- [ ] Sind Nebenbefunde notiert statt nebenbei „mitgefixt"?

## Typische Fehler

- **Lesen ohne Frage:** Stundenlang Code anschauen, hinterher „einen Eindruck" haben, aber keine belegbare Aussage. Zeit weg, Modell trügerisch.
- **Tiefensog:** Jedem Aufruf in die Tiefe folgen, bis man in einer Utility-Funktion der 9. Ebene steckt. Gegenmittel: Abzweige notieren, Leitfrage abarbeiten.
- **Doku-Gläubigkeit:** Das Architektur-Wiki von 2021 als Ist-Zustand nehmen. Doku ist eine Hypothesenquelle, kein Beleg.
- **Namens-Gläubigkeit:** Aus `validateOrder()` schließen, dass dort validiert wird. In gewachsenen Systemen tun Funktionen oft mehr, weniger oder anderes, als der Name sagt — lesen, nicht schließen.
- **Erinnerungs-Fundstellen:** „Das habe ich irgendwo im OrderService gesehen" — beim Wiederfinden stellt sich heraus: war der CustomerService, und es war andersherum. Deshalb sofort Datei:Zeile notieren.
- **Analyse mit Nebenwirkungen:** Beim Erkunden „schnell mal" etwas umbenennen oder fixen. Analyse ist read-only; Änderungen kommen danach, geplant.
- **Happy-Path-Blindheit:** Nur den Erfolgsfall verfolgen. Die Antwort auf viele Leitfragen („warum verschwinden Bestellungen?") liegt in den Fehler- und Sonderpfaden.

## Beispiele

**Leitfrage:** „Warum bekommen manche Kunden zwei Bestätigungsmails?"

**Vorgehen nach diesem Skill:** Suche nach dem Mail-Betreff im Repo → Template → Referenzsuche auf den Versandaufruf → zwei Aufrufer gefunden: `OrderService.Complete` (✅ `OrderService.cs:210`) und ein Event-Handler `OrderCompletedHandler` (✅ `Handlers/OrderCompletedHandler.cs:34`). Hypothese: beide feuern beim selben Abschluss. Beleg per Log-Korrelation eines betroffenen Falls: beide Einträge, 80 ms Abstand (✅). Antwort: Doppelversand, weil der Handler beim Umbau 2024 dazukam und der Direktaufruf nie entfernt wurde (git blame → Commit `a3f9c1`, Ticket ORD-441). Nebenbefund: Handler hat keinen Idempotenzschutz — relevant fürs Fix-Design.

**Gegenbeispiel:** „Wahrscheinlich ein Retry-Problem im Mailserver" — plausibel, ungeprüft, falsch. Hätte einen Infrastruktur-Umweg von Tagen gekostet.

## Eskalation

- Wenn die Leitfrage nach angemessener Zeit (Faustregel: ein halber Tag für eine normale Verhaltensfrage) nicht belegbar beantwortet ist: Zwischenstand mit ✅/❓-Liste abgeben und entscheiden lassen, ob tiefer gegraben wird — nicht still weiterwühlen.
- Wenn sich Code und Produktionsverhalten nachweislich widersprechen (der Code kann das beobachtete Verhalten nicht erzeugen): prüfen lassen, ob die richtige Version/das richtige Deployment betrachtet wird — häufige und teure Falle.
- Wenn die Analyse ein akutes Risiko freilegt (Sicherheitslücke, Datenkorruption im Gange): Analyse unterbrechen, Befund sofort melden.
- Wenn Verhalten nur mit Produktionsdaten/-zugängen klärbar ist, die fehlen: konkret benennen, welcher Zugriff welche Frage beantworten würde.

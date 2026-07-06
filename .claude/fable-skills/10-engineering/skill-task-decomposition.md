# skill-task-decomposition

**Version:** 1.0 · **Stand:** 2026-07-02 · **Gültigkeitsbereich:** Jede Aufgabe, die größer ist als ein einzelner überschaubarer Arbeitsschritt · **Empfohlene Einsatzkontexte:** Features, Refactorings, Migrationen, Epics

**Kurzfassung:** In Schritte schneiden, nach denen das System lauffähig und der Fortschritt prüfbar ist; Riskantes und Unbewiesenes ins erste Drittel; früh ein dünner Ende-zu-Ende-Pfad; Migrationen rückrollbar.

## Skill-Name

Aufgabenzerlegung

## Zweck

Große Aufgaben scheitern selten an ihrer Schwierigkeit — sie scheitern daran, dass sie als ein großer Block angegangen werden: kein Zwischenstand lauffähig, kein Fortschritt messbar, Risiken sammeln sich am Ende. Dieser Skill zerlegt Aufgaben so, dass jeder Teil **eigenständig prüfbar** ist, das **Riskanteste früh** kommt und man **jederzeit anhalten** kann, ohne Scherben zu hinterlassen.

## Einsatzbereich

- Features, die mehr als einen Arbeitstag oder mehr als ~3 Dateien betreffen
- Refactorings und Migrationen (dort ist Zerlegung überlebenswichtig)
- Bugfixes mit unklarer Ursache (Zerlegung in Diagnose- und Fix-Schritte)
- Arbeitspakete für kleinere Modelle oder Junioren schnüren

## Denkweise

Denke wie ein Bergführer, der eine Route in Seillängen einteilt: Jede Seillänge endet an einem **sicheren Stand** — einem Zustand, an dem man gesichert ist, den Zustand bewerten und notfalls umkehren kann. Eine Zerlegung, deren Teilschritte das System kaputt zurücklassen („Schritt 3 von 7: kompiliert nicht"), ist keine Zerlegung, sondern nur ein zerschnittener Monolith.

Zweiter Leitgedanke: **Risiko nach vorn.** Junioren arbeiten instinktiv das Einfache zuerst ab — dann steht man in Woche 3 vor der Erkenntnis, dass die zentrale Annahme (die fremde API kann das gar nicht) nicht trägt, und alles Einfache war umsonst. Der Senior validiert das Wackligste zuerst, solange der Kurswechsel noch billig ist.

## Kernregeln

**MUSS:**
1. Jeder Teilschritt endet in einem **prüfbaren, lauffähigen Zustand**: Build grün, Tests grün, System funktionsfähig (ggf. mit noch unsichtbarem neuem Verhalten).
2. Jeder Teilschritt hat ein **eigenes Fertig-Kriterium** („Done heißt: Endpunkt liefert X, Test Y grün") — nicht nur einen Titel.
3. Die Reihenfolge sortiert nach **Risiko und Erkenntniswert**, nicht nach Bequemlichkeit: Unbewiesene Annahmen (fremde API, Datenqualität, Performance-Machbarkeit) werden im ersten Drittel validiert.
4. Abhängigkeiten zwischen Schritten explizit benennen. Was parallelisierbar ist, als parallelisierbar markieren.
5. Bei Migrationen/Refactorings: Jeder Schritt muss **einzeln rückrollbar** sein oder ausdrücklich als Point-of-no-Return markiert werden (davon gibt es idealerweise genau einen, spät, klein und geprobt).

**SOLL:**
6. Schrittgröße: so, dass ein Schritt in einer fokussierten Sitzung (halber Tag oder weniger) abschließbar ist. Größere Schritte weiter zerlegen.
7. Diagnose von Umsetzung trennen: Bei unklarer Ursache ist „Ursache belegt" ein eigener Schritt mit eigenem Ergebnis — nicht der stille Anfang des Fix-Schritts.
8. Neue Funktionalität hinter Schaltern/Flags oder ungenutztem Code aufbauen, sodass Integration ein eigener, kleiner, später Schritt ist („dunkel bauen, hell schalten").
9. Für jeden Schritt notieren, **was man danach weiß**, das man vorher nicht wusste — Schritte ohne Erkenntnis- oder Wertzuwachs streichen oder zusammenlegen.

**KANN:**
10. Einen expliziten „Spike"-Schritt einplanen: zeitlich begrenzter Wegwerf-Prototyp nur zur Risikoklärung. Spike-Code wird weggeworfen, das ist sein Zweck — er darf nie „aus Zeitgründen" zur Basis werden.
11. Bei Übergabe an kleinere Modelle: Pakete so schneiden, dass jedes Paket ohne Wissen über die anderen lösbar ist (Kontext im Paket, nicht im Kopf des Verteilers).

## Arbeitsablauf

1. **Zielbild klären:** Ergebnis aus `skill-requirements-analysis.md` vorliegen haben (Ziel, Erfolgskriterien, Nicht-Ziele).
2. **Annahmen listen:** Was muss wahr sein, damit der Plan funktioniert? Jede Annahme bekommt eine Einstufung: belegt / plausibel / ungeprüft-kritisch.
3. **Ungeprüft-Kritisches zuerst:** Für jede kritische Annahme einen frühen Validierungsschritt einplanen (Spike, Test gegen echte API, Messung an echten Daten).
4. **Rückgrat definieren:** Den dünnsten durchgehenden Pfad bestimmen, der Ende-zu-Ende funktioniert („Tracer Bullet": ein Datensatz, ein Happy Path, echte Schichten). Der kommt vor der Breite.
5. **Breite auffüllen:** Restliche Funktionalität in Schritte mit je eigenem Fertig-Kriterium schneiden. Abhängigkeiten und Parallelisierbarkeit markieren.
6. **Sichere Stände prüfen:** Für jeden Schritt fragen: Ist das System danach lauffähig? Kann ich hier pausieren oder umkehren? Wenn nein: Schnitt verschieben.
7. **Plan sichtbar machen:** Liste mit Reihenfolge, Fertig-Kriterien und Risiken festhalten (Ticket, TodoWrite, Plan-Dokument) — Pläne im Kopf sind keine Pläne.

## Checkliste

- [ ] Ist nach jedem Schritt das System lauffähig und der Schritt prüfbar abgeschlossen?
- [ ] Steht das Riskanteste/Unbekannteste im ersten Drittel?
- [ ] Gibt es früh einen durchgehenden Ende-zu-Ende-Pfad?
- [ ] Hat jeder Schritt ein Fertig-Kriterium, das ein anderer prüfen könnte?
- [ ] Sind Abhängigkeiten und Parallelisierbares markiert?
- [ ] Ist bei Migrationen jeder Schritt rückrollbar (oder der Point-of-no-Return bewusst gesetzt)?
- [ ] Ist kein Schritt größer als eine fokussierte Sitzung?

## Typische Fehler

- **Schichten-Schnitt:** Zerlegen nach Architekturschichten („erst die ganze DB, dann das ganze Backend, dann das ganze Frontend"). Ergebnis: Integration — und damit die Wahrheit — kommt ganz am Ende. Richtig: vertikal schneiden, ein dünner Pfad durch alle Schichten zuerst.
- **Das Einfache zuerst:** Wochenlang Bekanntes bauen, das Unbekannte aufschieben. Fortschrittsgefühl ohne Risikoabbau.
- **Pseudo-Schritte:** „Schritt 1: Analyse. Schritt 2: Umsetzung. Schritt 3: Test." Das ist keine Zerlegung, das ist ein Wasserfall in Listenform.
- **Kaputte Zwischenzustände:** Schritte, nach denen nichts kompiliert oder Tests tagelang rot sind. Dann ist jede Unterbrechung (Krankheit, Prio-Wechsel) ein Scherbenhaufen.
- **Big-Bang-Umschaltung:** Migration ohne Parallelbetriebs- oder Rückrollschritt. Wenn der eine große Umschalttag schiefgeht, gibt es keinen Plan B.
- **Zerlegung ohne Pflege:** Der Plan wird bei neuen Erkenntnissen nicht angepasst. Ein Plan ist ein Werkzeug, kein Vertrag.

## Beispiele

**Aufgabe:** „PDF-Rechnungsversand per Mail einbauen" (Bestandssystem, bisher nur Download).

**Schwache Zerlegung:** 1. Mail-Service bauen. 2. PDF-Generierung bauen. 3. UI bauen. 4. Alles verbinden. 5. Testen.

**Fable-Zerlegung:**
1. *Risiko validieren:* Kann der vorhandene PDF-Generator im Batch ohne UI-Kontext laufen? (Ungeprüfte kritische Annahme — Spike, ½ Tag.) Done: 1 PDF headless erzeugt.
2. *Rückgrat:* Ein hartkodierter Testkunde bekommt per Klick eine Mail mit echtem PDF über den echten Mail-Provider (Testpostfach). Done: Mail kommt an, E2E-Pfad bewiesen.
3. Versand-Datenmodell + Statushistorie (verschickt/fehlgeschlagen). Done: Migration läuft vor und zurück, Status wird geschrieben.
4. Fehlerpfade: Provider down, ungültige Adresse, Retry-Regeln. Done: Tests für alle drei Pfade grün.
5. UI-Integration hinter Feature-Flag. Done: intern nutzbar.
6. Flag an für Pilotkunden, Monitoring beobachten. Done: 1 Woche fehlerfrei → alle.

Schritt 1 und 3 sind parallelisierbar, Point-of-no-Return existiert nicht (Flag-Rückschaltung jederzeit möglich).

## Eskalation

Rückfrage oder Neuverhandlung des Auftrags, wenn:

- sich kein Schnitt finden lässt, bei dem Zwischenstände lauffähig bleiben — das ist meist ein Zeichen, dass die Architektur das Feature nicht trägt und zuerst ein vorbereitendes Refactoring nötig ist (das ist dann Schritt 1 und muss dem Auftraggeber genannt werden),
- die Validierung einer kritischen Annahme fehlschlägt (fremde API kann X nicht) — sofort melden, nicht erst den Rest bauen,
- die Zerlegung ergibt, dass der Aufwand die grobe Erwartung des Auftraggebers deutlich übersteigt (Faktor ≥ 2): erst Erwartung abgleichen, dann weiterbauen,
- ein Point-of-no-Return unvermeidbar groß wird (z. B. destruktive Datenmigration): explizite Freigabe durch Menschen einholen, Rückwärtspfad und Probelauf verpflichtend.

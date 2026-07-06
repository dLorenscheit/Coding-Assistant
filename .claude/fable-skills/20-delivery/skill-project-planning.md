# skill-project-planning

**Version:** 1.0 · **Stand:** 2026-07-02 · **Gültigkeitsbereich:** Planung von Vorhaben über mehrere Wochen/Beteiligte · **Empfohlene Einsatzkontexte:** Projekte, Migrationen, größere Releases

**Kurzfassung:** Ein Plan ist eine Kette prüfbarer Zwischenzustände, nicht ein Datum mit Hoffnung: Meilensteine als verifizierbare Ergebnisse definieren, das Riskanteste vorziehen, Puffer explizit statt versteckt, Abhängigkeiten und Verantwortliche benennen — und den Plan bei jeder neuen Erkenntnis sichtbar nachführen.

## Skill-Name

Projektplanung

## Zweck

Projekte scheitern selten am Können und oft am Planungsstil: unprüfbare Meilensteine („Backend fertig"), Risiken am Ende, Puffer in Einzelschätzungen versteckt, Abhängigkeiten entdeckt statt geplant. Dieser Skill überträgt die Zerlegungslogik von `skill-task-decomposition.md` auf die Projektebene — mit Menschen, Abhängigkeiten und Kommunikation als zusätzlichen Dimensionen.

## Einsatzbereich

- Vorhaben > ~2 Wochen oder > 2 Beteiligte
- Migrationen und Ablösungen (dort mit `skill-legacy-code-handling.md`)
- Re-Planung, wenn ein laufendes Projekt von der Realität eingeholt wurde

## Denkweise

Denke an den Plan als **Landkarte mit eingezeichneten Sümpfen**, nicht als Fahrplan: Ein Fahrplan verspricht Ankunftszeiten; eine Landkarte zeigt Wege, Gefahren und Umleitungen. Der Wert des Plans liegt nicht im eingehaltenen Datum, sondern darin, dass jeder weiß, wo man steht, was als Nächstes kommt und wo es gefährlich wird — und dass Abweichungen früh sichtbar werden statt am Ende.

Zweiter Grundsatz: **Ein Meilenstein ist ein Zustand, den man prüfen kann, nicht ein Aufwand, den man verbraucht hat.** „80 % fertig" ist keine Information (die letzten 20 % dauern erfahrungsgemäß die zweite Hälfte). „Pilotkunde arbeitet produktiv auf dem neuen System" ist eine.

## Kernregeln

**MUSS:**
1. Jeder Meilenstein ist ein **prüfbares Ergebnis** („X läuft in Umgebung Y, nachgewiesen durch Z"), kein Tätigkeitsstand („Entwicklung abgeschlossen"). Wer den Meilenstein nicht objektiv abnehmen kann, hat keinen.
2. Risiko nach vorn: Die unbewiesenen Annahmen des Projekts (Technik, Datenqualität, Verfügbarkeit Dritter) werden in den ersten Meilensteinen validiert — nicht das Vertraute zuerst (`skill-task-decomposition.md`, Regel 3; Risiken systematisch: `skill-risk-analysis.md`).
3. Abhängigkeiten explizit: Wer/was muss wann liefern (Team, Fachbereich, Dienstleister, Freigaben, Hardware)? Jede externe Abhängigkeit bekommt Verantwortlichen, Termin und einen Plan B oder mindestens ein Frühwarnsignal.
4. Puffer explizit und zentral führen, nicht in Einzelschätzungen verstecken: Ein sichtbarer Projektpuffer wird gemanagt; 30 versteckte Einzelpuffer werden verbraucht (Parkinson) und fehlen trotzdem am Ende (`skill-estimation.md`).
5. Plan aktuell halten: Neue Erkenntnisse (geplatzte Annahme, verschobene Abhängigkeit) werden eingearbeitet und den Beteiligten kommuniziert — ein Plan, der nur beim Kickoff stimmt, ist Dekoration. Abweichungen meldet man, wenn man sie erkennt, nicht wenn sie unübersehbar sind.

**SOLL:**
6. Früh einen durchgehenden Wertstrang liefern (erste nutzbare Teilmenge in echter Umgebung) — er beweist die Kette Ende-zu-Ende und macht Fortschritt ehrlich messbar.
7. Kommunikationsrhythmus festlegen (wer erfährt was, wie oft, in welcher Form) — bei Projekten sterben mehr Termine an Überraschung als an Verspätung.
8. Rollen klären: Wer entscheidet bei Zielkonflikten (Scope vs. Termin vs. Qualität)? Unklare Entscheidungswege kosten in jeder Krise Tage.
9. Scope-Verhandlungsmasse vorsortieren: Was fällt zuerst raus, wenn es eng wird (`skill-prioritization.md`)? Die Entscheidung in der Krise ist dann Stunden statt Wochen.
10. Definition of Done projektweit klären (inkl. Tests, Doku, Betriebsübergabe) — sonst ist „fertig" pro Person etwas anderes.

**KANN:**
11. Pre-Mortem beim Start: „Es ist 6 Monate später, das Projekt ist gescheitert — warum?" Die Antworten sind die ehrlichste Risikoliste (`skill-risk-analysis.md`).
12. Meilenstein-Trendanalyse führen (verschieben sich Termine systematisch?) — ein driftender Trend ist das früheste Warnsignal.

## Arbeitsablauf

1. **Ziel und Nicht-Ziele fixieren** (`skill-requirements-analysis.md` auf Projektebene): Woran wird Erfolg gemessen?
2. **Annahmen und Risiken listen,** Validierungs-Meilensteine für die kritischen definieren.
3. **Meilensteinkette bauen:** prüfbare Zustände, Riskantes vorn, früher Wertstrang, Abhängigkeiten eingezeichnet.
4. **Aufwand mit Spannen schätzen** (`skill-estimation.md`), zentralen Puffer dimensionieren.
5. **Rollen, Entscheidungswege, Kommunikationsrhythmus festlegen.**
6. **Laufend nachführen:** Erkenntnisse einarbeiten, Trend beobachten, Abweichungen sofort kommunizieren, Scope-Verhandlung rechtzeitig auslösen.

## Checkliste

- [ ] Ist jeder Meilenstein ein prüfbarer Zustand mit Abnahmekriterium?
- [ ] Werden die kritischen Annahmen im ersten Drittel validiert?
- [ ] Haben externe Abhängigkeiten Verantwortliche, Termine und Frühwarnsignale?
- [ ] Ist der Puffer explizit und zentral?
- [ ] Gibt es früh einen durchgehenden, nutzbaren Wertstrang?
- [ ] Sind Entscheidungswege für Zielkonflikte geklärt?
- [ ] Ist die Scope-Verhandlungsmasse vorsortiert?
- [ ] Wird der Plan sichtbar nachgeführt?

## Typische Fehler

- **Rückwärtsplanung vom Wunschtermin:** Das Datum steht, die Arbeit wird passend gerechnet. Der Plan ist am ersten Tag Fiktion — und alle wissen es.
- **Tätigkeits-Meilensteine:** „Analyse fertig, Entwicklung fertig, Test fertig" — dreimal Wasserfall, null Prüfbarkeit, Integration und Wahrheit ganz am Ende.
- **90-%-Syndrom:** Monatelang „auf Kurs", dann explodiert das letzte Zehntel. Ursache: Fortschritt wurde in verbrauchtem Aufwand gemessen statt in erreichten Zuständen.
- **Abhängigkeits-Naivität:** „Der Dienstleister liefert im März" — ungefragt, unbestätigt, ohne Plan B. Er liefert im Juni.
- **Stille Drift:** Jeder weiß seit Wochen, dass es klemmt; offiziell ist alles grün. Die Eskalation kommt, wenn nichts mehr zu retten ist.
- **Plan als Monument:** Nach der geplatzten Annahme in Woche 3 wird der Plan nicht angepasst, sondern ignoriert — ab da läuft das Projekt ohne Karte.

## Beispiele

**Prüfbare Meilensteinkette (Migration Fakturierung, verkürzt):**
1. *Risiko validiert:* Datenqualitäts-Analyse der Alt-DB abgeschlossen; Migrationsregeln für die 3 dreckigsten Felder mit Fachbereich abgenommen (Dokument X).
2. *Wertstrang:* 1 Pilotmandant erzeugt Rechnungen auf Neu, Alt läuft parallel, Vergleichslauf differenzfrei über einen Monatslauf.
3. *Breite:* 20 % der Mandanten migriert, Fehlerrate < definierter Schwelle, Rückweg pro Mandant getestet.
4. *Abschluss:* Alle Mandanten migriert, Alt schreibgeschützt, Betriebsübergabe (Runbook abgenommen).

Jeder Punkt objektiv abnehmbar; das Datenqualitäts-Risiko (Projektkiller Nr. 1) steht ganz vorn; Parallelbetrieb macht den Rückweg real.

## Eskalation

- Wunschtermin und Schätzspanne klaffen von Anfang an auseinander → sofort Scope/Termin/Besetzung verhandeln lassen — nicht „sportlich losstarten" (`skill-estimation.md`, Eskalation).
- Kritische Annahme platzt (Validierungs-Meilenstein rot) → Re-Planung mit Optionen an die Entscheider, bevor weitere Meilensteine Aufwand verbrennen.
- Externe Abhängigkeit driftet ohne Reaktion des Verantwortlichen → formell eskalieren mit Auswirkung auf die Kette („ohne X am Termin Y verschiebt sich Z um…").
- Zielkonflikt ohne benannten Entscheider tritt auf → Entscheidung einfordern und festhalten (`skill-decision-records.md`); nicht im Team „irgendwie" auflösen.

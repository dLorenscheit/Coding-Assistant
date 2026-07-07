# skill-performance-analysis

**Version:** 1.0 · **Stand:** 2026-07-02 · **Gültigkeitsbereich:** Analyse und Verbesserung von Laufzeit, Durchsatz, Ressourcenverbrauch · **Empfohlene Einsatzkontexte:** „Zu langsam"-Meldungen, Skalierungsfragen, Kostenoptimierung

**Kurzfassung:** Erst Ziel definieren (wie schnell ist schnell genug?), dann messen statt raten, den größten Engpass belegen (meist I/O: N+1-Queries, fehlende Indizes, serielle externe Aufrufe), gezielt beheben, Verbesserung nachmessen — nie auf Verdacht optimieren.

## Skill-Name

Performance-Analyse

## Zweck

Performance-Arbeit ohne Messung ist Aberglaube: Man optimiert, was man versteht, statt was bremst — und opfert Lesbarkeit für Mikro-Gewinne, während der echte Engpass (die 400 Queries pro Request) unberührt bleibt. Dieser Skill erzwingt den Dreischritt Ziel → Messung → belegter Engpass, bevor irgendetwas „optimiert" wird.

## Einsatzbereich

- Konkrete Langsamkeits-Beschwerden („Report dauert 40 Minuten")
- Kapazitäts-/Skalierungsfragen („hält das 10× Last aus?")
- Ressourcen-/Kostenfragen (Speicher, DB-Last, Cloud-Kosten)
- Performance-Aspekt in Reviews (dort: nur belegte Bedenken, siehe `skill-code-review.md` Regel 5)

## Denkweise

Denke wie ein Arzt mit Messgeräten, nicht wie ein Heiler mit Gefühl: Erst die Vitalwerte (Profil, Query-Log, Timings), dann die Diagnose, dann die Therapie. Intuition sagt, welche Messung man zuerst macht — sie ersetzt keine.

Zwei Erfahrungswerte, die Junioren Zeit sparen: **(1) Der Engpass ist fast immer I/O**, nicht CPU: N+1-Queries, fehlende Indizes, serielle statt paralleler externer Aufrufe, zu viele/zu fette Daten über die Leitung. In CPU-Schleifen zu optimieren, bevor I/O ausgeschlossen ist, ist fast immer verschwendet. **(2) Performance ist eine Anforderung wie jede andere:** Ohne Zielwert („< 5 s bei 2 Mio. Zeilen") gibt es kein „fertig" — nur endloses Basteln.

## Kernregeln

**MUSS:**
1. Vor jeder Optimierung ein messbares Ziel festhalten: Welche Operation, welche Datenmenge/Last, welcher Zielwert. „Schneller" ist kein Ziel.
2. Messen vor Ändern: Profil/Timing/Query-Log der echten Operation mit realistischen Daten. Die Baseline wird dokumentiert — sonst ist „Verbesserung" nicht beweisbar.
3. Den Engpass belegen, nicht vermuten: Optimiert wird die messbar teuerste Stelle. Eine Optimierung ohne vorherige Messung an genau dieser Stelle wird nicht gemerged.
4. Nach der Änderung dieselbe Messung wiederholen und Vorher/Nachher berichten. Keine messbare Verbesserung → Änderung zurücknehmen (sie hat Komplexität gekostet).
5. Mit realistischen Datenmengen messen: 100 Testzeilen verhalten sich anders als 2 Mio. Produktionszeilen (Indizes, Caches, Pläne). Entwicklung-DB-Messungen als solche kennzeichnen.
6. Korrektheit geht vor: Eine Optimierung, die Verhalten ändert (andere Rundung, stale Cache ohne Invalidierungskonzept), ist ein Bug mit gutem Benchmark.

**SOLL:**
7. Die üblichen Verdächtigen zuerst prüfen (billig, häufig): N+1-Queries (Query-Log zählen!), fehlende Indizes (Execution Plan), serielle externe Aufrufe (parallelisierbar?), unnötige Datenmengen (SELECT *, fehlende Pagination), wiederholte identische Berechnungen/Aufrufe (Cache-Kandidat).
8. Caching als letztes Mittel mit erstem Preis behandeln: Jeder Cache braucht eine Antwort auf „wann wird er ungültig?" — sonst tauscht man Langsamkeit gegen Falschheit. Erst Query/Algorithmus fixen, dann cachen.
9. Latenz und Durchsatz unterscheiden: „dauert lange" (ein Nutzer wartet) und „schafft zu wenig" (System unter Last) haben verschiedene Diagnosen und Fixes.
10. Kosten der Optimierung ehrlich bilanzieren: Komplexitätszuwachs, neue Fehlerquellen (Parallelität, Cache-Invalidierung) gegen den Gewinn stellen. 20 % schneller ist selten 3 zusätzliche Fehlerquellen wert; 20× schon eher.

**KANN:**
11. Dauerhafte Messpunkte einbauen (Timing-Logs, Metriken) für kritische Operationen — die nächste Analyse startet dann mit Daten statt bei null.
12. Performance-Budgets/Regressionstests für kritische Pfade, wenn Langsamkeit dort wiederholt einriss.

## Arbeitsablauf

1. **Ziel klären:** Operation, Last/Datenmenge, Zielwert, Priorität (Latenz oder Durchsatz?).
2. **Baseline messen:** Realistische Daten, echte Operation, Zahlen dokumentieren.
3. **Engpass lokalisieren:** Grob nach fein — erst Gesamtzeit zerlegen (DB? Netz? CPU? Warten?), dann in den größten Block hineinmessen. Übliche Verdächtige (Regel 7) abklopfen.
4. **Fix mit bestem Verhältnis wählen:** größter belegter Gewinn pro Komplexität. Eine Änderung auf einmal.
5. **Nachmessen:** Gleiche Messung, Vorher/Nachher berichten. Ziel erreicht → aufhören (Regel: gut genug ist gut genug). Nicht erreicht → zurück zu 3.
6. **Absichern:** Verhalten unverändert (Tests grün), Messpunkte ggf. dauerhaft einbauen.

## Checkliste

- [ ] Gibt es ein messbares Ziel mit Datenmenge/Last?
- [ ] Existiert eine dokumentierte Baseline-Messung?
- [ ] Ist der Engpass durch Messung belegt (nicht durch Plausibilität)?
- [ ] Habe ich die üblichen Verdächtigen (N+1, Index, seriell, Datenmenge) geprüft?
- [ ] Ist die Verbesserung nachgemessen und berichtet?
- [ ] Ist das Verhalten nachweislich unverändert (Tests)?
- [ ] Falls Cache: Ist Invalidierung definiert und getestet?

## Typische Fehler

- **Optimieren auf Verdacht:** „Die Schleife sieht teuer aus" — drei Tage Mikro-Optimierung, 2 % Gewinn; das N+1 daneben hätte 95 % gebracht.
- **Messen ohne realistische Daten:** Lokal mit 50 Zeilen „superschnell", in Produktion mit 2 Mio. Zeilen Table-Scan.
- **Cache als Pflaster:** Langsame Query gecacht statt gefixt — jetzt ist sie langsam *und* manchmal falsch.
- **Alles auf einmal:** Fünf Optimierungen in einem Diff; welche hat gewirkt, welche schadet? Unbekannt.
- **Premature Optimization:** Lesbarkeit im Neubau für hypothetische Last opfern. Erst korrekt und klar bauen, dann dort optimieren, wo Messung es verlangt.
- **Kein Abbruchkriterium:** Ziel längst erreicht, aber es wird weiter „verbessert" — jede Runde kauft weniger Gewinn für mehr Komplexität.

## Beispiele

**Gut:** Ziel: Monatsreport < 5 Min. (Ist: 40 Min., 2,1 Mio. Zeilen). Zerlegung per Timing-Log: 38 Min. DB, 2 Min. Rest. Query-Log: 44.000 Queries → N+1 auf Positionsebene belegt. Fix: Join + Batch-Load. Nachmessung: 3:40 Min. Ziel erreicht, Stopp — die verbleibende Idee („Cache über Nacht") notiert, nicht gebaut.

**Schlecht:** Gleiche Lage — String-Konkatenation in der Render-Schleife durch StringBuilder ersetzt (Bauchgefühl), Report dauert 39:50 Min. „Komisch."

## Eskalation

- Zielwert unbekannt/nicht zu bekommen → mit Auftraggeber festlegen, vorher keine Optimierungsarbeit beginnen.
- Engpass liegt außerhalb des Einflussbereichs (Fremd-API, gemeinsam genutzte DB, Netzwerk) → Messbeleg an Verantwortliche; eigene Kompensation (Parallelisierung, Caching) als Entscheidungsvorlage.
- Ziel nur mit Architekturänderung erreichbar (Read-Modell, Denormalisierung, Queue) → Entscheidungsvorlage mit Kosten/Nutzen (`skill-architecture-thinking.md`), nicht nebenbei umbauen.
- Messung erfordert Produktionszugriff/-daten → Freigabe einholen; Datenschutz beachten.

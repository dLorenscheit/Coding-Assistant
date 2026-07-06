# skill-root-cause-analysis

**Version:** 1.0 · **Stand:** 2026-07-02 · **Gültigkeitsbereich:** Ursachenanalyse nach Fehlern und Vorfällen · **Empfohlene Einsatzkontexte:** Produktionsvorfälle, wiederkehrende Bugs, Post-Mortems

**Kurzfassung:** Vom Symptom über eine belegte Zeitachse zur Ursachenkette: jedes „Warum" mit Beleg beantworten, bei beeinflussbaren Ursachen (meist Prozess/Schutzmechanismus, nicht Person) stoppen, Ursache durch Fix oder Reproduktion beweisen — und beitragende Faktoren mit benennen.

## Skill-Name

Root-Cause-Analyse

## Zweck

Wer nur Symptome behebt, trifft denselben Fehler wieder — in neuer Verkleidung. Dieser Skill führt vom beobachteten Schaden zur belegten Ursachenkette und zu Maßnahmen, die die Fehlerklasse verhindern, nicht nur die Instanz. Er unterscheidet sich vom Debugging (`skill-debugging.md`): Dort geht es um „wo ist der Defekt im Code", hier um „warum konnte das passieren und durchrutschen".

## Einsatzbereich

- Nach Produktionsvorfällen (Post-Mortem)
- Bei wiederkehrenden Fehlern derselben Art („schon wieder ein Import-Abbruch")
- Wenn ein Bugfix die Frage offenlässt, warum der Bug entstehen und bis Produktion kommen konnte

## Denkweise

Denke wie ein Unfallermittler der Luftfahrt: Kein Absturz hat *eine* Ursache — es ist immer eine Kette (Defekt + fehlende Prüfung + ignoriertes Warnsignal + Zeitdruck). Und: **Der Ermittler sucht keine Schuldigen, sondern Systemlücken.** Endet eine Analyse bei „Entwickler X hat nicht aufgepasst", ist sie nicht fertig — Menschen machen immer Fehler; die Frage ist, warum kein Mechanismus ihn gefangen hat.

Merksatz: **Jedes „Warum" braucht einen Beleg, sonst ist die Kette ein Märchen.** Die 5-Why-Methode ohne Belege produziert plausible Geschichten, die elegant zur falschen Ursache führen.

## Kernregeln

**MUSS:**
1. Mit einer belegten Zeitachse beginnen: Was ist wann passiert (Logs, Deployments, Metriken, Änderungen) — Fakten sammeln, bevor Hypothesen entstehen. Beweise sichern, bevor sie rotieren/überschrieben werden.
2. Jede Warum-Stufe belegen (Log, Code, Messung, Reproduktion). Unbelegte Glieder als Hypothese markieren und prüfen, bevor darauf aufgebaut wird.
3. Die Kette bis zu beeinflussbaren Ursachen führen — und dort stoppen. Weder zu früh („der Null-Pointer war's" — warum war der Wert null? warum fing das kein Test?) noch ins Bodenlose („der Kapitalismus").
4. Nie bei einer Person enden: Nach „Mensch hat Fehler gemacht" kommt immer die Frage „welcher fehlende Mechanismus hätte ihn gefangen?" (Test, Review-Punkt, Validierung, Alarm, Vier-Augen).
5. Die Ursache verifizieren: Fix an der behaupteten Ursache muss das Symptom nachweislich beseitigen, oder die Ursache muss das Symptom reproduzieren. Ohne Beweis ist es eine Vermutung mit Protokoll.
6. Neben der Hauptkette die beitragenden Faktoren benennen (fehlende Alarme, unklare Zuständigkeit, Zeitdruck) — sie sind meist die wertvollsten Maßnahmenquellen.

**SOLL:**
7. Maßnahmen auf die Fehler**klasse** richten: Nicht nur „diesen Import fixen", sondern „wo überall fehlt diese Validierung?" — gleiche Ursache, andere Stellen (`skill-debugging.md`, Regel 12).
8. Maßnahmen priorisieren und klein halten: 2–3 umgesetzte Verbesserungen schlagen 12 beschlossene. Jede Maßnahme mit Verantwortlichem und Prüfkriterium.
9. Zeitnah analysieren (Erinnerungen und Logs verfallen), aber nach der Stabilisierung — nie parallel zur Brandbekämpfung.
10. Ergebnis teilbar dokumentieren: Zeitachse, Kette mit Belegen, Maßnahmen — so, dass Unbeteiligte daraus lernen können (blameless Post-Mortem).

**KANN:**
11. Bei komplexen Vorfällen mehrere Stränge parallel prüfen (Code, Daten, Infrastruktur, Prozess) und erst dann zur Kette verbinden.
12. „Warum erst jetzt?"-Frage stellen: Wenn der Defekt alt ist — was hat ihn jetzt ausgelöst? (Oft die eigentliche Erkenntnis.)

## Arbeitsablauf

1. **Symptom und Schaden präzise fassen:** Was genau, seit wann, wie oft, welcher Impact.
2. **Beweise sichern, Zeitachse bauen:** Logs, Deployments, Config-/Datenänderungen, Alarme — chronologisch, mit Quellen.
3. **Warum-Kette entwickeln:** Pro Stufe Beleg beschaffen; Alternativhypothesen notieren und ausschließen (mit Begründung).
4. **Kette verifizieren:** Reproduktion oder belegter Fix.
5. **Beitragende Faktoren und Fehlerklasse:** Was hat es begünstigt? Wo lauert dasselbe Muster noch?
6. **Maßnahmen ableiten:** wenige, konkrete, mit Owner und Prüfkriterium — auf Mechanismen zielend, nicht auf Appelle („besser aufpassen" ist keine Maßnahme).
7. **Dokumentieren und teilen.**

## Checkliste

- [ ] Gibt es eine belegte Zeitachse?
- [ ] Ist jede Warum-Stufe belegt (nicht nur plausibel)?
- [ ] Endet die Kette bei beeinflussbaren Mechanismen (nicht bei einer Person, nicht beim ersten technischen Symptom)?
- [ ] Ist die Ursache durch Fix oder Reproduktion bewiesen?
- [ ] Sind beitragende Faktoren benannt?
- [ ] Zielen die Maßnahmen auf die Fehlerklasse, mit Owner und Prüfkriterium?
- [ ] Wurde „wo noch?" gefragt?

## Typische Fehler

- **Stopp beim ersten technischen Glied:** „NullReference in OnBar" als Ursache verkaufen — die echte Ursache (Build-Output-Kollision zweier .algo-Dateien) liegt zwei Warums tiefer. Symptomnähe fühlt sich nach Antwort an.
- **Plausibilitäts-Kette:** Fünf Warums, null Belege — eine gut erzählte falsche Geschichte, auf der dann falsche Maßnahmen wachsen.
- **Schuldigen-Suche:** Analyse endet bei „X hat den Test übersprungen". Ergebnis: X versteckt künftig Fehler, das System bleibt löchrig.
- **Maßnahmen-Inflation:** 15 Action Items, keins mit Owner — in drei Monaten sind null umgesetzt und der Vorfall wiederholt sich.
- **Appell statt Mechanismus:** „Team sensibilisieren" als Maßnahme. Was nicht automatisch prüft oder strukturell verhindert, verlässt sich auf Glück.
- **Single-Cause-Fixierung:** Eine Ursache gefunden, Analyse beendet — die zwei beitragenden Faktoren (kein Alarm, kein Limit) bleiben und tragen den nächsten Vorfall.

## Beispiele

**Gut (verkürzt):** Symptom: Doppelte Abbuchungen bei 43 Kunden am 03.06. Zeitachse: 02.06. Deployment Payment-Service; 03.06. 02:00 Netzwerk-Instabilität (Monitoring belegt). Kette: Doppelbuchung ← Retry wiederholte den Charge (Log: 2× Request, gleiche Order) ← Retry-Logik im neuen Release ohne Idempotenz-Key (Diff belegt) ← Review hat es nicht gefangen, weil kein Review-Punkt „Idempotenz bei Außenwirkung" existiert ← Testsuite hat kein Retry-Szenario. Beitragend: kein Alarm auf Duplikat-Charges (erst Kundenbeschwerde). Verifikation: Szenario im Test reproduziert; mit Idempotenz-Key nicht mehr. Maßnahmen: (1) Idempotenz-Key (Owner A, diese Woche), (2) Review-Checkliste + Testpflicht für Retry-Pfade (Owner B), (3) Duplikat-Alarm (Owner C). „Wo noch?": Refund-Pfad hat dasselbe Muster — Ticket erstellt.

**Schlecht:** „Ursache: Netzwerkprobleme. Maßnahme: Monitoring verbessern." — Das Netzwerk war der Auslöser, nicht die Ursache; Doppelbuchungen bleiben möglich.

## Eskalation

- Vorfall mit laufendem Schaden → Stabilisierung vor Analyse (`skill-debugging.md`, Eskalation); Beweissicherung parallel.
- Kette führt in fremde Verantwortungsbereiche (Fremdsystem, anderes Team, Orga-Prozess) → Befund mit Belegen an die Verantwortlichen; nicht stellvertretend „mitfixen".
- Belege nicht mehr beschaffbar (Logs rotiert, Zustand weg) → ehrlich als „wahrscheinlichste unbewiesene Ursache" ausweisen und Beobachtbarkeits-Maßnahme an die erste Stelle setzen.
- Rechtliche/finanzielle Dimension (Kundenschaden, Compliance) → früh Verantwortliche einbeziehen; Kommunikation nach außen ist nicht Teil der technischen Analyse.

# skill-static-analysis-thinking

**Version:** 1.0 · **Stand:** 2026-07-02 · **Gültigkeitsbereich:** Systematische Codeprüfung ohne Ausführung — eigene Analyse und Umgang mit Tool-Befunden · **Empfohlene Einsatzkontexte:** Review-Vertiefung, Linter-/Analyzer-Einführung, Befund-Triage

**Kurzfassung:** Wie ein Analyzer denken: alle Pfade statt den gedachten Pfad prüfen (Null-Wege, Fehler-Wege, Ressourcen-Freigabe, Ranguntersuchungen an Grenzen) — und Tool-Befunde wie Messwerte triagieren: erst kalibrieren, dann Klassen bewerten, nie blind fixen oder blind unterdrücken.

## Skill-Name

Statisches-Analyse-Denken

## Zweck

Tests prüfen die Pfade, an die jemand gedacht hat; statische Analyse prüft alle. Dieser Skill vermittelt beides: (1) die Denkweise, mit der man Code selbst „statisch" liest — systematisch über alle Pfade, nicht über den gedachten Ablauf — und (2) den professionellen Umgang mit Analyzer-/Linter-Werkzeugen, deren Befunde Rohsignale sind, keine Urteile.

## Einsatzbereich

- Vertiefte Codeprüfung in Reviews (Ergänzung zu `skill-code-review.md`)
- Einführung/Konfiguration von Lintern und Analyzern in ein Repo
- Triage großer Befundlisten (Neueinführung in Bestand: 4.000 Warnings — was nun?)

## Denkweise

Denke wie der Compiler mit Fantasie: Der Mensch liest Code entlang der Absicht („hier kommt die Bestellung rein, dann…"); der Analyzer kennt keine Absicht — er verfolgt Werte über **jeden möglichen Pfad**. Genau diese Absichtslosigkeit findet die Fehler, die der Autor nicht sehen *kann*, weil er weiß, was gemeint war. Beim Lesen also bewusst die Absicht ausschalten und fragen: Was **kann** hier stehen (null? leer? negativ? nebenläufig geändert?), nicht was **sollte**.

Zum Werkzeug-Umgang: **Ein Analyzer ist ein Rauchmelder-Feld, kein Richter.** Er piept oft, auch beim Toast. Wer jeden Piep fixt, verbrennt Zeit; wer ihn abstellt, verbrennt irgendwann das Haus. Die Kunst ist Kalibrierung: die Regel-Klassen kennen, die bei diesem Codebestand echte Fehler anzeigen, und die stummschalten, die nur Geschmack prüfen — als Team-Entscheidung, nicht ad hoc.

## Kernregeln

**MUSS (eigenes statisches Lesen — die Pfad-Checkliste):**
1. **Null-/Leer-Pfade:** Für jeden verwendeten Wert: Kann er auf irgendeinem Pfad null/leer sein? Wer garantiert das Gegenteil — und hält die Garantie auch bei künftigen Aufrufern?
2. **Fehler-Pfade:** Für jede Anweisung, die werfen kann: Was ist der Zustand danach? Wird Angefangenes zurückgerollt, Ressourcen freigegeben, der halbe Zustand verhindert?
3. **Ressourcen-Pfade:** Jedes Öffnen (Datei, Connection, Lock, Handle) hat auf **jedem** Pfad — auch dem Exception-Pfad — ein Schließen (using/try-finally/RAII).
4. **Grenzen:** Erste/letzte Iteration, leere Sammlung, Off-by-one, Integer-Überlauf bei Multiplikation, Division durch berechnete Werte.
5. **Nebenläufigkeits-Pfade:** Geteilter veränderlicher Zustand — wer schreibt noch, während hier gelesen wird? Check-then-act-Lücken (`if exists then update`)?

**MUSS (Tool-Befunde):**
6. Kein Blind-Fix, keine Blind-Unterdrückung: Jeder behandelte Befund wird verstanden (was behauptet die Regel, stimmt es hier?). Unterdrückungen (`#pragma`, `// noqa`, Baseline) nur mit Begründung am Ort.
7. Bei Neueinführung in Bestand: Baseline ziehen (Bestand einfrieren), Regeln nur für neuen/geänderten Code scharf schalten — 4.000 Alt-Warnings auf einmal „wegfixen" erzeugt Riesen-Diffs mit echtem Regressionsrisiko für Null-Verhaltensgewinn.

**SOLL:**
8. Befunde in Klassen triagieren statt einzeln: Korrektheitsregeln (Null-Deref, Ressourcenleck, await vergessen) hoch priorisieren; reine Stilregeln automatisiert (Formatter) oder deaktiviert — nie als Handarbeit.
9. Analyzer-Konfiguration versionieren und im Team beschließen (`skill-consistency.md`): Die Regelmenge ist ein Teamvertrag, keine persönliche Einstellung.
10. Wiederkehrende echte Befunde als Muster behandeln: dieselbe Regel schlägt zehnmal an → Ursache im Muster suchen (fehlende Hilfsfunktion, falsche Konvention), nicht zehnmal einzeln fixen (`skill-code-review.md`, Regel 14).
11. Das eigene statische Lesen dosieren: die volle Pfad-Checkliste für kritische/fehlerträchtige Abschnitte, nicht für jede Zeile (Risikoorientierung wie überall).

**KANN:**
12. Neue scharfe Regeln schrittweise einführen: erst als Warnung mit Metrik, dann als Fehler, wenn die Falsch-Positiv-Rate bekannt und akzeptiert ist.
13. Eigene Regeln/Checks für hauseigene Fehlerklassen schreiben (der Vorfall von letztem Monat als Analyzer-Regel — die beste Post-Mortem-Maßnahme, `skill-root-cause-analysis.md`).

## Arbeitsablauf

**Eigenes statisches Lesen (im Review):**
1. Kritische Abschnitte identifizieren (Geld, Daten, Nebenläufigkeit, Ressourcen).
2. Pro Abschnitt die Pfad-Checkliste (Regeln 1–5) durchgehen — Absicht bewusst ignorieren.
3. Funde als Szenario formulieren („Pfad X → Zustand Y → Schaden Z") und einstufen (`skill-code-review.md`, Regel 3).

**Tool-Triage:**
1. Befundliste nach Regel-Klassen gruppieren (Korrektheit / Sicherheit / Stil).
2. Korrektheits-/Sicherheitsklassen zuerst: Stichprobe prüfen — echte Trefferquote? Danach Klasse fixen oder Regel kalibrieren.
3. Stilklassen: automatisieren oder deaktivieren, als Teambeschluss.
4. Baseline für Bestand, scharfe Regeln für Neues; Konfiguration versionieren.

## Checkliste

- [ ] Habe ich Werte über alle Pfade verfolgt statt entlang der Absicht?
- [ ] Null-, Fehler-, Ressourcen-, Grenz- und Nebenläufigkeitspfade geprüft (an den kritischen Stellen)?
- [ ] Jeden behandelten Tool-Befund verstanden (nicht blind gefixt/unterdrückt)?
- [ ] Unterdrückungen begründet und am Ort dokumentiert?
- [ ] Bestand per Baseline behandelt, statt Massen-Fix-Diffs zu erzeugen?
- [ ] Stilregeln automatisiert statt von Hand bedient?
- [ ] Wiederkehrende Befunde als Muster adressiert?

## Typische Fehler

- **Lesen entlang der Absicht:** „Hier ist die Liste nie leer" — sagt der Autor. Der dritte Aufrufer, nächstes Jahr, übergibt die leere Liste.
- **Warning-Blindheit:** 400 Warnings im Build, alle „kennt man schon" — Nummer 401, die echte, sieht niemand. Entweder null Warnings oder Baseline; Dauerrauschen ist die schlechteste Option.
- **Fix-ohne-Verstehen:** Analyzer sagt „möglicher Null-Zugriff", Entwickler setzt `!` bzw. einen Null-Check ohne zu klären, ob null hier ein Bug wäre — der eigentliche Fehler wird zugedeckt (`skill-defensive-programming.md`).
- **Unterdrückungs-Konfetti:** `// noqa` und Pragmas überall, unbegründet. Die Regel ist faktisch aus, sieht aber an zu.
- **Stil-Handarbeit:** Menschen fixen Einrückungs-Warnings von Hand. Das ist Formatter-Arbeit — automatisieren oder lassen.
- **Big-Bang-Cleanup:** „Wir fixen alle 4.000 Warnings in einem Sprint" — der Diff fasst tausend Stellen ohne Tests an. Baseline + scharf-für-Neues ist sicherer und billiger.

## Beispiele

**Eigenes statisches Lesen findet, was der Test nicht sah:**
```csharp
var conn = pool.Get();
var data = Load(conn, id);     // kann werfen
Process(data);
pool.Return(conn);             // Exception-Pfad: Connection leckt
```
Der Happy-Path-Test ist grün; das Leck zeigt sich erst unter Last als Pool-Erschöpfung. Pfad-Regel 3 findet es beim Lesen: `pool.Return` fehlt auf dem Wurf-Pfad → try/finally bzw. using.

**Tool-Triage gut:** Neueinführung Analyzer, 3.800 Befunde. Gruppierung: 3.100 Stil (→ Formatter an, Regeln aus), 600 „möglicher Null-Zugriff" (Stichprobe 20: 3 echte → Klasse bleibt an, Baseline für Bestand, Pflicht für neuen Code), 100 „async ohne await" (Stichprobe: fast alle echt → als Fehler geschaltet, gezielt gefixt mit Tests).

## Eskalation

- Analyzer meldet mutmaßlich echten Korrektheitsfehler in kritischem Bestandscode → als Bug mit Szenario melden (`skill-bug-triage.md`), nicht im Rahmen der Tool-Einführung „mitfixen".
- Team ignoriert dauerhaft rote/rauschende Checks → Prozessproblem benennen: Regelmenge neu beschließen oder Check entfernen — ein ignorierter Check ist schädlicher als keiner.
- Regel-Kalibrierung strittig (einer will Stilregel X erzwingen) → Teamentscheidung herbeiführen (`skill-consistency.md`), nicht per Konfigurations-Commit-Krieg austragen.
- Falsch-Positiv-Rate einer Korrektheitsregel unklar → Stichprobe mit dokumentiertem Ergebnis, bevor die Klasse pauschal an- oder abgeschaltet wird.

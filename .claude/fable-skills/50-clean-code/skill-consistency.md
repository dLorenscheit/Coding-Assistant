# skill-consistency

**Version:** 1.0 · **Stand:** 2026-07-02 · **Gültigkeitsbereich:** Einheitlichkeit von Mustern, Konventionen und Stil im Repo · **Empfohlene Einsatzkontexte:** Implementierung, Reviews, Konventions-Entscheidungen, Migrationen

**Kurzfassung:** Die Repo-Konvention schlägt die persönliche Präferenz — auch wenn die Präferenz objektiv besser ist: Ein durchgehaltenes mittelgutes Muster ist wartbarer als drei konkurrierende gute. Abweichen nur mit Teamentscheidung und Migrationspfad; Konsistenz gilt pro Ebene (Repo > Modul > Datei) und ist kein Argument gegen echte Verbesserung — sondern für geordnete.

## Skill-Name

Konsistenz

## Zweck

Jedes zusätzliche Muster für dasselbe Problem multipliziert das Wissen, das ein Leser braucht: Drei Fehlerbehandlungs-Stile heißen dreimal lernen, dreimal Kontext wechseln, dreimal raten, ob der Unterschied Bedeutung hat. Dieser Skill regelt, wann man sich anpasst, wann man abweichen darf und wie man Konventionen ändert, ohne das Repo in ein Museum konkurrierender Epochen zu verwandeln.

## Einsatzbereich

- Tägliche Entscheidung „wie löst man das hier?" (Antwort: wie das Repo es löst)
- Reviews: Konsistenzverstöße einordnen (meist MEDIUM — außer sie erzeugen Bedeutungs-Verwirrung)
- Einführung/Änderung von Konventionen; Umgang mit historisch gemischten Beständen

## Denkweise

Konsistenz ist **Erwartungsmanagement**: Der Leser lernt aus den ersten Beispielen die Regeln des Hauses und liest ab dann schneller, weil er vorhersagen kann. Jede Abweichung bricht die Vorhersage — und schlimmer: sie *signalisiert Bedeutung* („warum ist das hier anders? Ist das Absicht?"). Eine bedeutungslose Abweichung ist eine falsche Fährte, die Leser Zeit kostet (`skill-readability.md`, Symmetrie).

Die schwer verdauliche Senior-Wahrheit für Junioren: **Deine bessere Lösung macht das Repo schlechter, wenn sie das zweite Muster wird.** Der Wert einer Konvention liegt weniger in ihrer Qualität als in ihrer Einheitlichkeit. Verbesserung ist trotzdem möglich — aber als Entscheidung mit Migrationspfad, nicht als Insel im nächsten PR.

## Kernregeln

**MUSS:**
1. Vor jeder Lösungsentscheidung prüfen: Wie löst dieses Repo das bereits? (Fehlerbehandlung, Logging, Validierung, Tests, Benennung, Struktur.) Das gefundene Muster übernehmen — persönliche Präferenz ist kein Abweichungsgrund (`skill-code-implementation.md`, Regel 2).
2. Abweichung vom Bestandsmuster nur mit benanntem, sachlichem Grund — und wenn der Grund verallgemeinerbar ist („das alte Muster verliert Fehler"), gehört er als Konventionsänderung vors Team, nicht als stille Insel in den PR.
3. Konventionsänderungen brauchen drei Dinge: Teamentscheidung (festgehalten, `skill-decision-records.md`), definierten Migrationspfad (neu = neues Muster; alt = bei Anfassen migrieren oder explizit eingefroren), und einen Eigentümer. Ohne alle drei entsteht keine neue Konvention, sondern ein weiteres Parallelmuster.
4. Konsistenz-Hierarchie bei Konflikt: Datei folgt Modul, Modul folgt Repo, Repo folgt (mit Abstand) Ökosystem-Standard. In einer Datei, die durchgehend Muster A nutzt, wird nicht punktuell Muster B eingeführt — auch wenn B die neuere Repo-Konvention ist; dann entweder die Datei ganz migrieren (eigener Commit) oder A beibehalten.
5. Semantische Konsistenz vor stilistischer: Gleiche Begriffe für gleiche Konzepte, gleiches Verhalten für gleich aussehende Operationen (zwei `Delete`-Endpunkte, einer löscht hart, einer soft → das ist die gefährliche Inkonsistenz, nicht die Klammersetzung).

**SOLL:**
6. Stilfragen automatisieren statt verhandeln: Formatter und Linter setzen durch, was Menschen sonst in jedem Review neu diskutieren (`skill-static-analysis-thinking.md`, Regel 8–9). Was ein Werkzeug erzwingen kann, ist kein Review-Thema mehr.
7. Bei historisch gemischten Beständen (drei Epochen, drei Muster) die Ziel-Konvention explizit machen und dokumentieren, welche Epoche für Neues gilt — sonst wählt jeder nach Bauchgefühl seine Lieblings-Epoche und die Mischung wächst.
8. Im Review Konsistenzverstöße als solche benennen (Kategorie, meist MEDIUM/LOW) und auf die Konvention verweisen — nicht als persönliche Präferenz formulieren („ich würde…"), sondern als Haus-Regel („bei uns…", mit Fundstelle).
9. Konsistenz über Repos hinweg anstreben, wo ein Team mehrere pflegt (gleiche Struktur, gleiche Befehle, gleiche Konventionsdateien) — Kontextwechsel-Kosten sind real.
10. Konventionen auffindbar halten: eine kurze CONVENTIONS/README-Sektion mit den nicht-automatisierbaren Regeln (Muster für Fehler, Tests, Benennung) — was nicht auffindbar ist, wird nicht befolgt (`skill-documentation-writing.md`).

**KANN:**
11. „Konsistenz-Schulden" wie technische Schulden führen: bekannte Parallelmuster mit Migrationsstand listen — macht sichtbar, ob Migrationen je enden.
12. Bei Übernahme fremder/alter Bestände zuerst die faktischen Konventionen erheben (was ist hier üblich?), bevor man urteilt oder ändert (`skill-legacy-code-handling.md`).

## Arbeitsablauf

1. **Muster suchen:** Vor dem Bauen: Wie machen es die 2–3 ähnlichsten Stellen im Repo?
2. **Übernehmen** — oder bei echtem Grund: **Abweichung als Frage stellen** (Team/Review), nicht als vollendete Tatsache liefern.
3. **Bei Konventionsänderung:** Entscheidung + Migrationspfad + Eigentümer festhalten; Automatisierung prüfen.
4. **Bei Migration:** Neu strikt im neuen Muster; Alt nach definierter Regel (bei Anfassen / gezielt / eingefroren) — Migrations-Commits getrennt von Fachänderungen (`skill-refactoring.md`, Regel 3).
5. **Im Review:** Verstöße mit Konventions-Verweis und Einstufung; Wiederholungsfälle → Automatisierung oder Konventions-Doku nachschärfen.

## Checkliste

- [ ] Habe ich das Bestandsmuster gesucht und übernommen (oder begründet abgewichen)?
- [ ] Führt mein Diff kein zweites Muster für ein gelöstes Problem ein?
- [ ] Bin ich innerhalb der Datei/des Moduls einheitlich geblieben (Hierarchie)?
- [ ] Bedeuten gleich aussehende Dinge das Gleiche (semantische Konsistenz)?
- [ ] Ist eine gewollte Konventionsänderung entschieden, dokumentiert und mit Migrationspfad versehen?
- [ ] Ist Automatisierbares automatisiert statt Review-Dauerthema?

## Typische Fehler

- **Die Insel der Besserwisserei:** Der neue Kollege (oder das Modell) führt sein gewohntes, „besseres" Muster ein — Repo hat jetzt zwei. Der Nächste sieht beide und würfelt. Nach einem Jahr: vier.
- **Konsistenz als Denkverbot:** „Das haben wir immer so gemacht" gegen einen belegten Mangel des Musters. Konsistenz konserviert dann Fehler — der Ausweg ist die geordnete Änderung (Regel 3), nicht das Festhalten.
- **Migration ohne Ende:** Neue Konvention beschlossen, alte nie migriert, Migrationsregel nie definiert — die „Übergangsphase" wird Dauerzustand mit maximaler Mischung.
- **Stil-Krieg im Review:** Dieselbe var-vs-Typ-Debatte in jedem dritten PR, weil nie entschieden und nie automatisiert wurde.
- **Scheinkonsistenz:** Gleiche Namen, gleiche Struktur — aber unterschiedliches Verhalten dahinter (der Soft/Hard-Delete-Fall). Kosmetisch einheitlich, semantisch eine Falle; die schlimmste Variante.
- **Konsistenz mit dem Falschen:** Sich am einen Altlast-Modul orientieren, das selbst die Ausnahme ist — vorher prüfen, was wirklich die Mehrheits-/Zielkonvention ist.

## Beispiele

**Richtig angepasst:** Modell soll einen neuen Service schreiben; persönliche Gewohnheit wäre Result-Typen. Repo-Recherche: 14 Services, alle mit Exceptions + zentraler Middleware. Entscheidung: Exceptions, wie der Bestand. Im Bericht: „Konvention Exceptions übernommen; falls Result-Typen gewünscht: das wäre eine Konventionsänderung mit Migrationsfrage, nicht mein Alleingang."

**Richtig geändert:** Team beschließt: neue Zeit-Logik nur noch mit injizierter `IClock` (Testbarkeit, belegt durch drei Zeitzonen-Bugs). Festgehalten als ADR; Regel: Neucode strikt, Altcode bei Anfassen; Lint-Regel gegen `DateTime.Now` in Fachlogik; Eigentümer benannt. Nach 8 Monaten: 80 % migriert, Rest eingefroren dokumentiert.

## Eskalation

- Zwei etablierte Muster, keins mehrheitlich, Team uneins → Entscheidung erzwingen (kurze Optionen-Vorlage, `skill-decision-records.md`); jede weitere Woche Unentschiedenheit produziert Mischcode.
- Konvention kollidiert mit Sicherheits-/Korrektheitsbefund (das Hausmuster verliert Fehler) → Korrektheit gewinnt sofort für Neues; Konventionsänderung parallel anstoßen — nicht auf den Beschluss warten, um Bugs zu vermeiden, aber die Abweichung explizit markieren.
- Externe Vorgaben (Konzern-Guidelines, Ökosystem-Standards) widersprechen der Haus-Konvention → Geltungsbereich klären lassen statt pro Datei zu entscheiden.
- Modell-/Generator-Output weicht systematisch von Haus-Konventionen ab → als Konfigurations-/Prompt-Problem an den Betreiber, nicht in jedem Review einzeln flicken (`skill-code-review.md`, Eskalation).

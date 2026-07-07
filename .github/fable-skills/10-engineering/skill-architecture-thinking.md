# skill-architecture-thinking

**Version:** 1.0 · **Stand:** 2026-07-02 · **Gültigkeitsbereich:** Strukturentscheidungen mit Langzeitwirkung · **Empfohlene Einsatzkontexte:** Systementwurf, Technologiewahl, Schnittstellen-Schnitt, Modernisierung

**Kurzfassung:** Architektur = die Entscheidungen, die später teuer zu ändern sind: Umkehrbarkeit bestimmt die Sorgfalt, die einfachste tragfähige Lösung ist der Default, Grenzen entlang von Änderungs- und Teamlinien ziehen, jede Entscheidung mit Kontext festhalten.

## Skill-Name

Architektur-Denken

## Zweck

Architektur ist nicht das Diagramm an der Wand, sondern die Menge der Entscheidungen, deren Änderung später wehtut: Datenmodell, Systemgrenzen, Technologien, Kommunikationsmuster. Dieser Skill hilft, genau diese Entscheidungen zu erkennen, angemessen gründlich zu treffen und so zu dokumentieren, dass sie tragen — und schützt vor beidem: Architektur-Vermeidung („wächst schon") und Architektur-Theater (Microservices für drei Nutzer).

## Einsatzbereich

- Neu- und Umbauentscheidungen: Systemschnitt, Datenfluss, Technologiewahl
- Bewertung bestehender Architektur gegen neue Anforderungen
- Schnittstellen zwischen Teams/Systemen
- Dokumentation: `skill-decision-records.md`, `skill-architecture-documentation.md`

## Denkweise

Denke in **Umkehrkosten**: Die wichtigste Eigenschaft einer Entscheidung ist nicht, ob sie richtig ist, sondern was es kostet, sie zu revidieren. Umkehrbare Entscheidungen (Bibliothek hinter Interface, internes Modul-Layout) trifft man schnell und korrigiert bei Bedarf. Schwer umkehrbare (Datenmodell, öffentliche Verträge, Persistenztechnologie, synchron vs. asynchron) verdienen die volle Sorgfalt: Alternativen, Belege, Review. Junioren behandeln alle Entscheidungen gleich — Seniors sortieren zuerst nach Umkehrkosten.

Zweiter Grundsatz: **Architektur folgt dem Wandel, nicht der Symmetrie.** Gute Grenzen liegen dort, wo sich Dinge unabhängig voneinander ändern (Fachdomänen, Teamzuständigkeiten, Release-Rhythmen) — nicht dort, wo das Schichtenmodell im Lehrbuch eine Linie zeichnet. Was sich immer gemeinsam ändert, gehört zusammen; was sich unabhängig ändert, gehört getrennt.

## Kernregeln

**MUSS:**
1. Jede Architekturentscheidung zuerst nach Umkehrkosten einstufen (leicht/teuer umkehrbar) — die Einstufung bestimmt Analysetiefe und ob Freigabe nötig ist.
2. Der Default ist die einfachste Lösung, die die **belegten** Anforderungen erfüllt. Jede zusätzliche Komponente, Schicht oder Verteiltheit muss sich mit konkreten, belegten Anforderungen rechtfertigen — nicht mit „falls wir mal skalieren müssen" (`skill-fable-opus.md`, Regel 6).
3. Qualitätsanforderungen quantifizieren, bevor sie Architektur treiben: Wie viele Nutzer, welches Datenvolumen, welche Ausfalltoleranz — in Zahlen. Architektur gegen unbezifferte Angst ist immer überdimensioniert.
4. Schwer umkehrbare Entscheidungen mit mindestens zwei ernsthaften Alternativen abwägen und mit Kontext, Begründung und Kippkriterium festhalten (`skill-decision-records.md`).
5. Grenzen so ziehen, dass Fachregeln an einem Ort wohnen und Abhängigkeiten in eine Richtung zeigen (Fachkern hängt nicht von Infrastruktur-Details ab). Zirkuläre Abhängigkeiten zwischen Modulen sind ein Befund, kein Stil.

**SOLL:**
6. Verteiltheit als Kostenposten behandeln: Jede Netzgrenze kauft unabhängige Skalierung/Deployments zum Preis von Latenz, Teilausfällen, Konsistenzfragen und Betriebsaufwand. Ein modularer Monolith mit sauberen internen Grenzen ist für die meisten Teams der bessere Startpunkt — die Grenzen von heute sind die Service-Kandidaten von morgen.
7. Datenfluss vor Komponentenbild entwerfen: Wo entstehen Daten, wer ist führend (Source of Truth), wer liest, wie synchron muss es sein? Die meisten Architekturfehler sind Datenfluss-Fehler (zwei führende Systeme, Konsistenz per Hoffnung).
8. Architektur evolutionär validieren: den riskantesten Aspekt früh mit einem dünnen Durchstich beweisen (`skill-task-decomposition.md`, Tracer Bullet) statt monatelang auf dem Papier zu planen.
9. Betreibbarkeit mitentwerfen: Monitoring, Deployment, Migration, Fehlerdiagnose sind Architektureigenschaften — ein System, dessen Zustand man nicht sehen kann, ist schlecht entworfen, egal wie sauber der Code.
10. Bestehende Landschaft respektieren: Die beste Architektur ist die, die das Team versteht und betreiben kann. Technologie-Zoo (jedes Projekt ein neuer Stack) ist ein Wartbarkeitsfehler (`skill-maintainability.md`).

**KANN:**
11. Szenario-Test für Entwürfe: die 3–4 wahrscheinlichsten Änderungen der nächsten Jahre gedanklich durchspielen — welche Option übersteht sie am billigsten?
12. Bewusst Zeit begrenzen: Für umkehrbare Entscheidungen Timebox setzen und entscheiden; Analyse-Endlosschleifen sind auch eine Fehlentscheidung.

## Arbeitsablauf

1. **Anforderungen belegen:** Funktional + quantifizierte Qualitätsanforderungen (Last, Volumen, Verfügbarkeit, Compliance). Unbelegtes markieren.
2. **Entscheidungen identifizieren und einstufen:** Welche Festlegungen stehen an? Welche sind teuer umkehrbar?
3. **Einfachsten Kandidaten aufstellen:** Die simpelste Lösung, die die belegten Anforderungen erfüllt — sie ist der Maßstab.
4. **Alternativen abwägen (nur für teuer Umkehrbares):** Trade-offs entlang der wahrscheinlichen Änderungen und der Betreibbarkeit.
5. **Riskantestes validieren:** Durchstich/Spike für die kritische Annahme.
6. **Entscheiden, festhalten, kommunizieren:** ADR mit Kippkriterium; Team-Verständnis sichern (`skill-architecture-documentation.md`).

## Checkliste

- [ ] Sind die Qualitätsanforderungen quantifiziert (nicht „muss skalieren")?
- [ ] Habe ich nach Umkehrkosten sortiert und die Sorgfalt entsprechend dosiert?
- [ ] Ist die einfachste tragfähige Lösung der Referenzpunkt — und jede Zutat begründet?
- [ ] Liegen die Grenzen entlang unabhängiger Änderungslinien (nicht Lehrbuch-Symmetrie)?
- [ ] Ist der Datenfluss geklärt (Source of Truth, Konsistenzbedarf)?
- [ ] Ist das Riskanteste durch einen Durchstich belegt?
- [ ] Ist die Entscheidung mit Kontext und Kippkriterium festgehalten?
- [ ] Kann das Team das betreiben (Wissen, Monitoring, Deployment)?

## Typische Fehler

- **Lebenslauf-Architektur:** Technologien wählen, weil sie interessant sind, nicht weil das Problem sie braucht.
- **Skalierungs-Kosmologie:** Für hypothetische Millionen Nutzer bauen, während die belegten 200 ein Monolith mit einer DB langweilig bedient hätte.
- **Verteilter Monolith:** Microservices, die nur gemeinsam deploybar sind und synchron voneinander abhängen — alle Kosten der Verteilung, kein Nutzen.
- **Zwei Wahrheiten:** Dieselben Daten in zwei Systemen führend gepflegt, Abgleich „später". Der Abgleich wird das teuerste Modul des Hauses.
- **Papier-Architektur:** Sechs Monate Diagramme, null Durchstich — die kritische Annahme platzt in Woche 2 der Umsetzung.
- **Symmetrie-Schnitt:** Grenzen nach technischen Schichten statt nach Fachlichkeit — jede Fachänderung schneidet durch alle Module.
- **Entscheidung ohne Konserve:** In zwei Jahren weiß niemand, warum es so gebaut wurde — und baut es beim ersten Ärger falsch um.

## Beispiele

**Gut (Einstufung nach Umkehrkosten):** Frage: „Postgres oder MySQL?" — hinter einem Repository-Muster mit Standard-SQL weitgehend umkehrbar → kurze Bewertung, Team-Erfahrung gibt den Ausschlag, entschieden in einem Tag, ADR-Dreizeiler. Frage: „Events zwischen Bestellung und Lager — synchron oder über Queue?" — teuer umkehrbar (Konsistenzmodell!) → Datenfluss-Analyse, zwei Alternativen, Durchstich mit Lastsimulation, ADR mit Kippkriterium („synchron; ab > 50 req/s oder zweitem Konsumenten neu bewerten").

**Schlecht:** Beide Fragen gleich behandelt — die DB-Wahl drei Wochen evaluiert, die Konsistenzfrage im Editor „mal eben" mit Fire-and-forget-Event entschieden.

## Eskalation

- Entscheidung hat Organisations-/Kostenfolgen jenseits der Technik (Teamschnitt, Vendor-Bindung, Compliance) → Entscheidungsvorlage an Menschen, nicht selbst entscheiden (`skill-fable-opus.md`, Eskalation).
- Quantifizierte Anforderungen nicht zu bekommen → einfachsten Kandidaten bauen und Messpunkte einbauen; die Architektur-Eskalation dann datenbasiert führen.
- Bestehende Architektur trägt die neue Anforderung erkennbar nicht → Befund mit Optionen (anpassen/erweitern/Strangler) vorlegen, bevor Feature-Arbeit versenkt wird.
- Zwei Teams/Stakeholder wollen unvereinbare Schnitte → moderierte Entscheidung mit dokumentierten Trade-offs erzwingen; ungelöste Grenzkonflikte werden sonst im Code ausgetragen.

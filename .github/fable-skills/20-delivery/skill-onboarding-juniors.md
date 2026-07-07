# skill-onboarding-juniors

**Version:** 1.0 · **Stand:** 2026-07-02 · **Gültigkeitsbereich:** Einarbeitung und Entwicklung von Junioren (und neuen Teammitgliedern) · **Empfohlene Einsatzkontexte:** Onboarding, Mentoring, Aufgabenvergabe an Unerfahrene, Review als Lehrmittel

**Kurzfassung:** Junioren wachsen an echten, sicher eingezäunten Aufgaben mit schnellem Feedback: früh produktiv arbeiten lassen (klein, real, umkehrbar), das Warum hinter jeder Korrektur erklären, Fragen belohnen statt bestrafen — Ziel ist selbstständiges Urteilen, nicht fehlerfreies Ausführen.

## Skill-Name

Junior-Onboarding und -Entwicklung

## Zweck

Wie schnell ein Junior produktiv und selbstständig wird, hängt weniger vom Junior ab als vom Onboarding: Aufgabenwahl, Feedback-Qualität, Fehlerkultur. Dieser Skill strukturiert die Einarbeitung so, dass aus Anweisungsempfängern Urteilende werden — und konserviert dabei die Denkweise dieses Skill-Systems: Entscheidungslogik explizit machen statt Ergebnisse vorgeben.

## Einsatzbereich

- Erste Wochen neuer Junioren (und sinngemäß: erfahrener Neuzugänge)
- Laufendes Mentoring: Aufgabenvergabe, Review-Feedback, Pairing
- Auch: Anleitung kleinerer KI-Modelle folgt denselben Prinzipien (klare Aufträge, sichere Zäune, Muster-Feedback — `skill-fable-haiku.md`)

## Denkweise

Denke wie ein Fahrlehrer, nicht wie ein Chauffeur und nicht wie ein Prüfer: Der Chauffeur fährt selbst („geht schneller, wenn ich es mache" — stimmt heute, kostet ein Jahr), der Prüfer bewertet nur Ergebnisse. Der Fahrlehrer lässt fahren — auf Strecken, die Fehler verzeihen — und erklärt am konkreten Moment, *warum* man hier schaltet. Das Ziel ist nicht die fehlerfreie Fahrt heute, sondern das eigenständige Urteil in sechs Monaten.

Kernmechanik: **Kompetenz wächst an der Grenze der Komfortzone, Vertrauen wächst durch kalkulierbare Fehler.** Aufgaben müssen echt sein (Übungsaufgaben motivieren nicht und lehren das Falsche), leicht zu groß (sonst kein Wachstum) und sicher eingezäunt (Fehler dürfen passieren, aber nicht explodieren: Review-Pflicht, kein Produktionszugriff allein, umkehrbare Bereiche).

## Kernregeln

**MUSS:**
1. Erste Aufgabe in Woche 1 ist eine **echte, kleine, abgeschlossene** Änderung, die es bis Produktion schafft (Bugfix, kleine Erweiterung) — nichts baut Zugehörigkeit und Systemverständnis schneller auf. Kandidaten dafür bewusst vorhalten („gute erste Bugs").
2. Sicherheitszaun statt Kontrollzwang: Fehlerfolgen begrenzen durch Struktur (Review-Pflicht für alle — nicht nur Junioren —, gestufte Rechte, umkehrbare Aufgabenbereiche), nicht durch Wegnahme echter Arbeit. Ein Junior, der nichts kaputt machen *kann*, lernt auch nichts.
3. Bei jeder Korrektur das Warum mitliefern — als Entscheidungsregel, nicht als Geschmack: „Wir validieren an der Grenze, weil innen niemand mehr weiß, was geprüft ist (siehe skill-defensive-programming)" statt „mach das so". Korrekturen ohne Warum erzeugen Cargo-Kult: Nachahmung ohne Urteilsfähigkeit.
4. Fragen aktiv belohnen: Auf „dumme" Fragen freundlich und vollständig antworten — die Alternative ist ein Junior, der drei Tage still feststeckt oder rät (`skill-fable-sonnet.md`: Unsicherheit überspielen ist das teuerste Fehlerbild, bei Menschen wie Modellen). Faustregel etablieren: 30–60 Minuten selbst versuchen, dann fragen — mit dem, was man schon herausgefunden hat.
5. Fehler des Juniors als Systemfrage behandeln: Nach jedem durchgerutschten Fehler zuerst „welcher Mechanismus hätte das gefangen?" (`skill-root-cause-analysis.md`, Regel 4) — nie öffentliches Anprangern; Fehlerkultur entscheidet, ob Probleme früh gemeldet oder versteckt werden.

**SOLL:**
6. Aufgaben mit steigendem Freiheitsgrad vergeben: erst „mach X so" (Muster lernen), dann „löse X, Vorschlag vor Umsetzung" (Urteil üben, billig korrigierbar — das Plan-Review ist das beste Lehrmittel, `skill-implementation-planning.md`), dann „verantworte Bereich X" (Selbstständigkeit).
7. Einen festen Ansprechpartner (Buddy/Mentor) benennen — „frag irgendwen" heißt für Zurückhaltende „frag niemanden".
8. Den Kontext mitgeben, nicht nur die Aufgabe: Warum gibt es dieses Ticket, wer nutzt das, was passiert bei Fehler? Junioren, die nur Tickets sehen, optimieren auf Ticket-Schließen statt auf Wirkung.
9. Dieses Skill-System als Lehrmaterial nutzen: Bei Korrekturen auf den passenden Skill verweisen (statt die Regel jedes Mal neu zu formulieren) — und Junioren die Checklisten aktiv anwenden lassen (Selbst-Review vor Abgabe).
10. Fortschritt an Urteilsfähigkeit messen, nicht an Geschwindigkeit: Gute Rückfragen, erkannte Risiken, ehrliche „bin unsicher"-Markierungen sind Fortschritt — auch wenn der Diff länger dauert.

**KANN:**
11. Pairing gezielt für Nicht-Kodierbares: Debugging-Denkweise, Review-Blick, Legacy-Erkundung — die Dinge, die in keinem Ticket stehen, überträgt man am Bildschirm nebeneinander (`skill-knowledge-transfer.md`).
12. Den Junior früh Doku schreiben lassen (Onboarding-Doku verbessern, README-Lücken): Er sieht die Lücken, die Alteingesessene nicht mehr sehen — und lernt das System beim Beschreiben.

## Arbeitsablauf

1. **Vorbereiten (vor Tag 1):** Zugänge fertig, Buddy benannt, erste echte Aufgabe reserviert, Setup-Doku aktuell (der Neue testet sie — Befund inklusive, `skill-documentation-writing.md`, Regel 3).
2. **Woche 1:** Setup + erste echte Mini-Änderung bis Produktion; Systemüberblick anhand dieser Änderung (nicht als Foliensatz).
3. **Wochen 2–8:** Aufgaben an der Komfortzonen-Grenze, Freiheitsgrad steigern; jede Korrektur mit Warum + Skill-Verweis; wöchentliches kurzes Feedback in beide Richtungen.
4. **Laufend:** Fragen-Kultur pflegen, Fortschritt an Urteilen messen, Verantwortungsbereich schrittweise übergeben.
5. **Nach ~3 Monaten:** Rückblick — was fehlt noch zur Selbstständigkeit, was hat das Onboarding selbst gelehrt (Doku-Lücken, Zaun-Lücken)?

## Checkliste

- [ ] Erreicht die erste echte Änderung in Woche 1 die Produktion?
- [ ] Sind Zäune strukturell (Review, Rechte) statt durch Arbeitsentzug?
- [ ] Bekommt jede Korrektur ihr Warum als übertragbare Regel?
- [ ] Werden Fragen belohnt (und die 30–60-Minuten-Regel gelebt)?
- [ ] Werden Fehler als Mechanismus-Lücke behandelt, nie als Anklage?
- [ ] Steigt der Freiheitsgrad der Aufgaben sichtbar?
- [ ] Messe ich Urteilsfähigkeit statt nur Durchsatz?

## Typische Fehler

- **Chauffeur-Mentoring:** Der Senior übernimmt bei jeder Schwierigkeit die Tastatur. Schnell heute, Abhängigkeit für immer.
- **Doku-Wochen:** Der Neue liest zwei Wochen Wikis, bevor er etwas anfassen darf — maximale Demotivation, minimales Lernen. System versteht man am Ticket, nicht am Handbuch.
- **Wurf ins kalte Wasser ohne Zaun:** „Hier ist der Produktionszugang, das Ticket ist dringend" — der erste große Fehler traumatisiert und lehrt vor allem Angst.
- **Korrektur ohne Regel:** Reviews voller „mach das anders" ohne Warum — der Junior lernt, den Reviewer zu imitieren statt zu urteilen; beim nächsten neuen Fall steht er wieder bei null.
- **Fragen bestrafen:** Genervtes „das steht doch im Wiki" — ab da kommen keine Fragen mehr, sondern stille dreitägige Irrwege und versteckte Unsicherheit.
- **Nur Kleinkram:** Monatelang Tippfehler-Tickets „zur Sicherheit" — kein Wachstum, und die Guten gehen.
- **Fortschritt = Geschwindigkeit:** Der Junior lernt, Unsicherheit zu verstecken, weil nur Durchsatz zählt — genau das Verhalten, das später teuer wird.

## Beispiele

**Review-Feedback als Lehre (statt Anweisung):**
> „Funktioniert — ein Punkt fürs nächste Mal: Du fängst die Exception und loggst sie, arbeitest dann aber normal weiter (Zeile 42). Regel dahinter: Ein gefangener Fehler braucht eine Entscheidung — behandeln, kompensieren, weiterreichen oder abbrechen; Log-und-weiter ist keine davon, weil der Ablauf danach auf kaputtem Zustand läuft (siehe skill-error-handling, Regel 1). Hier würde ich weiterreichen, weil der Aufrufer den Retry steuert. Magst du es umbauen und kurz sagen, welche der vier Reaktionen du gewählt hast und warum?"

Warum gut: konkrete Stelle, übertragbare Regel, Skill-Verweis, und die Urteilsfrage geht zurück an den Junior.

**Freiheitsgrad-Staffel (Beispiel):** Woche 1: „Fixe Bug X, das Muster dafür steht in PR #412." → Woche 4: „Löse Ticket Y; schreib mir vorher 5 Zeilen, wie du vorgehen willst." → Woche 10: „Der Export-Bereich gehört dir; zieh mich bei Vertrags- oder Datenfragen dazu."

## Eskalation

- Junior steckt trotz guter Betreuung wiederholt bei Grundlagen fest → ehrliches, frühes Entwicklungsgespräch mit konkreten Lernzielen — jahrelanges Durchschleppen ist unfair gegenüber allen, auch dem Junior.
- Kein zeitlicher Raum fürs Mentoring (Mentor voll verplant) → als Kapazitätsproblem an die Führung: unbetreutes Onboarding kostet mehr, als es spart — es produziert Cargo-Kult und stille Fehler.
- Junior verletzt trotz Zaun wiederholt Sicherheitsregeln (Produktionsdaten, Secrets) → Zäune technisch nachziehen (Rechte!) und klares Gespräch; hier endet die Fehlertoleranz.
- Fehlerkultur-Problem im Team (Anprangern, Schuldzuweisung) → das ist kein Junior-Thema, sondern ein Führungs-Thema — benennen, denn Onboarding kann eine toxische Kultur nicht kompensieren.

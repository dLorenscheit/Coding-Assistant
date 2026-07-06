# skill-maintainability

**Version:** 1.0 · **Stand:** 2026-07-02 · **Gültigkeitsbereich:** Wartbarkeit als Entwurfs- und Bewertungskriterium · **Empfohlene Einsatzkontexte:** Design-Entscheidungen, Technologie-Wahl, Qualitätsbewertung

**Kurzfassung:** Für die nächste Änderung optimieren: Wartbar ist, was ein Durchschnittsteam sicher und schnell ändern kann — Maßstab sind Änderungskosten (verstehen, ändern, prüfen, ausrollen), nicht Schönheit; Abhängigkeiten sind die teuerste Langzeitentscheidung.

## Skill-Name

Wartbarkeit

## Zweck

Software kostet über ihre Lebenszeit ein Vielfaches der Erstellung — in Änderungen, Fehlersuche, Einarbeitung. Dieser Skill macht Wartbarkeit von einem Gefühl („sauberer Code") zu einem prüfbaren Kriterium: **Wie schnell und wie sicher kann eine durchschnittlich besetzte Zukunft dieses System ändern?** Er leitet Entwurfsentscheidungen und ergänzt `skill-clean-code-analysis.md` (Bewertung von Bestand) um die Entwurfsperspektive.

## Einsatzbereich

- Design- und Technologieentscheidungen („was kostet uns das in 3 Jahren?")
- Bewertung von Lösungsalternativen (die wartbarere gewinnt bei Gleichstand)
- Priorisierung technischer Schulden
- Argumentationshilfe gegenüber „Hauptsache es läuft jetzt"

## Denkweise

Denke an das Team von übermorgen: **Der Code wird von Leuten gewartet werden, die nicht dabei waren — im Zweifel weniger erfahren, unter Zeitdruck, ohne dich fragen zu können.** Wartbarkeit heißt, für diese Leute zu bauen. Cleverness, die heute 20 Zeilen spart und übermorgen zwei Tage Einarbeitung kostet, ist ein Verlustgeschäft.

Rechenmodell für Junioren — Änderungskosten haben vier Posten: **Verstehen** (wo greife ich ein, was hängt dran?), **Ändern** (wie viele Stellen?), **Prüfen** (wie beweise ich, dass nichts bricht?), **Ausrollen** (wie riskant ist das Deployment?). Jede Designentscheidung verschiebt diese Posten. Wartbares Design minimiert den teuersten: fast immer das Verstehen und Prüfen.

## Kernregeln

**MUSS:**
1. Bei Designentscheidungen die Änderungskosten-Frage stellen und beantworten: „Wenn sich Anforderung X ändert (die wahrscheinlichste Änderung) — wie viele Stellen, wie viel Verstehen, wie viel Prüfaufwand?"
2. Eine Fachregel wohnt an einem Ort. Duplizierte Geschäftslogik ist der teuerste Wartbarkeitsfehler: Änderungen müssen alle Kopien finden — eine wird vergessen.
3. Jede neue Abhängigkeit (Bibliothek, Framework, Dienst) ist eine Langzeitverpflichtung und wird geprüft: Wird sie gepflegt? Wie tief verwächst sie mit dem Code? Was kostet der Ausstieg? Ungeprüfte Abhängigkeiten für Triviales (5 Zeilen selbst schreibbar) werden nicht aufgenommen.
4. Testbarkeit ist ein Designkriterium, kein Nachgedanke: Was nicht automatisiert prüfbar ist, wird bei jeder Änderung teurer und riskanter (`skill-testing-strategy.md`, Eskalation).
5. Nicht-offensichtliche Entscheidungen und Betriebswissen festhalten (Warum-Kommentare, ADRs, Runbooks) — Wissen nur in Köpfen ist ein Wartbarkeits-Totalausfall bei Personalwechsel.

**SOLL:**
6. Standardlösungen bevorzugen: das Framework-übliche Muster, die verbreitete Bibliothek, die naheliegende Struktur. Jede Eigenkreation muss gegen „das kennt der nächste Entwickler schon" antreten.
7. Für die wahrscheinliche Änderung flexibel bauen, für die hypothetische nicht: Konfigurierbarkeit und Erweiterungspunkte nur dort, wo Änderung konkret absehbar ist (`skill-abstraction-judgment.md` — YAGNI).
8. Verständlichkeit über Kompaktheit: ausgeschriebene, benannte Schritte schlagen den cleveren Einzeiler (`skill-readability.md`).
9. Alterungsposten aktiv managen: veraltete Abhängigkeiten, abgekündigte Plattformen, Sonderlocken im Build — regelmäßig sichten, nicht bis zum Zwangsupdate liegen lassen.
10. Konsistenz wahren — drei Lösungsmuster für dasselbe Problem im Repo verdreifachen das nötige Wissen (`skill-consistency.md`).

**KANN:**
11. Wartbarkeits-Metriken als Frühwarnung beobachten: Dauer der Einarbeitung, Zeit bis zum ersten produktiven Beitrag, Häufigkeit von „das traut sich keiner anzufassen"-Aussagen, Hotspots (oft geändert + oft fehlerhaft).
12. Bewusst Unwartbares zulassen, wo es billig ist: Wegwerf-Skripte, Prototypen — dann aber klar als solche markiert und außerhalb des Produktionspfads.

## Arbeitsablauf

1. **Wahrscheinliche Änderungen benennen:** Was wird sich an diesem System realistisch ändern (Fachlichkeit, Volumen, Schnittstellen)?
2. **Alternativen an Änderungskosten messen:** Für jede Option die vier Posten (verstehen/ändern/prüfen/ausrollen) für die wahrscheinlichen Änderungen durchspielen.
3. **Abhängigkeiten bilanzieren:** Pflegezustand, Verwachsungstiefe, Ausstiegskosten je neuer Abhängigkeit.
4. **Wissenssicherung einplanen:** Was muss dokumentiert werden, damit das Team von übermorgen arbeitsfähig ist?
5. **Entscheiden und festhalten:** Wahl mit Begründung (`skill-decision-records.md` bei Tragweite).

## Checkliste

- [ ] Habe ich die wahrscheinlichste Änderung benannt und die Lösung daran gemessen?
- [ ] Wohnt jede Fachregel an genau einem Ort?
- [ ] Ist jede neue Abhängigkeit geprüft (Pflege, Verwachsung, Ausstieg)?
- [ ] Ist die Lösung automatisiert prüfbar?
- [ ] Würde ein neuer Entwickler die Struktur wiedererkennen (Standard statt Eigenkreation)?
- [ ] Ist das nötige Warum-Wissen festgehalten?
- [ ] Baue ich Flexibilität nur für absehbare, nicht für hypothetische Änderungen?

## Typische Fehler

- **Wartbarkeit = Schönheit:** Code nach ästhetischem Empfinden umbauen, ohne dass eine Änderung billiger wird. Wartbarkeit misst sich an Änderungskosten, nicht an Gefallen.
- **Flexibilitäts-Falle:** „Das machen wir konfigurierbar, falls…" — die hypothetische Flexibilität kostet real bei jeder Änderung Verstehen, wird aber nie genutzt.
- **Abhängigkeits-Sammeln:** Für jedes Problem ein Paket. Drei Jahre später: 40 Abhängigkeiten, 12 unmaintained, Update-Stau blockiert das Security-Patch.
- **Framework-Verwachsung:** Geschäftslogik tief in Framework-Konstrukte verwoben — der Framework-Wechsel (kommt öfter als gedacht) wird zur Neuentwicklung.
- **Held*innen-Design:** Architektur, die nur ihr Erfinder versteht. Bus-Faktor 1 ist eingebaute Unwartbarkeit — egal wie elegant.
- **Schulden ohne Buchführung:** Abkürzungen nehmen ist legitim; sie nicht zu dokumentieren und nie zurückzuzahlen macht aus Schulden Zinsen-Zinsen.

## Beispiele

**Entscheidung an Änderungskosten:** Zwei Optionen für Preisregeln: (a) Regeln in DB-Tabelle mit generischem Interpreter, (b) Regeln als Code mit Tests. Wahrscheinlichste Änderung: 2–3 neue Regeln pro Jahr, durch Entwickler. Bewertung: (a) macht neue Regeln „ohne Deployment" möglich, aber Verstehen und Prüfen werden teuer (Interpreter debuggen, keine Tests pro Regel); (b) kostet ein Deployment pro Regel, ist aber lesbar, testbar, versioniert. Bei 2–3 Änderungen/Jahr gewinnt (b) deutlich. (a) würde erst bei täglichen Regeländerungen durch Fachanwender gewinnen — die sind nicht absehbar → YAGNI.

**Abhängigkeits-Prüfung:** Bibliothek für Feiertagsberechnung: letzter Commit vor 4 Jahren, 30 offene Issues → stattdessen die 40 relevanten Feiertage als gepflegte Tabelle im Repo. Weniger „elegant", aber wartbar.

## Eskalation

- Wartbarkeit konkurriert mit Termin (Abkürzung nötig) → Abkürzung explizit machen: was wird geopfert, was kostet die Rückzahlung, wer entscheidet. Schulden buchen (`skill-decision-records.md`), nicht verschweigen.
- Bus-Faktor 1 auf kritischem System erkannt → melden und Wissenssicherung priorisieren lassen (`skill-knowledge-transfer.md`).
- Zentrale Abhängigkeit stirbt (unmaintained, abgekündigt) → als Risiko mit Zeithorizont und Migrationsoptionen vorlegen (`skill-risk-analysis.md`), nicht auf den Zwangsmoment warten.
- Team uneins über Standardmuster → Entscheidung herbeiführen statt parallel zu bauen (`skill-consistency.md`).

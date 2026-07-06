# skill-technical-explanations

**Version:** 1.0 · **Stand:** 2026-07-02 · **Gültigkeitsbereich:** Mündliches und schriftliches Erklären technischer Sachverhalte · **Empfohlene Einsatzkontexte:** Junior-Erklärungen, Stakeholder-Kommunikation, Incident-Berichte, Konzeptvorstellungen

**Kurzfassung:** Beim Adressaten anfangen, nicht beim Thema: erst das Zielbild/Modell („was ist das, wozu"), dann Details in Schichten nach Bedarf; konkretes Beispiel vor abstrakter Regel, Fachbegriffe beim ersten Auftreten verankern, Tiefe an Zuhörer und Zweck koppeln — verstanden hat man erst, wenn der andere es korrekt weitererzählen kann.

## Skill-Name

Technische Erklärungen

## Zweck

Erklären ist Kernarbeit: an Junioren (Wissenstransfer), an Entscheider (Grundlage für Entscheidungen), an Fachbereich und Support (Betriebsfähigkeit). Schlechte Erklärungen kosten doppelt — die Zeit des Erklärens und die Folgen des Missverstehens. Dieser Skill macht Erklären zum Handwerk: adressatengerecht, geschichtet, überprüfbar.

## Einsatzbereich

- Junioren etwas beibringen (`skill-onboarding-juniors.md`, Regel 3)
- Nicht-Technikern technische Sachverhalte/Entscheidungen vermitteln (inkl. Management)
- Incident-/Analyse-Ergebnisse berichten (`skill-root-cause-analysis.md`, Regel 10)
- Schriftliche Erklär-Doku (`skill-documentation-writing.md`, Typ „Erklärung")

## Denkweise

Der Fluch des Wissens ist der Gegner: **Wer etwas versteht, kann sich nicht mehr vorstellen, es nicht zu verstehen** — und erklärt deshalb von innen (Implementierung, Historie, Details) statt von außen (was ist das, wozu dient es, was ändert sich für dich). Die Disziplin heißt: vor jeder Erklärung explizit fragen — was weiß diese Person schon, was will sie mit der Information tun, was ist das Minimum, das dafür reicht?

Bauprinzip: **Erst das Gerüst, dann die Steine.** Menschen verstehen Details nur, wenn sie ein Modell haben, an das sie sie hängen können. Deshalb: zuerst ein tragfähiges (auch vereinfachtes) Gesamtbild — „im Kern macht das System X" — und dann Schichten nachlegen, wo der Zuhörer sie braucht. Eine bewusste Vereinfachung, die später verfeinert wird, ist kein Lügen — sie ist Didaktik. (Kennzeichnen: „vereinfacht gesagt…") Gefährlich ist nur die Vereinfachung, die falsche Entscheidungen erzeugt.

## Kernregeln

**MUSS:**
1. Adressat vor Inhalt: Vorwissen, Ziel und Entscheidungsbedarf des Zuhörers klären (notfalls fragen: „Was weißt du schon über X? Wofür brauchst du das?") — dieselbe Sache wird dem Junior, dem PO und dem Betrieb verschieden erklärt.
2. Mit dem Zielbild beginnen: ein Satz „Was ist das und wozu" vor jedem Detail. Wer nach 30 Sekunden nicht weiß, worüber gesprochen wird und warum es ihn betrifft, hört nicht mehr zu (`skill-documentation-writing.md`, Regel 2 — gilt mündlich genauso).
3. Konkret vor abstrakt: ein durchgespieltes Beispiel („Kunde Müller bestellt, dann passiert…") vor der allgemeinen Regel. Abstraktionen versteht man als Zusammenfassung von Beispielen — nicht umgekehrt.
4. Fachbegriffe beim ersten Auftreten in einem Halbsatz verankern oder weglassen: Jeder unverstandene Begriff kostet Zuhörer — und die wenigsten fragen nach (`skill-onboarding-juniors.md`, Fragen-Kultur).
5. Verständnis prüfen statt annehmen: Am Ende zurückspielen lassen („Wie würdest du es Kollegin Y erklären?") oder eine Anwendungsfrage stellen. Nicken ist kein Beleg — die Empfangsschleife aus `skill-handover.md` (Regel 3) gilt für jede wichtige Erklärung.

**SOLL:**
6. Bei Entscheider-Erklärungen die Struktur umdrehen: Ergebnis/Empfehlung zuerst, dann Begründung, Details nur auf Nachfrage — Entscheider brauchen Konsequenzen und Optionen, nicht Funktionsweise („Das kostet uns pro Woche X; Optionen A oder B; ich empfehle A, weil…").
7. Analogien gezielt und mit Verfallsdatum einsetzen: Eine gute Analogie öffnet die Tür („der Cache ist wie ein Notizzettel neben dem Archiv"), aber sagen, wo sie endet — Zuhörer bauen sonst auf der Analogie weiter, wo sie nicht mehr trägt.
8. Vereinfachungen kennzeichnen und schichten: „Vereinfacht: X. Für deinen Fall relevant wird die Ausnahme Y" — so bleibt das Gerüst ehrlich erweiterbar.
9. Bei „Warum ist das so?"-Fragen die echte Begründung geben (Zwänge, Historie, Trade-off — ggf. ADR verlinken, `skill-decision-records.md`) statt Autoritätsantworten („ist Standard", „war schon immer so").
10. Erklär-Länge am Ziel ausrichten: Wenn der Zuhörer nur eine Entscheidung braucht, ist die 20-Minuten-Herleitung Selbstzweck. Tiefe anbieten, nicht aufzwingen („soll ich zeigen, wie das intern läuft?").

**KANN:**
11. Skizzen nutzen, sobald mehr als drei Dinge in Beziehung stehen — ein Kasten-Pfeil-Bild schlägt fünf Minuten verbaler Topologie.
12. Wiederkehrende Erklärungen (dritte Person fragt dasselbe) verschriftlichen (`skill-documentation-writing.md`, FAQ) — Erklären skaliert nicht, Doku schon.

## Arbeitsablauf

1. **Adressat klären:** Vorwissen? Ziel? Entscheidung nötig?
2. **Kernbotschaft bestimmen:** Der eine Satz, der bleiben muss, wenn alles andere vergessen wird.
3. **Gerüst geben:** Zielbild/Modell in 1–3 Sätzen (bei Entscheidern: Empfehlung zuerst).
4. **Mit Beispiel füllen:** ein konkreter Durchlauf; Begriffe verankern.
5. **Schichten anbieten:** Tiefe nach Bedarf, Vereinfachungen gekennzeichnet.
6. **Verständnis prüfen:** zurückspielen lassen; Lücken sofort schließen; bei Wiederholungsbedarf verschriftlichen.

## Checkliste

- [ ] Weiß ich, was der Adressat weiß und wofür er die Erklärung braucht?
- [ ] Beginne ich mit Zielbild/Kernbotschaft (bzw. Empfehlung bei Entscheidern)?
- [ ] Kommt ein konkretes Beispiel vor der abstrakten Regel?
- [ ] Ist jeder Fachbegriff verankert oder gestrichen?
- [ ] Sind Vereinfachungen als solche gekennzeichnet?
- [ ] Habe ich Verständnis geprüft statt Nicken gezählt?
- [ ] Habe ich Tiefe angeboten statt aufgezwungen?

## Typische Fehler

- **Innen-nach-außen-Erklärung:** Mit der Datenbankstruktur beginnen, wenn die Frage „warum dauert der Report so lange?" war. Der Zuhörer wollte eine Antwort, keine Architektur-Tour.
- **Fluch-des-Wissens-Tempo:** Drei implizite Konzepte pro Satz. Der Zuhörer steigt bei Konzept zwei aus und nickt ab da höflich.
- **Abstraktions-Einstieg:** „Das ist im Prinzip ein idempotenter, eventgetriebener Prozess…" — ohne Beispiel hängt die Aussage im Leeren.
- **Analogie-Überdehnung:** Die Notizzettel-Analogie fürs Cache-Invalidierungsproblem weiterreiten, bis der Zuhörer falsche Schlüsse zieht.
- **Detail-Beweisführung vor Entscheidern:** 15 Folien Herleitung, Empfehlung auf Folie 16 — die Entscheidung fällt in den ersten zwei Minuten, mit oder ohne dich.
- **Verständnis unterstellen:** „Alles klar?" — „Ja." Drei Tage später zeigt die Umsetzung: nichts war klar. Prüffrage statt Höflichkeitsfrage.
- **Herablassung:** Übertriebenes Vereinfachen bei kompetentem Publikum („also, ein Server ist…") — kostet Respekt und Zeit. Adressaten-Klärung schützt in beide Richtungen.

## Beispiele

**Dieselbe Sache, drei Adressaten (Doppelbuchungs-Bug):**
> **Junior:** „Kern des Problems: Unser Retry wiederholt den Zahlungsaufruf, aber der Aufruf ist nicht idempotent — gleiche Anfrage, doppelte Wirkung. Vereinfacht: Wenn du zweimal auf ‚Senden' drückst, gehen zwei Briefe raus, weil niemand prüft, ob der Brief schon weg ist. Schau dir an, wie der Idempotenz-Key im Fix das verhindert — das Muster brauchst du bei jeder Operation mit Außenwirkung (skill-defensive-programming, Regel 4)."
> **PO:** „43 Kunden wurden doppelt belastet, Ursache gefunden und behoben, Rückerstattungen laufen heute. Empfehlung: eine Woche erhöhtes Monitoring, dann Normalbetrieb. Risiko einer Wiederholung: gering, weil der Fehlertyp jetzt automatisch geprüft wird."
> **Betrieb:** „Neuer Alarm ‚duplicate-charge' im Payment-Dashboard; wenn er anschlägt: Runbook Abschnitt 4, zuerst Retry-Queue anhalten."

Ein Sachverhalt, drei Kernbotschaften — je nachdem, was der Adressat damit *tun* muss.

## Eskalation

- Der Adressat braucht die Erklärung für eine Entscheidung, aber es fehlen dir Fakten → keine Plausibilitäts-Lücken füllen: Wissenslücke benennen und Beschaffung anbieten (`skill-fable-sonnet.md`, Regel 6 — gilt beim Erklären doppelt, weil Zuhörer Gesagtes als gesichert weitertragen).
- Wiederholtes Nicht-Verstehen trotz mehrerer Anläufe → Format wechseln (Skizze, Pairing, schriftlich) statt lauter/langsamer dasselbe; wenn es strukturell ist (fehlende Grundlagen), Lernpfad statt Einzelerklärung (`skill-onboarding-juniors.md`).
- Vereinfachung droht entscheidungsrelevant falsch zu werden („dann ist das ja easy, machen wir in 2 Tagen") → sofort nachschärfen — lieber die Komplexität zumuten als eine bequeme Fehlentscheidung ernten.
- Erklärung wird politisch (Schuldfragen im Incident-Bericht) → bei Fakten und Mechanismen bleiben (`skill-root-cause-analysis.md`, blameless); Zuschreibungen sind nicht dein Mandat.

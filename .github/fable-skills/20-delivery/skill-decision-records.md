# skill-decision-records

**Version:** 1.0 · **Stand:** 2026-07-02 · **Gültigkeitsbereich:** Festhalten tragweitiger Entscheidungen (ADRs u. ä.) · **Empfohlene Einsatzkontexte:** Architektur-/Technologie-Entscheidungen, Konventionen, bewusste Abkürzungen, Nicht-Entscheidungen

**Kurzfassung:** Jede schwer umkehrbare oder wiederkehrend diskutierte Entscheidung bekommt einen kurzen Record: Kontext (Problem, Zwänge), erwogene Optionen, Entscheidung mit Begründung, Konsequenzen inkl. Nachteilen, Kippkriterium — geschrieben in Minuten, gelesen über Jahre; das Warum ist das einzige, was der Code nicht speichert.

## Skill-Name

Entscheidungs-Dokumentation (Decision Records)

## Zweck

In zwei Jahren fragt jemand: „Warum ist das so gebaut?" Ohne Record gibt es drei Antworten — niemand weiß es (und baut es beim ersten Ärger falsch um), Legenden („das musste wegen X", stimmt nicht), oder Archäologie in Chat-Verläufen. Decision Records konservieren das Warum: billig im Moment der Entscheidung, unbezahlbar später. Sie beenden außerdem Endlos-Diskussionen: Was entschieden und dokumentiert ist, wird nicht pro PR neu verhandelt (`skill-consistency.md`, Regel 3).

## Einsatzbereich

- Architektur- und Technologie-Entscheidungen (`skill-architecture-thinking.md`, Regel 4)
- Team-Konventionen (Fehlerbehandlung, Teststrategie, Benennungs-Glossar)
- Bewusste Abkürzungen/Schulden („wir verzichten vorerst auf X, weil…")
- Bewusste Nicht-Entscheidungen („wir bleiben bei Y, obwohl Z diskutiert wurde")

## Denkweise

Schreibe für den **Nachfolger mit Umbau-Absicht**: Er steht vor deiner Entscheidung, sie stört ihn gerade, und er fragt: Darf ich das ändern? Der Record gibt ihm, was er braucht: die damaligen Zwänge (gelten sie noch?), die verworfenen Alternativen (seine „neue Idee" war vielleicht Option B — warum fiel sie durch?), und das Kippkriterium (unter welchen Umständen wäre die Entscheidung heute anders?). Ein guter Record macht Entscheidungen **revidierbar statt heilig**: Er schützt nicht die Entscheidung, sondern die Qualität ihrer Revision.

Deshalb der wichtigste Ehrlichkeits-Grundsatz: **Konsequenzen enthalten auch die Nachteile.** Ein Record, der nur Vorteile listet, ist Werbung — der Nachfolger merkt die verschwiegenen Kosten sowieso, und ab da glaubt er keinem Record mehr.

## Kernregeln

**MUSS:**
1. Record-Pflicht bei: schwer umkehrbaren Entscheidungen (Datenmodell, öffentliche Verträge, Technologie), Konventionen mit Migrationsfolgen, bewusst eingegangenen Schulden, und allem, was zum zweiten Mal grundsätzlich diskutiert wird.
2. Feste Minimalstruktur, kurz gehalten (½–1 Seite): **Titel + Datum + Status** (vorgeschlagen/akzeptiert/abgelöst-durch) · **Kontext** (Problem, Zwänge, Zahlen — was war damals wahr?) · **Optionen** (die ernsthaft erwogenen, je 1–2 Sätze mit Ablehnungsgrund) · **Entscheidung** (was, mit tragender Begründung) · **Konsequenzen** (positive *und* negative, inkl. eingegangener Schulden) · **Kippkriterium** (was würde die Entscheidung heute ändern?).
3. Ehrlich schreiben: reale Ablehnungsgründe (auch „Team kennt X nicht", „Budget"), reale Nachteile. Politisch geglättete Records sind wertlos.
4. Im Repo ablegen (z. B. `docs/decisions/NNN-titel.md`), versioniert, von den betroffenen Stellen aus verlinkt (`skill-documentation-writing.md`, Regel 5). Entscheidungen in Chat/Mail/Meetingprotokollen gelten als nicht dokumentiert.
5. Records nie umschreiben, sondern ablösen: Eine revidierte Entscheidung bekommt einen neuen Record, der alte den Status „abgelöst durch NNN" — die Geschichte der Entscheidungen ist selbst Wissen.

**SOLL:**
6. Zeitnah schreiben (am Tag der Entscheidung): Nach zwei Wochen sind die verworfenen Optionen und echten Gründe schon Rekonstruktion.
7. Den Entscheidungsträger benennen (wer hat entschieden — Team-Konsens, Architekt, Management-Vorgabe?) — für den Nachfolger ist relevant, mit wem eine Revision zu klären wäre.
8. Records als Review-Referenz nutzen: Wenn ein PR gegen einen Record verstößt, ist der Verweis das Review-Argument — und wenn der Record veraltet wirkt, ist das der Anstoß für seine geordnete Ablösung statt für stille Erosion.
9. Auch „klein aber ewig" dokumentieren: das Benennungs-Glossar, die Zeitzonen-Strategie, die Fehlerformat-Konvention — Kleinigkeiten mit jahrelanger Wirkung.

**KANN:**
10. Einen Index führen (Liste aller Records mit Einzeiler) für Auffindbarkeit — besonders ab ~20 Records.
11. Bei strittigen Entscheidungen die Entscheidungsvorlage (Optionen + Empfehlung, `skill-fable-opus.md`, Regel 5) direkt als Record-Entwurf schreiben — nach der Entscheidung nur Status und Ergebnis nachtragen.

## Arbeitsablauf

1. **Auslöser erkennen:** Fällt gerade eine Record-pflichtige Entscheidung (Regel 1)? Dann jetzt schreiben, nicht „später".
2. **Kontext einfrieren:** Problem, Zwänge, Zahlen von heute — so, dass ein Fremder die Lage versteht.
3. **Optionen mit Ablehnungsgründen** notieren (die 2–4 ernsthaften, keine Strohmänner).
4. **Entscheidung, Konsequenzen (beidseitig), Kippkriterium** formulieren.
5. **Ablegen, verlinken, Status setzen;** bei Konventionen: Migrationspfad dazu (`skill-consistency.md`, Regel 3).
6. **Bei Revision:** neuen Record schreiben, alten ablösen, Verweiskette pflegen.

## Checkliste

- [ ] Ist der Auslöser Record-pflichtig — und schreibe ich zeitnah?
- [ ] Enthält der Kontext die damaligen Zwänge und Zahlen (nicht nur „wir brauchten X")?
- [ ] Sind die verworfenen Optionen mit echten Gründen drin?
- [ ] Stehen die Nachteile/Schulden in den Konsequenzen?
- [ ] Gibt es ein Kippkriterium?
- [ ] Liegt der Record im Repo und ist von den betroffenen Stellen verlinkt?
- [ ] Ist bei Revision die Ablöse-Kette sauber (kein Umschreiben)?

## Typische Fehler

- **Entscheidung ohne Record:** „Das haben wir doch damals besprochen" — wo? Chat von vor 14 Monaten. Der Neue baut es um, das Ticket von damals wiederholt sich.
- **Record als Roman:** Acht Seiten Analyse — schreibt sich in Stunden, liest niemand. Die halbe Seite mit Kippkriterium schlägt das Gutachten.
- **Werbe-Record:** Nur Vorteile, keine Kosten. Der erste Leser, der die verschwiegene Konsequenz erlebt, misstraut ab da allen Records.
- **Strohmann-Optionen:** Zwei absichtlich schwache Alternativen neben dem Favoriten. Der Nachfolger merkt es — und die eigentlich starke Option C fehlt komplett.
- **Nachträgliche Kosmetik:** Record umgeschrieben, damit die Entscheidung klüger aussieht. Versionierung deckt es auf; Vertrauen weg.
- **Record-Friedhof:** Records geschrieben, nie verlinkt, nie im Review referenziert — sie existieren, wirken aber nicht. Wirkung entsteht durch Verweis am Ort der Reibung.
- **Heiligsprechung:** „Steht im ADR, Diskussion beendet" — auch wenn das Kippkriterium längst erfüllt ist. Records sollen Revision strukturieren, nicht verhindern.

## Beispiele

**Kompakter Record (verkürzt):**
> **ADR-014 · 2026-07-02 · Status: akzeptiert**
> **Titel:** Mahnwesen als eigenes Modul, synchron auf invoicing-API
> **Kontext:** Mahnlogik wächst (3 Tickets/Quartal), steckt in `invoicing` und destabilisiert dort Releases. Team: 4 Personen, ein Deployment. Kein unabhängiger Skalierungsbedarf (max. 2k Mahnungen/Nacht).
> **Optionen:** (a) In invoicing belassen — abgelehnt: divergente Änderungsgründe, Release-Kopplung bleibt. (b) Eigener Service mit Queue — abgelehnt: Betriebsaufwand + Konsistenzfragen ohne Skalierungsbedarf. (c) Eigenes Modul im Monolith, Zugriff nur über invoicing-Tür — **gewählt**.
> **Konsequenzen:** + unabhängige Fachänderungen, klarer Besitz. − zusätzliche interne API zu pflegen; Nachtjob-Laufzeit steigt um ~10 %.
> **Kippkriterium:** Zweites Team übernimmt Forderungsmanagement, oder Mahnvolumen > 50k/Nacht → Option (b) neu bewerten.
> **Entscheider:** Team-Konsens, 01.07., anwesend A/B/C.

**Schulden-Record (Kurzform):** „ADR-015: Wir verzichten bis Q4 auf Idempotenz im Refund-Pfad (Aufwand 4 PT, aktuell 0 Retries/Monat gemessen). Risiko akzeptiert von PO am 02.07. Kippkriterium: erster Duplikat-Refund oder Einführung von Auto-Retry." — Vier Zeilen, und aus einer stillen Abkürzung wird eine gemanagte (`skill-maintainability.md`, Eskalation).

## Eskalation

- Entscheidung wird gefordert, aber niemand will sie verantworten („macht ihr mal") → Entscheidungsvorlage schreiben und explizit einen Entscheider einfordern; ein Record ohne Träger ist bei der ersten Krise wertlos.
- Record-Verstoß im Review, aber der Autor hält den Record für veraltet → nicht im PR klären: Kippkriterium prüfen, ggf. Ablöse-Record anstoßen — bis dahin gilt der bestehende.
- Entscheidung von oben ohne Begründung („Konzern sagt Technologie X") → trotzdem Record schreiben: Kontext = Vorgabe, Optionen = keine. Auch das ist für den Nachfolger Gold: Er weiß, dass es keine technische Begründung gab.
- Zwei Records widersprechen sich → sofort auflösen (einer löst ab), nicht koexistieren lassen.

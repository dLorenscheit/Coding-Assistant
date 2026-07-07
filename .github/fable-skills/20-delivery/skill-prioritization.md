# skill-prioritization

**Version:** 1.0 · **Stand:** 2026-07-02 · **Gültigkeitsbereich:** Reihenfolge-Entscheidungen über Aufgaben, Features, Schulden, Bugs · **Empfohlene Einsatzkontexte:** Backlog-Pflege, Sprint-/Wochenplanung, Krisensituationen, Schuldenabbau

**Kurzfassung:** Priorisieren heißt Nein sagen mit System: Wert, Aufwand, Risiko und Verzögerungskosten pro Kandidat grob bewerten, Reihenfolge daraus ableiten statt aus Lautstärke oder Reihenfolge des Eingangs — und transparent machen, was dafür NICHT getan wird; alles ist Prio 1 = nichts ist Prio 1.

## Skill-Name

Priorisierung

## Zweck

Kapazität ist immer knapper als Wünsche. Ohne explizite Priorisierung entscheidet der Zufall (wer zuletzt fragte, was gerade brennt, was Spaß macht) — und die wichtigste Arbeit verliert gegen die lauteste. Dieser Skill liefert ein leichtgewichtiges, ehrliches Verfahren für Reihenfolge-Entscheidungen und für das, was dazugehört: das begründete Nein.

## Einsatzbereich

- Backlog- und Wochenplanung; Bug-vs-Feature-vs-Schulden-Abwägung
- Kapazitätskonflikte („alles bis Freitag") und Scope-Verhandlung (`skill-project-planning.md`, Regel 9)
- Priorisierung technischer Arbeit gegenüber Nicht-Technikern (Argumentationshilfe)

## Denkweise

Priorisierung ist eine **Investitionsentscheidung unter Unsicherheit**: Jede Stunde, die in A fließt, fließt nicht in B — die eigentliche Frage ist nie „ist A wichtig?" (fast alles ist irgendwie wichtig), sondern „ist A wichtiger als das beste B, das dafür liegen bleibt?" Wer nur den Wert des Gewählten betrachtet und nie die Kosten des Verdrängten, priorisiert nicht — er sammelt Zusagen.

Zweites Werkzeug: **Verzögerungskosten** („Cost of Delay") als Denkfigur. Nicht alles Wertvolle ist eilig: Manche Aufgaben kosten pro Woche Verzögerung viel (auslaufende Frist, blutende Fehlerquelle, blockiertes Team), andere fast nichts (wertvoll, aber zeitstabil). Reihenfolge gehört den Dingen, die durch Warten teuer werden — nicht automatisch den größten.

## Kernregeln

**MUSS:**
1. Vergleichbar bewerten: Pro Kandidat grob (hoch/mittel/niedrig) erfassen: **Wert** (für wen, wie viel?), **Aufwand** (Spanne, `skill-estimation.md`), **Risiko des Unterlassens** (was passiert, wenn nicht/später?), **Verzögerungskosten** (wird es durch Warten teurer?). Ohne diese vier ist jede Reihenfolge Bauchgefühl mit Nummerierung.
2. Eine echte Rangfolge erzeugen, kein Prioritäts-Inflations-Schema: Wenn 15 Dinge „Prio 1" sind, existiert keine Priorisierung — die Rangfolge muss Verdrängung ausdrücken (1 vor 2, auch wenn beide wichtig sind).
3. Das Verdrängte sichtbar machen: Jede Zusage nennt, was dafür liegen bleibt („A diese Woche heißt: B rutscht auf übernächste"). Der Entscheider entscheidet über den Tausch, nicht über den Wunsch.
4. Blockierendes vor Großem: Was andere (Menschen, Teams, Abläufe) entsperrt — Reviews, Freigaben, Antworten, der kleine Fix, auf den drei warten — schlägt die eigene große Aufgabe. Durchsatz des Systems vor Auslastung des Einzelnen.
5. Dringend von wichtig trennen: Dringendes mit niedrigem Wert (das lauteste Ticket) darf Wichtiges mit stillem Verfall (die Sicherheitslücke, der Datenqualitäts-Drift) nicht dauerhaft verdrängen. Wer nur noch reagiert, eskaliert das als Kapazitätsproblem.

**SOLL:**
6. Technische Arbeit (Schulden, Infrastruktur) in derselben Währung argumentieren wie Features: konkrete Folgekosten des Unterlassens („jede Woche 2× Produktionsstörung à 3 h") statt „müsste man mal" — sonst verliert sie jede Priorisierungsrunde (`skill-clean-code-analysis.md`, ökonomische Gewichtung).
7. Reihenfolge-Effekte nutzen: Erkenntnisbringer vorziehen (was gelernt wird, verbessert alle weiteren Entscheidungen — Spikes, Piloten, Risiko-Validierung), Verfallsdaten beachten (Angebote, Fristen, verfügbare Schlüsselpersonen).
8. Klein-vor-groß bei ähnlichem Wert: Zwei fertige kleine Dinge schlagen ein halbfertiges großes — Halbfertiges hat Wert null und bindet Kopf (`skill-task-decomposition.md`).
9. Priorisierungs-Entscheidungen kurz begründen und stehen lassen: ständiges Umpriorisieren (jede Woche neue Nr. 1) zerstört mehr Wert als jede falsche Reihenfolge — Wechselkosten sind real.
10. Regelmäßig aussortieren: Was seit Monaten unten liegt, ehrlich schließen (`skill-bug-triage.md`, Regel 10) — ein 400-Einträge-Backlog ist kein Plan, sondern ein schlechtes Gewissen mit Suchfunktion.

**KANN:**
11. WSJF-Kurzform für strittige Fälle: Verzögerungskosten ÷ Aufwand als Sortierhilfe — grob genug, um schnell zu sein, strukturiert genug, um Diskussionen zu erden.
12. Kapazität explizit aufteilen (z. B. X % Wartung/Schulden, Y % Neues) — nimmt die Dauerverhandlung aus den Einzelfällen.

## Arbeitsablauf

1. **Kandidaten sammeln** (inkl. der unbequemen: Schulden, Risiken, Wartung).
2. **Vier Größen grob bewerten** (Wert, Aufwand, Unterlassungsrisiko, Verzögerungskosten).
3. **Rangfolge bilden:** Verzögerungskosten und Entsperr-Effekte zuerst gewichten; klein-vor-groß bei Gleichstand.
4. **Tausch sichtbar machen:** Was verdrängt die neue Reihenfolge? Entscheider bestätigen lassen.
5. **Kommunizieren:** Rangfolge + Ein-Satz-Begründung; Neins aussprechen (siehe Beispiele).
6. **Periodisch prüfen, selten umwerfen:** Neue Information ja, Nervosität nein.

## Checkliste

- [ ] Habe ich alle vier Größen pro Kandidat (nicht nur den Wert des Lieblingsprojekts)?
- [ ] Drückt die Rangfolge echte Verdrängung aus (keine 15 Prio-1)?
- [ ] Ist sichtbar, was liegen bleibt — und hat der Entscheider den Tausch bestätigt?
- [ ] Sind Blocker anderer vor eigener Großarbeit einsortiert?
- [ ] Verdrängt Dringend-Lautes nicht dauerhaft Wichtig-Stilles?
- [ ] Ist technische Arbeit in Folgekosten argumentiert?
- [ ] Wird die Reihenfolge stabil gehalten (Wechsel nur bei neuer Information)?

## Typische Fehler

- **Lautstärke-Priorisierung:** Wer am häufigsten nachfragt, gewinnt. Die stillen wichtigen Dinge (Sicherheit, Datenqualität, Bus-Faktor) verlieren strukturell (`skill-bug-triage.md`).
- **Ja-Sammeln:** Jede Anfrage wird „eingeplant", nichts wird verdrängt — die Rangfolge existiert nur rhetorisch, real entscheidet dann doch der Zufall.
- **FIFO als Fairness:** Der Reihe nach abarbeiten fühlt sich gerecht an und ignoriert Verzögerungskosten komplett.
- **Lieblingsarbeit zuerst:** Das Interessante vor dem Wirksamen — menschlich, teuer, und mit den vier Größen sofort sichtbar.
- **Prioritäts-Ping-Pong:** Montag Nr. 1 ist Mittwoch Nr. 4 — jedes Umschalten kostet Rüstzeit und demoralisiert; nach drei Wechseln glaubt niemand mehr an Prioritäten.
- **Neins vermeiden:** Statt „nein, weil B wichtiger" ein „kommt bald" — erzeugt Zusagen-Schulden und zerstört die Glaubwürdigkeit jeder künftigen Priorisierung.
- **Aufwand als Prio-Ersatz:** „Machen wir zuerst, ist ja klein" — für Kleinkram gilt das (klein-vor-groß), als Dauerprinzip führt es dazu, dass das Wichtige nie drankommt.

## Beispiele

**Vier-Größen-Vergleich (Wochenplanung, verkürzt):**
> A: Kundenwunsch Export-Filter — Wert mittel, Aufwand klein, Unterlassungsrisiko niedrig, Verzögerungskosten niedrig.
> B: Flaky-Testsuite stabilisieren — Wert hoch (Team drückt bei echten Fehlern auf Retry!), Aufwand mittel, Unterlassungsrisiko hoch (Regression rutscht durch), Verzögerungskosten mittel-steigend.
> C: Review für Team X (blockiert deren Release) — Aufwand winzig, Entsperr-Effekt hoch.
> Reihenfolge: C (entsperrt), B (stilles Wichtig vor lautem Mittel), A. Kommuniziert an den Wünschenden von A: „nächste Woche, weil B uns aktuell Fehler durchrutschen lässt — Tausch bestätigt von PO."

**Das gute Nein:**
> „Nein zu Feature Y in diesem Monat — nicht weil es unwichtig ist, sondern weil es Z verdrängen würde, und Z kostet uns pro Woche Verzögerung real Geld (Zahlen). Y ist als Nr. 1 für nächsten Monat gesetzt." — Begründet, mit Tausch, mit Perspektive.

## Eskalation

- Zwei Stakeholder bestehen auf unvereinbaren Nr.-1-Prioritäten → nicht selbst schlichten: Tausch-Frage mit den vier Größen aufbereiten und die gemeinsame Führungsebene entscheiden lassen (`skill-fable-opus.md`, Eskalation).
- Dauerzustand „alles dringend, nur reagieren" → als Kapazitäts-/Prozessproblem an den Verantwortlichen, mit Daten (Anteil ungeplanter Arbeit) — Priorisierung kann Überlast nicht lösen, nur sichtbar machen.
- Wichtig-Stilles (Sicherheit, Backup, Bus-Faktor) verliert wiederholt gegen Feature-Druck → Risiko formal übergeben (`skill-risk-analysis.md`, Regel 9): Akzeptanz dokumentieren lassen oder Priorität bekommen.
- Priorisierungs-Entscheidung wird außerhalb des vereinbarten Wegs umgeworfen („Chef-Ticket") → einmal ist Realität, als Muster ist es die Abschaffung der Priorisierung — ansprechen.

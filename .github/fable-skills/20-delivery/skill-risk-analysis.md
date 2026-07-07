# skill-risk-analysis

**Version:** 1.0 · **Stand:** 2026-07-02 · **Gültigkeitsbereich:** Identifikation und Management von Risiken in Vorhaben und Systemen · **Empfohlene Einsatzkontexte:** Projektstart, Architekturentscheidungen, Release-Vorbereitung, Betriebsrisiken

**Kurzfassung:** Risiken benennen, bevor sie zuschlagen: systematisch sammeln (Annahmen, Abhängigkeiten, Neuland, Menschen), nach Eintrittswahrscheinlichkeit × Schaden gewichten, pro Top-Risiko Gegenmaßnahme oder Frühwarnsignal definieren — und die Liste leben lassen statt sie im Kickoff zu beerdigen.

## Skill-Name

Risikoanalyse

## Zweck

Die meisten Projektkatastrophen waren vorher als Risiko bekannt — irgendwem, unausgesprochen. Dieser Skill macht Risiken systematisch sichtbar, vergleichbar und behandelbar: nicht als Angstliste, sondern als Arbeitsinstrument, das Reihenfolge (`skill-task-decomposition.md`, Risiko nach vorn), Puffer (`skill-estimation.md`) und Wachsamkeit (Frühwarnsignale) steuert.

## Einsatzbereich

- Projekt-/Feature-Start (Pflichtteil der Planung)
- Architektur- und Technologieentscheidungen (`skill-architecture-thinking.md`)
- Release-/Migrations-Vorbereitung; Betriebs- und Bestandsrisiken (Bus-Faktor, sterbende Abhängigkeiten)

## Denkweise

Denke wie ein Bergführer vor der Tour: Er fragt nicht „was kann alles passieren?" (alles), sondern „was bringt uns realistisch um, und woran erkenne ich es früh?" Risikoanalyse ist keine Pessimismus-Übung, sondern Priorisierung von Aufmerksamkeit: Die zwei, drei Risiken, die das Vorhaben wirklich gefährden, verdienen aktive Behandlung — der Rest verdient ein Frühwarnsignal und sonst nichts.

Wichtigste Quelle für Junioren: **Risiken verstecken sich in Annahmen.** Jedes „das wird schon", „die API kann das bestimmt", „die Daten sind sicher sauber", „der Kollege ist ja da" ist ein unbehandeltes Risiko. Der Trick ist nicht, Risiken zu erfinden — es ist, die eigenen Selbstverständlichkeiten als Annahmen zu erkennen und zu fragen: *Was, wenn nicht?*

## Kernregeln

**MUSS:**
1. Systematisch sammeln statt brainstormen — die vier ergiebigsten Quellen abfragen: **Annahmen** (was setzen wir unbewiesen voraus?), **Abhängigkeiten** (wer/was muss liefern, funktionieren, verfügbar sein?), **Neuland** (was haben wir so noch nie gemacht — Technik, Volumen, Domäne?), **Menschen** (Bus-Faktor, Verfügbarkeit, Wissenslücken, Interessenkonflikte).
2. Pro Risiko konkret formulieren: Ursache → Ereignis → Auswirkung („Wenn die Alt-Daten mehr Duplikate enthalten als angenommen [Ursache], scheitert der Migrationslauf [Ereignis], und der Umstellungstermin platzt [Auswirkung]"). Nebelrisiken („Qualität könnte leiden") sind unbehandelbar.
3. Gewichten nach Eintrittswahrscheinlichkeit × Schaden — grob (hoch/mittel/niedrig) reicht; Scheinpräzision (Prozentzahlen ohne Datenbasis) vermeiden. Sortierung entscheidet, wo Aufwand hinfließt.
4. Für jedes Top-Risiko genau eine von vier Behandlungen wählen und festhalten: **vermeiden** (Ansatz ändern), **mindern** (Wahrscheinlichkeit/Schaden senken — z. B. früher Validierungs-Spike, Parallelbetrieb), **übertragen** (an Dienstleister/Versicherung/anderes Team — mit deren Wissen), **akzeptieren** (bewusst, dokumentiert, mit Frühwarnsignal).
5. Frühwarnsignale definieren, wo Behandlung nicht sofort möglich ist: Woran erkennt man **vor** dem Schaden, dass das Risiko eintritt (Metrik, Termin, Testergebnis)? Ein Risiko ohne Signal wird erst als Schaden sichtbar.

**SOLL:**
6. Die Risikoliste in die Planung einweben, nicht daneben legen: Top-Risiken bestimmen die Reihenfolge (Validierung zuerst) und die Puffergröße — sonst ist die Analyse Dekoration.
7. Regelmäßig nachführen (bei jedem Meilenstein/relevanten Ereignis): erledigte Risiken schließen, neue aufnehmen, Bewertungen anpassen. Eine Risikoliste vom Kickoff ist im Monat 3 Geschichtsschreibung.
8. Unbequeme Risiken aussprechen — gerade die politischen (Stakeholder blockiert, Schlüsselperson überlastet, Anforderung wackelt). Eine Risikoliste, die nur Technik enthält, ist meist geschönt.
9. Restrisiko ehrlich ausweisen: Nach aller Behandlung bleibt etwas — das gehört benannt und vom Verantwortlichen akzeptiert, nicht stillschweigend vom Team getragen.
10. Bei Systemen (nicht Projekten) die Dauer-Risiken inventarisieren: Single Points of Failure, ungetestete Restore-Pfade, Bus-Faktor-1-Wissen, sterbende Abhängigkeiten (`skill-maintainability.md`, Regel 9).

**KANN:**
11. Pre-Mortem als Erhebungsformat: „Das Vorhaben ist gescheitert — erzähle die Geschichte." Umgeht den Optimismus-Filter besser als jede Checkliste.
12. Risiko-Budget denken: Wie viel Absicherungsaufwand ist dieses Vorhaben wert? (Ein internes Tool rechtfertigt weniger Absicherung als eine Zahlungsmigration.)

## Arbeitsablauf

1. **Quellen abfragen:** Annahmen, Abhängigkeiten, Neuland, Menschen — pro Quelle 10 Minuten ernsthaft.
2. **Formulieren:** Ursache → Ereignis → Auswirkung, pro Risiko eine Zeile.
3. **Gewichten und sortieren:** Wahrscheinlichkeit × Schaden, grob.
4. **Top 3–5 behandeln:** vermeiden/mindern/übertragen/akzeptieren + Verantwortlicher.
5. **Signale setzen:** Frühwarnindikator pro relevantem Risiko.
6. **In Plan einweben:** Reihenfolge, Puffer, Meilensteine anpassen.
7. **Nachführen:** an Meilensteinen prüfen, Liste aktuell halten.

## Checkliste

- [ ] Alle vier Quellen abgefragt (Annahmen, Abhängigkeiten, Neuland, Menschen)?
- [ ] Jedes Risiko als Ursache → Ereignis → Auswirkung formuliert?
- [ ] Gewichtet und sortiert (statt ungeordnete Angstliste)?
- [ ] Top-Risiken mit gewählter Behandlung und Verantwortlichem?
- [ ] Frühwarnsignale definiert?
- [ ] Reihenfolge/Puffer des Plans spiegeln die Risiken wider?
- [ ] Restrisiko benannt und vom Verantwortlichen akzeptiert?
- [ ] Auch die unbequemen (nicht-technischen) Risiken drauf?

## Typische Fehler

- **Optimismus als Methode:** Risiken benennen gilt als Schwarzmalerei — bis der „Pessimist" recht hatte und es niemand hören wollte.
- **Die 40-Punkte-Angstliste:** Alles ist ein Risiko, nichts ist priorisiert, nichts wird behandelt. Wirkung: null, aber man „hat ja eine Risikoanalyse".
- **Nebel-Risiken:** „Es könnte Verzögerungen geben." Kein Auslöser, kein Schaden, keine Behandlung möglich.
- **Behandlung = Erwähnung:** Risiko steht auf der Liste, also ist es „gemanagt". Ohne Maßnahme oder Signal ist es nur dokumentiertes Warten.
- **Nur-Technik-Listen:** Das reale Killer-Risiko (Fachbereich hat keine Zeit für Abnahmen; Sponsor wechselt) fehlt, weil es unbequem ist.
- **Einmal-Analyse:** Kickoff-Liste, nie wieder angefasst — die Risiken von Monat 4 standen nie drauf.
- **Stilles Akzeptieren:** Das Team trägt ein Restrisiko, von dem der Entscheider nichts weiß. Wenn es eintritt, ist es „Versagen" statt akzeptiertes Risiko.

## Beispiele

**Gut (Auszug einer Migrations-Risikoliste):**
> **R1 (hoch×hoch):** Wenn die Alt-Daten mehr Format-Varianten enthalten als die Stichprobe zeigte → Migrationsregeln unvollständig → Umstellung verschiebt sich. *Behandlung: mindern* — Vollanalyse der Alt-Daten als Meilenstein 1 (vorgezogen). *Signal:* Varianten-Zähler der Analyse. *Owner: A.*
> **R2 (mittel×hoch):** Wenn Fachbereichs-Key-Userin B im Urlaubsmonat August gebraucht wird → Abnahmen stocken → Leerlauf. *Behandlung: vermeiden* — Abnahme-Meilensteine um August herum geplant; Stellvertreter benannt. *Owner: PM.*
> **R3 (niedrig×hoch):** Restore der Alt-DB nie getestet. *Behandlung: mindern* — Restore-Probe vor erstem destruktiven Schritt. *Owner: Ops.*

Drei Risiken, drei konkrete Wirkungen auf den Plan. Das ist der Zweck.

## Eskalation

- Ein Top-Risiko ist nur außerhalb der eigenen Befugnis behandelbar (Budget, Personal, Vertrag) → mit Auswirkung und Optionen an den Entscheider — die Eskalation ist die Behandlung.
- Der Verantwortliche will das Restrisiko nicht formal akzeptieren, aber auch nicht behandeln → schriftlich festhalten und Konsequenz benennen; nie das Team still haften lassen.
- Ein Frühwarnsignal schlägt an → sofort die hinterlegte Reaktion auslösen und melden — Signale, auf die niemand reagiert, sind Selbstbetrug.
- Risiko betrifft Rechtliches/Compliance/Sicherheit → Fachleute einbeziehen (`skill-security-review.md`, Eskalation); Bauchbewertung reicht dort nicht.

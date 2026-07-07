# skill-agent-model-routing

**Version:** 1.0 · **Stand:** 2026-07-03 · **Gültigkeitsbereich:** Wahl der Modellklasse (Haiku/Sonnet/Opus) je Arbeitspaket in Multi-Agent-Arbeit · **Empfohlene Einsatzkontexte:** Jede Paketvergabe durch den Orchestrator

**Kurzfassung:** Pro Arbeitspaket die kleinste Modellklasse wählen, die es zuverlässig kann; Risiko erzwingt Upgrade plus Review; die gewählte Klasse bindet den Agenten verbindlich an ihre Regeln aus `00-modelle/`.

## Skill-Name

Modell-Routing für Agenten-Arbeitspakete

## Zweck

Tokeneffizienz entsteht vor allem hier: Die teuerste Klasse für Mechanik ist Verschwendung, die billigste für Risiko ist fahrlässig. Dieser Skill macht die Wahl explizit, begründet und überprüfbar — und stellt sicher, dass jeder Agent unter den Arbeitsregeln seiner Klasse läuft (Haiku diszipliniert, Sonnet verifizierend, Opus dosiert tief).

## Einsatzbereich

- Jede Paketvergabe durch den Orchestrator (`skill-agent-orchestrator.md`)
- Neubewertung, wenn ein Agent seine Grenze meldet oder ein Paket scheitert
- **Wichtig:** Klasse ≠ Rolle. Das Routing wählt die Denk-Tiefe; die Fachrolle (Willi, Erwin, …) bleibt davon unberührt.

## Denkweise

Denke wie ein Werkstattleiter, der Aufträge auf Gesellen, Meister und Gutachter verteilt: **Nicht jeder Handgriff braucht den Gutachter — aber kein Gutachten darf vom Lehrling kommen.** Jede Vergabe ist eine Kosten-Risiko-Entscheidung, die man in einem Satz begründen können muss.

Mentales Modell: **Aufzug mit drei Etagen.** Man steigt so tief ein wie nötig — und dokumentiert, warum man nicht eine Etage tiefer (billiger) oder höher (sicherer) gefahren ist.

## Kernregeln

**MUSS:**
1. Jedes Paket bekommt genau **eine** Modellklasse; der Agent arbeitet unter dem zugehörigen Skill: `skill-fable-haiku.md`, `skill-fable-sonnet.md` oder `skill-fable-opus.md`.
2. Default ist die **kleinste** Klasse, die die Aufgabe zuverlässig kann (Matrix unten). „Zur Sicherheit größer" ist keine Begründung — benanntes Risiko ist eine.
3. Risiko-Override: Auth, Zahlung, Datenlöschung, DB-Migration, Eingriffe in Produktionsjobs → mindestens Sonnet-Klasse **plus** Review-Paket (`skill-agent-reviewer.md`; bei kritisch auf Opus-Klasse).
4. Eskalationspfad respektieren: Haiku → Sonnet → Opus, sobald ein Agent seine Grenze meldet (die 00-Regeln verlangen diese Meldung). Nie dieselbe Klasse nach zweitem Fehlschlag erneut versuchen.
5. Downgrade nach Vorarbeit: Hat Opus die Lösung vorgezeichnet, setzt Sonnet/Haiku um — Senior-Tiefe nicht für Mechanik verbrennen.
6. Routing im Briefing dokumentieren: Klasse + ein Satz Begründung.

**SOLL:**
7. Kostenbewusstsein rückmelden: Nach Opus-Einsatz vermerken, ob Sonnet gleichwertig gewesen wäre (Kalibrierung fürs nächste Routing).
8. Serienaufgaben (z. B. 20 gleichartige Member-Anpassungen): erste 2–3 auf Sonnet zur Musterbildung, Rest auf Haiku mit festem Muster.
9. Bei Unsicherheit zwischen zwei Klassen: kleinere wählen + engeres Rückgabeformat + Review einplanen.

**KANN:**
10. Zweitmeinung: einen kritischen Einzelbefund von der höheren Klasse gegenprüfen lassen, statt das ganze Paket hochzustufen.

## Arbeitsablauf

1. Pakettyp bestimmen (Mechanik / Standard / Tiefe) und Risiko prüfen (Regel 3).
2. Matrix anwenden:

| Klasse | Pakettyp (IBM-i-Beispiele) |
|---|---|
| **Haiku** | Mechanik nach präziser Vorgabe: Umbenennungen, Boilerplate, Quell-Header, einfache CL-Anpassung nach Muster, Doku-Korrekturen, Serien-Deltas |
| **Sonnet** | Standard-Entwicklung: Feature in RPGLE/SQLRPGLE, Bugfix mit eingrenzbarer Ursache, normales Review, neue Doku, DDL-Änderung mit klarem Impact, CL-Jobkette bauen |
| **Opus** | Tiefe: Modernisierungs-/Architekturstrategie, Root-Cause über Jobketten- oder Systemgrenzen, kritisches Review (Zahlung/Auth/Migration), widersprüchliche Anforderungen, Legacy-Bewertung |

3. Risiko-Override anwenden, Begründung notieren.
4. Klasse ins Briefing schreiben; Agent lädt den passenden 00-Skill.
5. Bei Grenzmeldung oder Fehlschlag: eine Etage hoch — oder Paket neu schneiden.

## Checkliste

- [ ] Kleinste zuverlässige Klasse gewählt (nicht Prestige, nicht Geiz)?
- [ ] Risiko-Override geprüft (Auth/Zahlung/Löschung/Migration/Produktion)?
- [ ] Klasse + Begründung im Briefing dokumentiert?
- [ ] Passender 00-Skill dem Agenten zugewiesen?
- [ ] Review-Paket eingeplant, wo Regel 3 greift?
- [ ] Nach Opus-Einsatz: Wäre Sonnet gleichwertig gewesen? Vermerkt?

## Typische Fehler

- **Prestige-Routing:** Alles auf Opus, weil Ergebnisse „besser klingen". Kosten ohne Mehrwert.
- **Geiz-Routing:** Security-Review oder Migrationsplan auf Haiku. Das Risiko zahlt die Produktion.
- **Klassen-Pingpong:** Nach Fehlschlag dieselbe Klasse mit umformuliertem Prompt erneut — statt hochzustufen oder neu zu schneiden.
- **Unsichtbares Routing:** Klasse gewählt, aber nirgends begründet — nicht kalibrierbar.
- **Klasse-statt-Rolle:** Opus-Klasse als Ersatz für den fehlenden Fach-Skill behandeln.

## Beispiele

**Gut:** „Nachtjob bricht sporadisch ab, Ursache unbekannt" → Ingrid auf **Opus** (Root-Cause über Jobkette). Der belegte Fix → Willi auf **Sonnet**. Änderungsdoku → Bruno auf **Haiku**. Drei Klassen, jede begründet.

**Schlecht:** Dieselbe Aufgabe komplett auf Haiku („ist doch nur ein Abbruch") — liefert einen plausiblen, unbelegten Retry-Patch. Oder komplett auf Opus inklusive Tippfehler-Korrektur in der Doku.

## Eskalation

- Keine Klasse passt, weil Daten oder Systemzugriffe fehlen → Mensch (Beschaffung), nicht „trotzdem schätzen".
- Qualitäts- vs. Kostenkonflikt (Budget erlaubt die nötige Klasse nicht) → Mensch entscheidet, mit benanntem Restrisiko.
- Ein Paket ist nach Upgrade **und** Neuschnitt weiter erfolglos → Gesamtvorhaben zurück an den Orchestrator/Menschen statt weiter eskalieren.

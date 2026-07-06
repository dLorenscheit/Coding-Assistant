# skill-feature-planning

**Version:** 1.0 · **Stand:** 2026-07-02 · **Gültigkeitsbereich:** Planung einzelner Features vom Bedarf bis zum Rollout · **Empfohlene Einsatzkontexte:** Feature-Tickets, Produktinkremente, Experimente

**Kurzfassung:** Ein Feature ist erst geplant, wenn sein kleinster wertvoller Wurf definiert ist: Kern von Ausbau trennen, in nutzbare Scheiben schneiden, Rollout (Flag, Stufen, Rückweg) und Erfolgsmessung von Anfang an mitdenken — Features werden ausgeliefert, nicht nur fertig.

## Skill-Name

Feature-Planung

## Zweck

Zwischen Projektplanung (Wochen, viele Beteiligte) und Aufgabenzerlegung (technische Schritte) liegt die Feature-Ebene: Was genau bauen wir zuerst, was bewusst später, wie kommt es zu den Nutzern, und woran erkennen wir, ob es wirkt? Dieser Skill verhindert die zwei Standardfehler dieser Ebene: das Vollausbau-Feature, das nie fertig wird, und das ausgelieferte Feature, von dem niemand weiß, ob es funktioniert — fachlich wie technisch.

## Einsatzbereich

- Jedes Feature ab ~2–3 Tagen Umfang
- Experimente/Hypothesen („bringt ein Schnellbestell-Button mehr Abschlüsse?")
- Zusammenspiel: Anforderungen klären (`skill-requirements-analysis.md`) → **dieses Skill** → technisch zerlegen (`skill-task-decomposition.md`)

## Denkweise

Denke vom **ersten echten Nutzer** her: Welche kleinste Version würde einem echten Nutzer heute schon helfen — auch wenn sie unbequem, manuell ergänzt oder eingeschränkt ist? Das ist der Kern. Alles andere ist Ausbau, und Ausbau plant man erst, wenn der Kern seinen Wert bewiesen hat. Die meisten Vollausbau-Pläne bauen Stufe 2 und 3 für ein Verhalten, das Stufe 1 widerlegt hätte.

Zweiter Grundsatz: **Liefern ist Teil des Features.** Ein Feature ohne Rollout-Plan (wie kommt es sicher zu Nutzern?) und ohne Messplan (woran sehen wir Wirkung und Schaden?) ist halb geplant — die zweite Hälfte holt einen nach dem Merge ein.

## Kernregeln

**MUSS:**
1. Kern und Ausbau trennen: den kleinsten wertvollen Wurf (MVP im ehrlichen Sinn: nutzbar, wertstiftend, klein) explizit definieren — und die Ausbaustufen als eigene, später zu entscheidende Einheiten dahinter.
2. In nutzbare Scheiben schneiden, nicht in technische Schichten: Jede Scheibe ist für irgendeinen Nutzerkreis verwendbar („erst nur Lesen", „erst nur ein Kundentyp", „erst nur DE") — nicht „erst mal das Datenmodell für alles".
3. Rollout-Mechanik vor Baubeginn festlegen: Feature-Flag/Staffelung/Pilotgruppe, Rückschaltweg, und was bei halb ausgerolltem Zustand mit den Daten passiert. Nachrüsten ist teuer, bei Datenmigrationen oft unmöglich (`skill-task-decomposition.md`, Regel 8).
4. Erfolgs- und Schadensmessung definieren: Woran erkennen wir, dass es wirkt (Nutzung, Kennzahl) — und woran, dass es schadet (Fehlerrate, Support-Aufkommen, Performance)? Mindestens die Schadensseite braucht ein Monitoring ab Tag 1.
5. Betroffene Bestandsfunktionen benennen (was könnte dieses Feature verschlechtern oder verwirren?) — Features konkurrieren mit dem Bestand um Verhalten, UI-Plätze und Daten (`skill-change-impact-analysis.md`).

**SOLL:**
6. Ausbaustufen als echte Optionen behandeln: Nach dem Kern wird anhand der Messung neu entschieden (weiterbauen/ändern/stoppen) — die Stufen sind keine Abarbeitungsliste.
7. Aufwandstreiber ehrlich benennen: Meist sind es Randfälle, Berechtigungen, Migration und Fehlerpfade — nicht der Happy Path. Wenn eine Scheibe „fast fertig, nur noch Randfälle" ist, ist sie halb fertig (`skill-estimation.md`).
8. Nicht-Ziele des Features sichtbar dokumentieren (im Ticket), damit Scope-Anbauten („könnte man da nicht gleich…") eine bewusste Entscheidung bleiben.
9. UX-/Fach-Feedback an der billigsten Stelle einholen: Skizze/Klickdummy vor Code, Pilotnutzer vor Vollrollout.
10. Aufräum-Schritt einplanen: Flag entfernen, Altpfad abbauen, Doku nachziehen — sonst sammeln sich tote Flags und Doppelpfade (Konsistenz-Schulden).

**KANN:**
11. Hypothesen-Format für unsichere Features: „Wir glauben, dass [Änderung] für [Nutzergruppe] zu [messbarem Effekt] führt — wir irren, wenn [Kennzahl] nach [Zeitraum] nicht [Schwelle] erreicht."
12. „Betrieb eines Features" durchdenken: Support-Fragen, Admin-Bedienung, Fehlerbilder — wer beantwortet was ab Tag 1?

## Arbeitsablauf

1. **Problem und Erfolgskriterium übernehmen** (aus `skill-requirements-analysis.md`).
2. **Kern definieren:** kleinster Wurf, der einem echten Nutzer nützt; Ausbau dahinter parken.
3. **Scheiben schneiden:** jede nutzbar, jede mit eigenem Fertig-Kriterium.
4. **Rollout und Messung festlegen:** Flag/Stufen/Rückweg; Wirk- und Schadensmetriken.
5. **Bestandseinfluss prüfen:** Was kann schlechter werden? Monitoring darauf.
6. **Technisch zerlegen** (`skill-task-decomposition.md`), bauen, ausrollen, **messen, neu entscheiden**, aufräumen.

## Checkliste

- [ ] Ist der kleinste wertvolle Wurf definiert — und würde ein echter Nutzer ihn nutzen?
- [ ] Ist jede Scheibe nutzbar (nicht nur „technisch fertig")?
- [ ] Stehen Rollout-Mechanik und Rückweg vor Baubeginn fest?
- [ ] Gibt es Wirk- und Schadensmessung ab Tag 1?
- [ ] Sind Nicht-Ziele und Bestandsrisiken dokumentiert?
- [ ] Ist nach dem Kern eine echte Weiterbau-Entscheidung vorgesehen?
- [ ] Ist das Aufräumen (Flags, Altpfade) eingeplant?

## Typische Fehler

- **Vollausbau-Planung:** Alle Ausbaustufen als ein Paket geplant und geschätzt — nach 6 Wochen ist nichts nutzbar, und die Prioritäten haben sich gedreht.
- **Technik-Scheiben:** „Sprint 1: Datenmodell, Sprint 2: API, Sprint 3: UI" — nutzbar ist erst alles zusammen, Feedback kommt maximal spät (`skill-task-decomposition.md`, Schichten-Schnitt).
- **MVP als Ausrede:** Der „kleinste Wurf" ist in Wahrheit der Vollausbau mit gestrichener Fehlerbehandlung — klein am Falschen gespart. Klein wird der *Umfang*, nicht die *Qualität* des Gelieferten.
- **Rollout als Nachgedanke:** Feature fertig, dann erst die Frage „und wie schalten wir das für 10.000 Bestandskunden an?" — jetzt fehlt das Flag, die Migration kennt keinen Zwischenzustand.
- **Liefern ohne Messen:** Das Feature ist seit drei Monaten live; ob es jemand nutzt, weiß niemand. Die nächste Ausbaustufe wird trotzdem gebaut.
- **Ewige Flags:** 40 Feature-Flags, 30 davon seit einem Jahr auf „an" — jeder Testlauf hat 2^30 theoretische Konfigurationen.

## Beispiele

**Gut geschnitten (Feature „Rechnungen als PDF per Mail"):**
- *Kern (Scheibe 1):* Nutzer kann im Portal pro Rechnung manuell „per Mail senden" auslösen; nur Standard-Template; nur an die hinterlegte Adresse. Nutzbar, klein, misst echte Nachfrage (Klickrate).
- *Scheibe 2 (nach Messung):* automatischer Versand bei Rechnungsstellung, Opt-in pro Kunde.
- *Geparkt:* mehrere Empfänger, Template-Anpassung, Sammelversand — Entscheidung nach Nutzung von Scheibe 2.
- *Rollout:* Flag, erst 3 Pilotkunden; Schadensmetrik: Mail-Bounce-Rate, Supporttickets. Rückweg: Flag aus, Downloads unverändert verfügbar.

**Schlecht:** Alles in einem: automatischer Versand für alle Kunden ab Merge, ohne Flag, ohne Bounce-Monitoring. Erste Erkenntnis kommt als Beschwerdewelle.

## Eskalation

- Der Auftraggeber besteht auf Vollausbau ohne Zwischenlieferung → Risiko (spätes Feedback, verfallende Prioritäten) explizit machen und die Entscheidung dokumentieren lassen — dann loyal umsetzen.
- Kern-Definition scheitert, weil der Nutzen unklar ist („für wen ist das?") → zurück zu `skill-requirements-analysis.md`; ohne Nutzenhypothese ist jede Scheibe willkürlich.
- Rollout-Anforderungen (Migration, Parallelbetrieb) übersteigen das Feature-Budget sichtbar → früh als Aufwandstreiber melden, nicht erst beim „fast fertig".
- Messung zeigt Schaden (Kennzahl kippt, Fehler steigen) → Rückschaltung ist die Default-Reaktion; Weiterbetrieb trotz Schadenssignal ist eine Entscheidung des Verantwortlichen, nicht des Teams.

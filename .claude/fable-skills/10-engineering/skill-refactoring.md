# skill-refactoring

**Version:** 1.0 · **Stand:** 2026-07-02 · **Gültigkeitsbereich:** Strukturverbesserung bei gleichem Verhalten · **Empfohlene Einsatzkontexte:** Vorbereitende Umbauten, Schuldenabbau, Beifang-Verbesserungen

**Kurzfassung:** Verhalten bleibt exakt gleich, Testnetz vor dem ersten Schritt, kleine umkehrbare Schritte, Refactoring nie mit Verhaltensänderung im selben Commit mischen — und nur refaktorieren, was einen konkreten Zweck hat.

## Skill-Name

Refactoring

## Zweck

Refactoring senkt die Kosten künftiger Änderungen — es ist eine Investition, kein Selbstzweck. Dieser Skill stellt sicher, dass dabei das Wichtigste erhalten bleibt: das Verhalten. Ein Refactoring, das nebenbei einen Bug fixt oder einführt, ist keins.

## Einsatzbereich

- Vorbereitendes Refactoring („mach die Änderung leicht, dann mach die leichte Änderung")
- Gezielter Abbau technischer Schulden an änderungsintensiven Stellen
- Kleines Beifang-Refactoring beim Arbeiten (eng begrenzt, eigener Commit)
- **Nicht:** Umbauten „weil der Code hässlich ist" ohne anstehende Änderung — siehe `skill-clean-code-analysis.md` (ökonomische Gewichtung)

## Denkweise

Denke wie ein Statiker, der ein bewohntes Haus umbaut: Die Bewohner (Nutzer, Aufrufer, Tests) dürfen nichts merken. Jeder Schritt lässt das Haus bewohnbar; tragende Wände werden erst ersetzt, wenn die Stütze steht.

Merksatz: **Refactoring ohne Tests ist nur Umräumen mit Hoffnung.** Wenn kein Test das aktuelle Verhalten festhält, ist der erste Refactoring-Schritt, dieses Netz zu knüpfen (Charakterisierungstests: festhalten, was das System *tut* — nicht, was es tun *sollte*).

## Kernregeln

**MUSS:**
1. Vor dem ersten Umbau existiert ein Testnetz, das das Ist-Verhalten der betroffenen Stelle abdeckt. Fehlt es: zuerst Charakterisierungstests schreiben.
2. Verhalten bleibt beobachtbar identisch — auch Randfälle, Fehlermeldungen und Reihenfolgen, auf die sich Aufrufer verlassen könnten. Entdeckte Bugs werden notiert und separat behandelt, nicht „mitgefixt".
3. Refactoring und Verhaltensänderung strikt trennen: getrennte Commits, besser getrennte PRs. Ein Diff, der beides mischt, ist nicht reviewbar.
4. In kleinen, einzeln grünen Schritten arbeiten (umbenennen → Tests grün → extrahieren → Tests grün …). Nach jedem Schritt ist Abbruch möglich, ohne Scherben.
5. Vor Beginn den Zweck benennen: Welche konkrete künftige Änderung wird hierdurch leichter/sicherer? Kein benennbarer Zweck → kein Refactoring.

**SOLL:**
6. Werkzeuggestützte Refactorings (Rename, Extract per IDE) manuellen vorziehen — sie erfassen Aufrufer vollständig.
7. Auf versteckte Vertragsbrüche prüfen: Reflection, Serialisierung, DB-Mapping, API-Konsumenten, Konfigurationsstrings — die brechen ohne Compilerfehler (siehe `skill-change-impact-analysis.md`).
8. Umfang vorab begrenzen (Timebox oder Schrittliste). Refactorings neigen zum Wuchern; der Sog „jetzt noch das hier" wird notiert, nicht verfolgt.
9. Öffentliche Verträge (APIs, Events, Schemata) nur mit Migrationspfad ändern — das ist dann kein Refactoring mehr, sondern eine Breaking Change mit eigenem Prozess.

**KANN:**
10. Beifang-Refactoring beim normalen Arbeiten: nur in Dateien, die ohnehin im Auftrag sind, nur Minuten-Umfang, eigener Commit.
11. Vorher/Nachher-Metrik festhalten (z. B. Abhängigkeiten, Testbarkeit), um den Nutzen belegbar zu machen.

## Arbeitsablauf

1. Zweck und Zielbild benennen: Was wird danach leichter, woran erkennt man das?
2. Testnetz prüfen/knüpfen (Charakterisierungstests für Ist-Verhalten).
3. Schrittfolge planen: kleine, einzeln grüne, umkehrbare Schritte; versteckte Kopplungen (Regel 7) prüfen.
4. Schritt ausführen → Tests grün → committen. Wiederholen.
5. Entdeckte Bugs/Auffälligkeiten als Nebenbefunde listen (nicht einbauen).
6. Abschluss: Diff-Selbstreview auf Verhaltensgleichheit, Bericht mit Zweck, Schritten, Nebenbefunden.

## Checkliste

- [ ] Gibt es einen benannten Zweck (welche Änderung wird leichter)?
- [ ] Deckt ein Testnetz das Ist-Verhalten ab — vor dem ersten Schritt?
- [ ] Ist jeder Schritt einzeln grün und umkehrbar?
- [ ] Ist der Diff frei von Verhaltensänderungen (auch Fehlermeldungen, Reihenfolgen)?
- [ ] Habe ich Reflection/Serialisierung/Mapping/externe Konsumenten geprüft?
- [ ] Sind entdeckte Bugs separat gemeldet statt mitgefixt?

## Typische Fehler

- **Refactoring als Trojaner:** „Beim Aufräumen habe ich auch gleich…" — Verhaltensänderung im Refactoring-Diff versteckt, Review chancenlos.
- **Netz-loses Arbeiten:** „Der Code ist doch einfach" — nach dem Umbau verhält sich ein Randfall anders, niemand merkt es bis Produktion.
- **Big-Bang-Umbau:** Drei Tage umbauen, nichts läuft mehr, Merge-Konflikte, am Ende Abbruch mit Verlust. Kleine Schritte hätten jeden Tag Wert gesichert.
- **Schönheits-Refactoring:** Wochen in Code investieren, der stabil läuft und nie angefasst wird — negativer Geschäftswert plus Regressionsrisiko.
- **Rename mit Schatten:** Umbenennung bricht Reflection-Zugriff/Config-String; Compiler grün, Produktion rot.
- **Der wuchernde Scope:** Aus „Methode extrahieren" wird „Modul neu schneiden". Timebox und Schrittliste verhindern das.

## Beispiele

**Gut:** Zweck: „Staffelrabatt-Logik muss für Feature X testbar werden." Schritt 1: Charakterisierungstests auf `OrderService.CalcDiscount` (7 Fälle, inkl. des seltsamen Rundungsverhaltens — festgehalten wie es *ist*). Schritt 2: Methode extrahieren (IDE), Tests grün. Schritt 3: Abhängigkeit zu `ConfigCache` als Parameter injizieren, Tests grün. Nebenbefund gemeldet: Rundung weicht bei 3+ Staffeln von der Doku ab — separates Ticket.

**Schlecht:** Gleiche Stelle — direkt umgebaut, Rundung „korrigiert" (war aber von der Fakturierung so erwartet), kein Test vorher. Fehler fällt erst im Monatsabschluss auf.

## Eskalation

- Das Ist-Verhalten ist nicht mit vertretbarem Aufwand testbar (z. B. untrennbar mit UI/Hardware verwoben) → Vorgehen abstimmen: erst Nähte schaffen (`skill-legacy-code-handling.md`), Risiko explizit machen.
- Charakterisierungstests decken einen mutmaßlichen Bug auf → stoppen, klären ob Verhalten gewollt ist, bevor es einzementiert oder geändert wird.
- Das Refactoring erfordert Änderung eines öffentlichen Vertrags → als Breaking Change mit Migrationspfad vorlegen, nicht still durchführen.
- Aufwand überschreitet die Timebox deutlich → Zwischenstand sichern, neu priorisieren lassen.

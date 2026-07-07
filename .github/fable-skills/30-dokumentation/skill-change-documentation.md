# skill-change-documentation

**Version:** 1.0 · **Stand:** 2026-07-02 · **Gültigkeitsbereich:** Dokumentation von Änderungen — Commits, PRs, Changelogs, Migrationshinweise, Betriebsmeldungen · **Empfohlene Einsatzkontexte:** Jede Änderung, die andere verstehen, nachvollziehen oder darauf reagieren müssen

**Kurzfassung:** Jede Änderung erzählt dreierlei: Was, Warum, und was Betroffene tun müssen — Commits tragen das Warum (der Diff zeigt nur das Was), Changelogs sprechen die Sprache der Konsumenten, Breaking Changes und Migrationsschritte stehen zuerst und unübersehbar; die Änderungshistorie ist das Gedächtnis des Systems.

## Skill-Name

Änderungs-Dokumentation

## Zweck

Monate später ist die Änderungshistorie oft die einzige verlässliche Wissensquelle: Warum wurde das geändert? Was kam in Version X? Was muss ich beim Update beachten? `git blame` und Changelog beantworten das — wenn beim Ändern dokumentiert wurde. Dieser Skill regelt die drei Ebenen: **Commit/PR** (fürs Team und die Zukunft), **Changelog/Release-Notes** (für Konsumenten), **Migrations-/Betriebshinweise** (für die, die handeln müssen).

## Einsatzbereich

- Commit-Messages und PR-Beschreibungen (täglich)
- Changelogs und Release-Notes für Bibliotheken, APIs, Anwendungen
- Migrations- und Upgrade-Hinweise; Betriebsrelevante Änderungsmeldungen
- Ergänzt: Struktur-Warums → `skill-decision-records.md`; Doku-Nachzug → `skill-documentation-writing.md` (Regel 11)

## Denkweise

Der wichtigste Leser deiner Commit-Message ist der **Detektiv in 14 Monaten**: Jemand (vielleicht du) steht per `git blame` auf dieser Zeile, weil sie an einem Bug beteiligt ist, und fragt: Warum wurde das so gemacht? Der Diff zeigt ihm längst, *was* geändert wurde — die Message schuldet ihm das, was der Diff nicht zeigt: das Warum, den Anlass, die Alternativen, die Nebenwirkungen. „Fix bug" ist für diesen Leser eine Verhöhnung.

Für Changelogs gilt Perspektivwechsel: **Der Konsument fragt nicht „was habt ihr getan?", sondern „was bedeutet das für mich?"** — Er will wissen: Bricht etwas? Muss ich handeln? Was kann ich jetzt Neues? Interne Umbauten, die ihn nicht betreffen, sind für ihn Rauschen.

## Kernregeln

**MUSS:**
1. Commit-Messages tragen das Warum: Betreffzeile = präzise Zusammenfassung der Änderung (Konvention des Repos, z. B. `fix: …`/`feat: …`); Body bei allem Nicht-Trivialen = Anlass/Problem, gewählte Lösung, und was der Diff nicht zeigt (verworfene Alternative, Nebenwirkung, Ticket-Link). Faustregel: Die Message muss die spätere blame-Frage beantworten.
2. Ein Commit = eine logische Änderung: Refactoring, Fix und Formatierung nicht mischen (`skill-refactoring.md`, Regel 3) — gemischte Commits machen blame, Revert und Review wertlos.
3. Breaking Changes zuerst und unübersehbar: In Commit (Konvention, z. B. `BREAKING CHANGE:`), PR und Changelog an erster Stelle, mit konkretem Migrationsschritt („Feld X entfällt → nutze Y; Skript Z migriert Bestandsdaten"). Ein versteckter Breaking Change ist eine gelegte Falle (`skill-api-design.md`, Regel 4).
4. Changelog aus Konsumentensicht schreiben: gruppiert nach Wirkung (Breaking / Neu / Behoben / Sicherheit), formuliert als Bedeutung für den Nutzer („Export bricht bei >50 MB nicht mehr ab") statt als interne Tätigkeit („ExportBuffer refactored"). Interne Änderungen ohne Konsumenten-Wirkung: weglassen oder eigener Abschnitt.
5. Betriebsrelevante Änderungen (neue Config-Pflichtwerte, geänderte Jobs, neue Alarme, Migrationen mit Laufzeit) aktiv an den Betrieb kommunizieren und im Runbook nachziehen (`skill-runbook-writing.md`, Regel 8) — ein Changelog, das niemand abonniert hat, ist keine Meldung.

**SOLL:**
6. PR-Beschreibung als Review-Landkarte: Was ist das Ziel, wo ist der Kern des Diffs, was wurde bewusst *nicht* gemacht, wie wurde verifiziert (`skill-code-review.md` braucht genau das als Einstieg — und die Impact-Statusliste gehört dazu, `skill-change-impact-analysis.md`, Regel 5).
7. Verweisketten pflegen: Commit ↔ Ticket ↔ PR ↔ ggf. ADR — der Detektiv von Regel 1 folgt Links; eine tote Ticket-Nummer in der Message ist halb so viel wert.
8. Migrationshinweise als testbare Anleitung behandeln: konkrete Schritte, erwartetes Ergebnis, Rückweg — und einmal selbst durchgespielt (`skill-documentation-writing.md`, Regel 3; bei DB-Migrationen: `skill-database-thinking.md`, Regel 2–3).
9. Änderungsdoku im selben Arbeitsgang wie die Änderung: Changelog-Eintrag und Doku-Nachzug gehören in den PR, nicht in ein „später" — später existiert nicht.
10. Versionierungs-Semantik einhalten, wo Konsumenten darauf bauen (SemVer bei Bibliotheken/APIs): Breaking = Major; wer Breaking Changes in Patch-Versionen versteckt, verbrennt das Vertrauen aller Nutzer.

**KANN:**
11. Changelog-Einträge direkt beim Mergen sammeln (Datei/Tooling), statt sie zum Release aus Commits zu rekonstruieren.
12. Für interne Systeme einen leichtgewichtigen „Was ist neu"-Kanal pflegen (kurze Meldung pro Deployment) — beugt dem „seit wann ist DAS so?" vor.

## Arbeitsablauf

1. **Beim Committen:** eine logische Änderung, Betreff nach Konvention, Warum in den Body, Verweise setzen.
2. **Beim PR:** Ziel, Kern, Nicht-Ziele, Verifikation, Impact-Status; Breaking Changes nach oben.
3. **Beim Mergen:** Changelog-Eintrag (Konsumentensprache), betroffene Doku im selben Diff nachziehen.
4. **Beim Release:** Notes aus Wirkungs-Gruppen bauen (Breaking → Migration zuerst); Version nach Semantik.
5. **Bei Betriebsrelevanz:** aktiv melden (Kanal des Betriebs), Runbook nachziehen.

## Checkliste

- [ ] Beantwortet die Commit-Message die spätere blame-Frage (Warum + Nicht-Sichtbares)?
- [ ] Ist jeder Commit eine logische Änderung?
- [ ] Stehen Breaking Changes zuerst — mit konkretem Migrationsschritt?
- [ ] Spricht das Changelog die Sprache der Konsumenten (Wirkung statt Tätigkeit)?
- [ ] Sind Verweisketten intakt (Ticket/PR/ADR)?
- [ ] Ist die Migrationsanleitung durchgespielt und mit Rückweg versehen?
- [ ] Doku/Runbook im selben Arbeitsgang nachgezogen, Betrieb aktiv informiert?

## Typische Fehler

- **„Fix bug" / „Update" / „WIP":** Der Detektiv in 14 Monaten findet einen Diff ohne Geschichte — und muss raten, ob die seltsame Zeile Absicht war. Genau dann werden „unnötige" Zäune abgerissen (`skill-legacy-code-handling.md`, Chestertons Zaun).
- **Der Roman im Betreff:** 200 Zeichen Betreffzeile statt Betreff + Body — unlesbar in jeder Log-Ansicht.
- **Sammel-Commit:** Fix + Refactoring + Formatierung in einem — Revert unmöglich, blame zeigt auf die Formatierung, Review sieht den Fix nicht.
- **Changelog als Tätigkeitsbericht:** „OrderService refactored, Dependencies aktualisiert" — der Konsument erfährt nicht, dass sein Feld deprecated wurde.
- **Breaking Change im Kleingedruckten:** Zeile 14 der Release-Notes, hinter drei Features. Der Konsument updated, Produktion bricht, Vertrauen weg.
- **Rekonstruktions-Changelog:** Zum Release aus 200 Commits zusammenraten, was relevant war — teuer und lückenhaft; beim Mergen hätte es Sekunden gekostet.
- **Doku-Drift:** Verhalten geändert, README/Runbook nicht — ab jetzt lügt die Doku, und zwar genau an der frisch geänderten Stelle (`skill-documentation-writing.md`, Kommentar-Lügen in groß).

## Beispiele

**Commit mit Warum (der Diff zeigt nur einen geänderten Vergleich):**
```
fix: Rabattbasis auf Artikelsumme begrenzen (SHOP-482)

Rabatt wurde auf subtotal inkl. Versandkosten berechnet; laut FB
(A. Meier, 30.06.) war Versand nie rabattfähig. Betrifft nur Neuberechnungen —
Bestandsrechnungen bleiben unverändert (Absprache im Ticket).
Bewusst NICHT in InvoiceService angefasst: Gutschriften nutzen dieselbe
Methode, dort ist das Verhalten gewollt (Test ergänzt, der das festhält).
```

**Changelog-Eintrag, Konsumentensicht:**
> **⚠️ Breaking (v4.0):** `GET /orders` liefert ohne `limit`-Parameter jetzt maximal 100 Einträge (vorher: alle). **Migration:** Aufrufe, die Vollexporte erwarten, auf Paginierung umstellen (`?limit=100&offset=…`) — Beispiel im API-Guide, Abschnitt 3.
> **Behoben:** Export bricht bei Dateien > 50 MB nicht mehr ab (betraf 4 Kunden mit Großkatalogen).

## Eskalation

- Ein nötiger Breaking Change ohne Kommunikationsweg zu den Konsumenten (unbekannte Nutzer) → erst Nutzung messen/Konsumenten identifizieren, dann ändern (`skill-api-design.md`, Eskalation) — nie „ins Dunkle" releasen.
- Historie ist als Wissensquelle unbrauchbar (Team committet „WIP"-Ketten) → als Konventionsproblem ans Team (`skill-consistency.md`): Commit-Standard beschließen + im Review einfordern; Einzelappelle ändern nichts.
- Änderung mit rechtlicher/vertraglicher Meldepflicht (SLA-relevantes Verhalten, Datenverarbeitung) → Kommunikation über die Verantwortlichen, nicht per Changelog-Zeile (`skill-api-design.md`, Eskalation externe Partner).
- Release-Druck will „Notes machen wir nach" → Breaking-Change-Doku ist Teil des Release; ohne sie ausliefern ist eine Risiko-Entscheidung des Verantwortlichen, die dokumentiert gehört (`skill-code-review.md`, Eskalation Zeitdruck).

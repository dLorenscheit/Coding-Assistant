# skill-design-smell-detection

**Version:** 1.0 · **Stand:** 2026-07-02 · **Gültigkeitsbereich:** Erkennen struktureller Warnsignale im Design · **Empfohlene Einsatzkontexte:** Reviews, Audits, Refactoring-Vorbereitung, Architektur-Checks

**Kurzfassung:** Smells sind Hinweise, keine Urteile: die Kernsignale (Shotgun Surgery, God Class, Feature Envy, undichte Abstraktion, zirkuläre Abhängigkeiten, divergente Änderungsgründe) erkennen, am Schadensszenario prüfen — und nur behandeln, wo Änderungshäufigkeit den Umbau rechtfertigt.

## Skill-Name

Design-Smell-Erkennung

## Zweck

Design-Fehler sieht man selten direkt — man riecht sie an Symptomen: Jede kleine Fachänderung fasst fünf Module an; eine Klasse kennt jeder, weil sie alles tut; ein „einfaches" Feature dauert Wochen. Dieser Skill benennt die wichtigsten Warnsignale, ihre typischen Schadensszenarien und die Prüffragen, mit denen man Hinweis von Fehlurteil trennt. Er liefert die Struktur-Perspektive unter `skill-clean-code-analysis.md` (dort: Bewertung/Ökonomie) und `skill-module-design.md` (dort: Konstruktion).

## Einsatzbereich

- Reviews größerer Änderungen (Design-Ebene über der Zeilen-Ebene)
- Ursachensuche für „hier dauert alles ewig"-Symptome
- Priorisierung von Refactoring-Kandidaten

## Denkweise

Denke wie ein Hausarzt beim Abhören: Ein Geräusch ist ein Befund zum Nachprüfen, keine Diagnose. Jeder Smell hat legitime Ausnahmen — eine „God Class" kann ein bewusst zentrales, stabiles Fachmodul sein; Duplikation kann billiger sein als Kopplung. Das Urteil entsteht erst aus **Smell + Schadensszenario + Änderungshäufigkeit**. Der Anfängerfehler ist nicht, Smells zu übersehen — es ist, jeden Smell zum Umbauauftrag zu erklären.

Leitfrage bei allem: **„Wenn sich morgen Anforderung X ändert — zwingt mich diese Struktur, an Orten zu arbeiten, die mit X nichts zu tun haben?"**

## Kernregeln

**MUSS — die Kernsignale kennen und aktiv suchen:**
1. **Shotgun Surgery:** Eine fachliche Änderung erzwingt Edits an vielen Stellen (erkennbar an Diffs vergangener Tickets: `git log` zeigt immer dieselbe Datei-Gruppe gemeinsam). Schaden: Jede Änderung teuer, eine Stelle wird vergessen. Meist-Ursache: eine Fachregel wohnt verteilt.
2. **God Class / God Module:** Eine Einheit kennt/tut alles, jeder Weg führt durch sie (erkennbar an: höchste Änderungsfrequenz + meiste Abhängigkeiten + niemand traut sich ran). Schaden: Merge-Konflikte, Angst-Änderungen, untestbar.
3. **Feature Envy:** Code arbeitet überwiegend mit den Daten eines anderen Moduls (Ketten wie `order.getCustomer().getAddress().getZip()` plus Logik darauf). Schaden: Fachregel liegt beim falschen Besitzer, Änderungen schneiden quer.
4. **Undichte Abstraktion:** Die Abstraktion zwingt Nutzer, ihre Interna doch zu kennen (Aufrufer prüfen Implementierungstyp, Sonderparameter „nur für Fall Y"). Schaden: Doppelte Komplexität — Abstraktion plus Durchgriff (`skill-abstraction-judgment.md`).
5. **Zirkuläre Abhängigkeiten:** Modul A braucht B braucht A (direkt oder über Umwege). Schaden: nichts einzeln testbar/ersetzbar/verstehbar; Änderungen schaukeln.
6. **Divergente Änderungsgründe:** Eine Einheit wird aus unabhängigen Gründen geändert (Preislogik **und** PDF-Layout **und** Mail-Versand in einer Klasse). Schaden: Unbeteiligte Änderungen destabilisieren sich gegenseitig (`skill-separation-of-concerns.md`).

**MUSS — Urteilsdisziplin:**
7. Pro gefundenem Smell das konkrete Schadensszenario formulieren und die Änderungshäufigkeit prüfen — ohne beides ist es eine Beobachtung, kein Befund (`skill-clean-code-analysis.md`, Regeln 1–3).
8. Vor dem Umbau-Vorschlag die legitime Erklärung suchen: Historie (blame/Tickets), bewusste Entscheidung (ADR?), Framework-Zwang. Chestertons Zaun gilt auch für Strukturen (`skill-legacy-code-handling.md`).

**SOLL:**
9. Smells über Änderungshistorie objektivieren statt nur über Lektüre: Dateien, die in Tickets ständig gemeinsam auftauchen (Kopplung), Hotspots (oft geändert + oft fehlerhaft) — das Repo erzählt, wo es wehtut.
10. Behandlungsvorschläge als kleinste wirksame Schnitte formulieren (die eine Fachregel zusammenziehen; die eine Zirkularität brechen) — nicht als Neuvermessung des Systems.
11. Auch das Gegen-Smell prüfen: **Spekulative Struktur** — Interfaces mit einer Implementierung, Schichten die nur durchreichen, Konfigurierbarkeit ohne Nutzer. Zu viel Struktur ist derselbe Fehler wie zu wenig, in eleganter Verkleidung.

**KANN:**
12. Wiederkehrende Smell-Muster im Repo als Teamthema aufbereiten (Konvention, Beispiel-Refactoring) statt pro Review neu zu diskutieren.

## Arbeitsablauf

1. **Symptome sammeln:** Wo klemmt es erfahrungsgemäß (langsame Features, Angst-Zonen, Merge-Konflikte)?
2. **Historie befragen:** Hotspots und Co-Änderungs-Gruppen aus git log; das lenkt die Lektüre.
3. **Kernsignale prüfen:** Regeln 1–6 gegen die auffälligen Bereiche; Fundstellen notieren (`skill-program-analysis.md`, Notation ✅/❓).
4. **Legitime Erklärungen ausschließen:** Historie, ADRs, Framework-Zwänge.
5. **Befunde formulieren:** Smell + Szenario + Häufigkeit + kleinster wirksamer Schnitt.
6. **Priorisieren:** wie `skill-clean-code-analysis.md` — inkl. Nicht-anfassen-Liste.

## Checkliste

- [ ] Habe ich die sechs Kernsignale systematisch geprüft (nicht nur das auffälligste)?
- [ ] Hat jeder Befund Schadensszenario + Änderungshäufigkeit?
- [ ] Habe ich legitime Erklärungen gesucht, bevor ich urteile?
- [ ] Habe ich auch spekulative Über-Struktur geprüft?
- [ ] Ist jeder Vorschlag der kleinste wirksame Schnitt?
- [ ] Stützt die Änderungshistorie meine Diagnose?

## Typische Fehler

- **Smell = Umbauauftrag:** Jede lange Klasse „muss zerlegt werden". Ohne Schadensszenario und Änderungsdruck ist das Beschäftigungstherapie mit Regressionsrisiko.
- **Ästhetik-Diagnose:** Struktur bemängeln, weil sie nicht dem Lieblingsmuster entspricht — statt weil sie Änderungen verteuert.
- **Blind für Über-Struktur:** 12 Interfaces, 4 Schichten, Factory-Factories — sieht ordentlich aus, ist aber dasselbe Problem: Änderungen erfordern Arbeit an Orten ohne Bezug zur Sache.
- **Lektüre ohne Historie:** Der „schlimmste" Code (hässlich, stabil, nie geändert) wird kuriert, der Hotspot (unauffällig, wöchentlich defekt) übersehen.
- **Diagnose ohne kleinsten Schnitt:** „Das Modul ist zu groß" als Befund abliefern. Ohne konkreten ersten Schritt passiert: nichts.
- **Zaun-Abriss auf Strukturebene:** Die „unnötige" Indirektion entfernen, die sich als Entkopplung zweier Teams herausstellt.

## Beispiele

**Befund gut formuliert (Shotgun Surgery):**
> Jede Änderung an Rabattregeln fasst 5 Dateien an (`PriceCalc`, `CartView`, `InvoiceService`, `AdminGrid`, `ExportJob`) — belegt durch die letzten 4 Rabatt-Tickets (Diffs verlinkt). Ursache: Die Regel „was ist rabattfähig" ist 5× implementiert, 2 Varianten weichen bereits ab (Zinsen der Duplikation). Änderungsfrequenz: ~monatlich. Kleinster Schnitt: Prüf-Logik in `DiscountEligibility` zusammenziehen, 5 Aufrufer umstellen, Abweichung vorher fachlich klären. Aufwand ~2 Tage, spart jeden Monat.

**Fehlurteil vermieden (God Class mit Existenzrecht):**
> `TariffEngine` (1.900 Zeilen) sieht wie eine God Class aus — ist aber das bewusst zentrale, seit 3 Jahren stabile Tarifmodul mit vollständiger Testabdeckung (ADR-007). Änderungsfrequenz: 2×/Jahr, geplant. Kein Befund; in die Nicht-anfassen-Liste, ADR verlinkt.

## Eskalation

- Smell entpuppt sich als Korrektheitsproblem (abweichende Duplikate, Zirkularität erzeugt Race) → als Bug behandeln (`skill-bug-triage.md`), nicht als Stilthema.
- Kleinster wirksamer Schnitt wäre trotzdem ein Großumbau (Zirkularität im Kern) → Entscheidungsvorlage mit Kosten/Nutzen/Risiko (`skill-architecture-thinking.md`), nicht eigenmächtig starten.
- Diagnose und Team-Selbstbild kollidieren („unser Kern ist doch sauber") → Historien-Daten sprechen lassen (Hotspot-Auswertung), nicht Meinung gegen Meinung.
- Smell wird durch Organisationsschnitt erzwungen (zwei Teams, ein Modul) → das ist ein Orga-Befund; an die Verantwortlichen, Conway lässt sich nicht wegrefactorn.

# skill-naming

**Version:** 1.0 · **Stand:** 2026-07-02 · **Gültigkeitsbereich:** Benennung von Variablen, Funktionen, Typen, Modulen, Tabellen · **Empfohlene Einsatzkontexte:** Implementierung, Reviews, Refactoring

**Kurzfassung:** Ein Name ist ein Vertrag: Er verspricht, was das Ding ist/tut — und lügende Namen sind teurer als hässliche. Fachsprache der Domäne verwenden, Präzision vor Kürze, Konsistenz im Repo vor persönlichem Geschmack; ein Rename ist billig, solange die Kopplung klein ist.

## Skill-Name

Benennung

## Zweck

Namen sind die dichteste Form von Dokumentation: Sie werden bei jedem Lesen konsumiert, ungefragt. Ein präziser Name erspart das Lesen der Implementierung; ein lügender Name erzwingt Debugging. Dieser Skill macht Benennung prüfbar — als Frage von Wahrheit, Präzision und Konsistenz statt Geschmack.

## Einsatzbereich

- Alles, was einen Namen trägt: Variablen, Funktionen, Klassen, Module, Dateien, Tabellen, Spalten, Events, Config-Schlüssel
- Review-Prüfraster: Wann ist ein Namens-Kommentar ein LOW-Nit, wann ein echter Befund?

## Denkweise

Behandle jeden Namen als **Versprechen an den Leser**: `getCustomer` verspricht, einen Kunden zu holen — nicht, nebenbei einen anzulegen, einen Cache zu füllen oder null zu liefern, wenn Dienstag ist. Der Leser plant sein Verständnis auf Basis der Namen; jede Lüge im Namen wird als Fehlannahme in seine Änderung eingebaut.

Prüf-Hierarchie (in dieser Reihenfolge, weil so die Schäden sortiert sind): **1. Lügt der Name?** (schlimmster Fall — aktiv irreführend) **2. Ist er zu vage?** (`data`, `manager`, `handle` — sagt nichts) **3. Ist er unpräzise?** (sagt etwas, aber nicht das Entscheidende) **4. Ist er inkonsistent?** (drei Wörter für dieselbe Sache) **5. Ist er unschön?** (egal, wenn 1–4 stimmen).

## Kernregeln

**MUSS:**
1. Namen dürfen nicht lügen: Tut die Funktion mehr/anderes als der Name sagt, wird der Name oder die Funktion geändert. Ein Seiteneffekt, den der Name verschweigt, ist ein struktureller Befund (`skill-clean-code-analysis.md`, Regel 4) — kein Stil-Nit.
2. Fachbegriffe der Domäne verwenden — dieselben Wörter wie Fachbereich und Anforderungen (heißt es dort „Auftrag", heißt es im Code nicht mal `order`, mal `job`, mal `task`). Das Vokabular ist Teil der Verständigung mit den Menschen, die das Soll-Verhalten definieren.
3. Ein Begriff pro Konzept im ganzen Repo: nicht `fetch`/`get`/`load`/`retrieve` gemischt für dasselbe Muster; nicht `qty`/`quantity`/`amount` für dieselbe Größe. Bei Bestandsinkonsistenz: der Mehrheitskonvention folgen (`skill-consistency.md`).
4. Irreführende Restnamen nach Verhaltensänderungen sofort mitziehen: Wenn `sendInvoiceMail` jetzt auch SMS schickt, ist der Name nach dem Merge eine Falle.
5. Booleans als beantwortbare Frage benennen (`isExpired`, `hasAccess`, `canRetry`) — und positiv formulieren (`isActive` statt `isNotInactive`); doppelte Verneinung im Code ist ein Fehlerquell.

**SOLL:**
6. Präzision proportional zur Sichtbarkeit und Lebensdauer: Der Laufindex einer 3-Zeilen-Schleife darf `i` heißen; ein öffentliches API-Feld, eine DB-Spalte, ein Event-Name müssen exakt sein — sie sind fast unrenovierbar (`skill-api-design.md`, `skill-database-thinking.md`).
7. Einheiten und Semantik in den Namen, wo Verwechslung teuer ist: `timeoutMs` statt `timeout`, `priceNet` statt `price`, `createdAtUtc` statt `date`. Die teuersten Namensfehler sind Einheitenfehler.
8. Vage Allzweckwörter (`data`, `info`, `item`, `manager`, `helper`, `util`, `process`, `handle`) als Warnsignal lesen: Meist ist nicht der Name das Problem, sondern die unklare Verantwortung dahinter (`skill-function-design.md`, `skill-module-design.md`).
9. Keine mentale Dekodierung verlangen: Abkürzungen nur, wenn sie im Team etablierter sind als die Langform (SKU, URL ja; `custBalRt` nein). Aussprechbar und suchbar (`grep`-Test: findet man alle Verwendungen über den Namen?).
10. Länge folgt Distanz: kurze Namen für kurze Reichweite, beschreibende für weite. Ein 60-Zeichen-Name ist kein Qualitätsbeweis — oft steckt darin eine Funktion, die zu viel tut.

**KANN:**
11. Beim Lesen fremden Codes gefundene Lügen-Namen dokumentieren (Nebenbefund) und beim nächsten legitimen Anfassen der Datei umbenennen.
12. Domänen-Glossar pflegen, wenn das Fachvokabular strittig oder mehrdeutig ist (ist „Kunde" der Besteller oder der Rechnungsempfänger?).

## Arbeitsablauf

1. **Beim Schreiben:** Erst sagen, was das Ding *ist/tut* (ein Satz), dann den Satz zum Namen verdichten. Fällt der Satz schwer → Verantwortung unklar, erst die klären.
2. **Konvention prüfen:** Wie heißt Vergleichbares im Repo? Domänenwort vorhanden?
3. **Lügen-Check nach Änderungen:** Stimmt jeder Name im Diff noch mit dem Verhalten überein?
4. **Beim Review:** Prüf-Hierarchie anwenden — Lüge/Vagheit = echter Befund mit Szenario; Geschmack = LOW oder weglassen.
5. **Beim Rename:** Wirkradius prüfen (Strings, Reflection, Persistenz, API — `skill-change-impact-analysis.md`), werkzeuggestützt umbenennen, eigener Commit.

## Checkliste

- [ ] Verspricht jeder Name genau das, was das Ding tut (keine verschwiegenen Effekte)?
- [ ] Verwende ich die Fachwörter der Domäne — konsistent mit dem Repo?
- [ ] Sind Einheiten/Semantik enthalten, wo Verwechslung teuer wäre?
- [ ] Booleans als positive Frage formuliert?
- [ ] Keine dekodierpflichtigen Abkürzungen; Namen suchbar?
- [ ] Nach Verhaltensänderung: alle betroffenen Namen mitgezogen?
- [ ] Öffentliche/persistente Namen (API, DB, Events) mit besonderer Sorgfalt gewählt?

## Typische Fehler

- **Die stille Lüge:** `calculateTotal` speichert auch. Der Leser ruft es für eine Vorschau auf — und schreibt Daten (real der teuerste Namensfehler-Typ).
- **Nebel-Namen:** `DataManager.processData(data)` — drei Wörter, null Information. Meist Symptom fehlender Verantwortungsklärung.
- **Einheiten-Roulette:** `delay = 5` — Sekunden? Millisekunden? Der Bug kommt zur Laufzeit.
- **Synonym-Zoo:** `Client`, `Customer`, `Account` für dasselbe Konzept in drei Modulen — jeder neue Leser lernt drei Vokabeln für eine Sache und sucht Unterschiede, die es nicht gibt.
- **Historien-Leichen:** `sendFax()` schickt seit 2019 E-Mails. Jeder Neue lernt es auf die harte Tour.
- **Umbenennung als Blindflug:** Rename über Textersetzung inkl. eines Config-Strings — Produktion findet den Schlüssel nicht mehr.
- **Namens-Bikeshedding im Review:** 20 Minuten Diskussion über `fetchOrders` vs. `loadOrders` (beides fein, Konvention entscheidet), während der lügende Name im selben Diff unkommentiert bleibt.

## Beispiele

**Lüge → Wahrheit:**
```csharp
// vorher: Name verspricht Lesen, Funktion schreibt
Customer getCustomer(int id)        // legt an, wenn nicht vorhanden!
// nachher: ehrlich — und die Entscheidung sichtbar beim Aufrufer
Customer getOrCreateCustomer(int id)
```

**Präzision, wo es zählt:**
```sql
-- vorher: was ist "date", was ist "price"?
CREATE TABLE orders (date DATETIME, price DECIMAL(10,2));
-- nachher: Semantik im Namen, für die nächsten 15 Jahre
CREATE TABLE orders (ordered_at_utc DATETIME2, total_gross_eur DECIMAL(10,2));
```

## Eskalation

- Der treffende Name existiert nicht, weil das Fachkonzept unklar ist („was genau ist hier ein ‚aktiver' Kunde?") → Fachklärung (`skill-requirements-analysis.md`); der Nebel liegt nicht im Code.
- Rename beträfe öffentliche Verträge oder Persistenz → nicht im Vorbeigehen; als Vertragsänderung behandeln (`skill-api-design.md`, `skill-database-thinking.md`).
- Team uneins über Grundvokabular → Glossar-Entscheidung herbeiführen (`skill-decision-records.md`), nicht pro PR neu streiten.
- Systematische Lügen-Namen im Bestand (Modul, wo nichts heißt, wie es sich verhält) → als strukturellen Befund melden; Einzelrenames ohne Verständnis sind dort riskant (`skill-legacy-code-handling.md`).

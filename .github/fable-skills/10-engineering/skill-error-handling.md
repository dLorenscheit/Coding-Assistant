# skill-error-handling

**Version:** 1.0 · **Stand:** 2026-07-02 · **Gültigkeitsbereich:** Umgang mit erwartbaren und unerwarteten Fehlern zur Laufzeit · **Empfohlene Einsatzkontexte:** Jeder Code mit I/O, externen Aufrufen, Nutzerinteraktion

**Kurzfassung:** Jeder Fehler wird bewusst behandelt oder bewusst weitergereicht — nie geschluckt; Fehlermeldungen tragen Kontext für den, der sie nachts liest; Nutzer bekommen verständliche Meldungen, Logs die Details; Retries nur mit Limit und Idempotenz.

## Skill-Name

Fehlerbehandlung

## Zweck

Fehlerbehandlung ist kein lästiger Anhang, sondern die Hälfte des Programms — die Hälfte, die über Produktionsqualität entscheidet. Dieser Skill sorgt dafür, dass Fehler weder verschluckt noch panisch behandelt werden, sondern an der richtigen Stelle mit der richtigen Reaktion: beheben, kompensieren, weiterreichen oder kontrolliert abbrechen.

## Einsatzbereich

- Jeder Code mit I/O, Netzwerk, Datenbank, Dateisystem, Fremd-APIs
- Gestaltung von Fehlermeldungen (Nutzer, Log, API-Antworten)
- Retry-, Timeout- und Fallback-Entscheidungen
- Abgrenzung: Verhindern ungültiger Zustände → `skill-defensive-programming.md`

## Denkweise

Denke wie ein Notfallplaner: Nicht „was, wenn alles gut geht", sondern „was genau passiert bei jedem Ausfall — und wer muss dann was wissen?" Für jeden Fehler gibt es genau vier ehrliche Reaktionen: **behandeln** (hier lösbar), **kompensieren** (Fallback mit bekanntem Preis), **weiterreichen** (mit Kontext angereichert, an die Stelle, die entscheiden kann), **kontrolliert abbrechen** (sauber, laut, ohne halben Zustand). Die fünfte — ignorieren — ist keine Reaktion, sondern eine Zeitbombe.

Merksatz für Junioren: **Ein `catch`-Block ist eine Entscheidung, kein Reflex.** Wer `catch` schreibt, muss die Frage beantworten: „Was kann ich hier Sinnvolles tun, das der Aufrufer nicht besser könnte?" Keine Antwort → nicht fangen.

## Kernregeln

**MUSS:**
1. Kein Fehler wird geschluckt: kein leerer catch-Block, kein `catch` das nur loggt und weiterläuft, als wäre nichts gewesen — außer die Weiterarbeit ist nachweislich korrekt (dann steht die Begründung als Kommentar dran).
2. Fehler nur dort fangen, wo man sinnvoll reagieren kann. Alle anderen weiterreichen — mit Kontext (was wurde versucht, mit welchen Schlüsseldaten), ohne den ursprünglichen Fehler/Stacktrace zu verlieren.
3. Fehlermeldungen adressatengerecht trennen: **Nutzer** bekommen verständlich + handlungsleitend („Datei zu groß, max. 10 MB"), ohne interne Details; **Logs** bekommen alles (Operation, IDs, Parameter, Ursache, Stack). Nie umgekehrt.
4. Keine sensiblen Daten in Fehlermeldungen nach außen (Pfade, SQL, Stacktraces, Secrets, personenbezogene Daten) — Fehlerausgaben sind ein beliebtes Informationsleck.
5. Retries nur mit: begrenzter Anzahl, Backoff, und idempotenter Operation (sonst produziert der Retry Duplikate). Nicht-transiente Fehler (Validierung, 4xx) nie retrien.
6. Bei Abbruch mitten in mehrschrittigen Abläufen darf kein halber Zustand bleiben: Transaktion, Kompensation oder dokumentierter Wiederanlaufpunkt.

**SOLL:**
7. Erwartbare Fachfehler (Gutschein abgelaufen, Bestand leer) von technischen Fehlern (DB weg) im Design unterscheiden — sie haben verschiedene Adressaten und Reaktionen; Fachfehler sind oft Rückgabewerte/Result-Typen, keine Exceptions.
8. Fehlerbehandlung dem Repo-Muster folgen (Exceptions vs. Result-Typen, Fehler-Middleware, Logging-Konventionen) — kein zweites Muster einführen (`skill-consistency.md`).
9. Log-Level ehrlich vergeben: ERROR = jemand muss handeln; WARN = auffällig, beobachten; INFO = Betriebsverlauf. Ein Log voller falscher ERRORs macht echte unsichtbar.
10. Externe Aufrufe: Timeout setzen, Fehlverhalten des Fremdsystems einplanen (langsam, kaputt, lügt) und die eigene Reaktion definieren (Fallback? Abbruch? Queue?).

**KANN:**
11. Zentrale Fehler-Middleware/Handler für die Übersetzung intern → außen (einheitliches Fehlerformat, Korrelations-ID).
12. Fehlerraten als Metrik/Alarm exponieren, wo Betrieb relevant ist (`skill-runbook-writing.md`).

## Arbeitsablauf

1. **Fehlerquellen listen:** Für den Ablauf jeden Punkt notieren, der scheitern kann (I/O, extern, Validierung, Nebenläufigkeit).
2. **Pro Quelle Reaktion wählen:** behandeln / kompensieren / weiterreichen / abbrechen — mit Begründung.
3. **Adressaten bedienen:** Nutzermeldung formulieren, Log-Eintrag mit Kontext definieren, ggf. API-Fehlerformat.
4. **Konsistenz sichern:** Transaktionsgrenzen/Kompensation für mehrschrittige Abläufe festlegen.
5. **Transienz klären:** Was ist retry-würdig? Limits, Backoff, Idempotenz prüfen.
6. **Fehlerpfade testen:** Jeder bewusst behandelte Fehler bekommt einen Test (`skill-testing-strategy.md`).

## Checkliste

- [ ] Gibt es keinen Fehler, der still verschluckt wird?
- [ ] Wird jeder Fehler an der Stelle behandelt, die reagieren kann — sonst mit Kontext weitergereicht?
- [ ] Sind Nutzermeldung (verständlich) und Log (vollständig) getrennt?
- [ ] Leckt keine Fehlerausgabe sensible Interna?
- [ ] Sind Retries begrenzt, mit Backoff und idempotent?
- [ ] Bleibt bei Abbruch kein halber Zustand?
- [ ] Sind die Fehlerpfade getestet?

## Typische Fehler

- **Das leere catch:** `catch (Exception) {}` — der Fehler ist weg, das Problem nicht. Wochen später sucht jemand, warum Daten fehlen.
- **Log-and-forget:** Fehler loggen und normal weiterlaufen. Der Ablauf arbeitet auf kaputtem Zustand weiter; das Log liest niemand rechtzeitig.
- **Catch-all zu früh:** Ganz außen alles fangen und „Ein Fehler ist aufgetreten" zeigen — für den Nutzer nutzlos, fürs Debugging auch, wenn der Kontext unterwegs verloren ging.
- **Stacktrace an den Nutzer:** Interna, Pfade, SQL im Browser. Peinlich bis gefährlich.
- **Blinder Retry:** Validierungsfehler dreimal wiederholen (bleibt falsch) oder Zahlungs-Timeout retrien ohne Idempotenz (bucht doppelt).
- **Exception als Ablaufsteuerung:** Erwartbare Fachfälle („nicht gefunden") als Exception durch drei Schichten werfen — teuer, unleserlich, verstopft Logs.
- **Wrapper-Verlust:** `throw new AppException("Fehler")` ohne inneren Fehler — die Ursache ist für immer weg.

## Beispiele

**Gut (Weiterreichen mit Kontext):**
```csharp
catch (SqlException ex) {
    // Aufrufer entscheidet über Retry/Abbruch; Kontext + Ursache bleiben erhalten
    throw new OrderPersistenceException(
        $"Bestellung {order.Id} für Kunde {order.CustomerId} konnte nicht gespeichert werden", ex);
}
```

**Gut (Adressatentrennung):** API antwortet `422 {"error":"coupon_expired","message":"Dieser Gutschein ist am 30.06. abgelaufen."}`; das Log enthält zusätzlich CouponId, CustomerId, Request-ID. Nutzer versteht, Betrieb kann suchen, nichts leckt.

**Schlecht:** `catch (Exception e) { Log.Warn("Fehler beim Speichern"); return true; }` — Warn statt Error, kein Kontext, und der Aufrufer glaubt an Erfolg.

## Eskalation

- Unklar, was fachlich bei einem Fehlerfall passieren soll (abbrechen? teilverbuchen? melden?) → Produktentscheidung, rückfragen mit Optionen (`skill-requirements-analysis.md`).
- Bestandscode verschluckt systematisch Fehler (leere catches im Dutzend) → nicht still einzeln fixen; als strukturellen Befund mit Risiko melden — hinter jedem kann ein maskierter Produktionsfehler stecken.
- Konsistenz bei mehrschrittigen Abläufen nicht mit Bordmitteln herstellbar (verteilte Transaktion) → Architekturfrage, Entscheidungsvorlage statt Eigenbau.
- Fehlermeldungen nach außen könnten rechtlich/sicherheitsrelevant sein (Datenschutz, Enumeration von Konten) → Security-Review (`skill-security-review.md`).

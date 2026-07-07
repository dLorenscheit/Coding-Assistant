# skill-runbook-writing

**Version:** 1.0 · **Stand:** 2026-07-02 · **Gültigkeitsbereich:** Betriebsanleitungen für Störungen und wiederkehrende Betriebsaufgaben · **Empfohlene Einsatzkontexte:** Produktionssysteme, Nachtjobs, Bereitschaften, Übergabe an Betrieb

**Kurzfassung:** Ein Runbook wird nachts um 3 von jemandem ohne Systemwissen unter Stress benutzt: vom Symptom her strukturieren, exakte kopierbare Befehle mit erwarteter Ausgabe, nach jedem Eingriff ein Verifikationsschritt, klare Eskalationsgrenze („ab hier anrufen: …") — und jeder Schritt ist real durchgespielt, sonst ist es Fiktion.

## Skill-Name

Runbook-Schreiben

## Zweck

Im Störfall entscheidet nicht, wer das System am besten kennt — sondern was die Person vor der Konsole in den nächsten 15 Minuten tut. Ein Runbook konserviert die Handlungskompetenz der Wissenden für den Moment, in dem sie nicht da sind. Es senkt Ausfallzeiten, verhindert Verschlimmbesserungen unter Stress und macht Bereitschaft ohne Heldenwissen möglich.

## Einsatzbereich

- Störungsbehandlung (pro bekanntem Fehlerbild ein Eintrag)
- Wiederkehrende Betriebsaufgaben (Wiederanlauf, Monatslauf, Zertifikatstausch, Restore)
- Pflichtteil von Betriebsübergaben (`skill-handover.md`, Regel 7) und Post-Mortem-Maßnahmen (`skill-root-cause-analysis.md`)

## Denkweise

Schreibe für den **gestressten Fremden nachts um 3**: Er kennt das System kaum, der Druck ist hoch, und Denken unter Stress ist unzuverlässig — deshalb nimmt ihm das Runbook das Denken ab, wo es geht (exakte Befehle, klare Entscheidungen), und sagt ihm ehrlich, wo es endet („ab hier: anrufen"). Jede Formulierung, die Interpretation verlangt („ggf. Dienst neu starten", „prüfen, ob alles ok ist"), ist nachts um 3 eine Falle.

Zweiter Grundsatz: **Der Leser kommt vom Symptom, nicht von der Ursache.** Er sieht „Alarm X" oder „Import hängt" — nicht „Lock-Konkurrenz auf Tabelle Y". Runbooks sind deshalb nach Symptomen/Alarmen indexiert, und jeder Eintrag beginnt dort, wo der Leser steht.

## Kernregeln

**MUSS:**
1. Symptomorientiert gliedern: Einstieg über das, was der Leser sieht (Alarmname, Fehlermeldung wörtlich, beobachtbares Verhalten). Pro Symptom ein Eintrag mit fester Struktur: **Symptom → Sofort-Diagnose (2–3 Checks) → Entscheidung → Maßnahme → Verifikation → Eskalation**.
2. Befehle exakt und kopierbar: vollständige Kommandos mit echten Pfaden/Parametern (Platzhalter klar markiert), dazu die **erwartete Ausgabe** („liefert normalerweise `RUNNING` — wenn `STOPPED`, weiter bei 3b"). Ohne Erwartungswert kann der Leser das Ergebnis nicht deuten.
3. Nach jeder Maßnahme ein Verifikationsschritt: Woran erkennt der Leser, dass es gewirkt hat — und was tut er, wenn nicht? Ein Runbook, das mit der Maßnahme endet, lässt den Leser im Ungewissen zurück.
4. Eskalationsgrenze pro Eintrag: Ab welchem Punkt/Befund wird eskaliert, an wen (Rolle + aktueller Kontaktweg), mit welchen gesammelten Informationen? „Im Zweifel eskalieren" ist Teil der Anleitung, kein Versagen.
5. Jeder Eintrag ist **real durchgespielt** (idealerweise von jemandem, der das System nicht kennt) — auf einer Umgebung, die der Produktion entspricht. Ungetestete Runbooks sind gefährlicher als keine: Sie erzeugen Selbstvertrauen ohne Grundlage (`skill-documentation-writing.md`, Regel 3 — hier mit Störfall-Verschärfung).
6. Gefährliche Schritte markieren: Was ist destruktiv/nicht umkehrbar (Restore überschreibt, Queue-Purge verwirft)? Davor: Stopp-Hinweis + Rückfrage-Pflicht („nur nach Freigabe durch X") — nachts um 3 werden sonst Daten gelöscht, weil Schritt 4 so harmlos aussah.

**SOLL:**
7. Sofort-Stabilisierung vor Ursachenforschung anbieten, wo es sie gibt (Feature abschalten, auf Replika umschalten, Job pausieren) — inklusive der Folgen der Stabilisierung („Kunden sehen dann X") und der Beweissicherung davor (Logs kopieren, `skill-root-cause-analysis.md`, Regel 1).
8. Aktualität an Änderungen koppeln: Wer Deployment-Pfade, Dienste, Alarme ändert, zieht das Runbook im selben Arbeitsgang nach; „geprüft am"-Datum pro Eintrag. Nach jedem echten Einsatz: 10 Minuten Nachpflege (was fehlte, was war falsch?).
9. Auffindbarkeit im Störfall sichern: verlinkt aus dem Alarm/Monitoring selbst, erreichbar auch wenn das betroffene System down ist (nicht im System dokumentieren, das gerade brennt).
10. Kurz halten: Ein Eintrag passt auf 1–2 Bildschirme. Hintergrundwissen gehört in die Architektur-Doku (verlinken, `skill-architecture-documentation.md`) — im Störfall liest niemand Konzepte.

**KANN:**
11. Sammelstellen für „bekannte Eigenheiten" führen (Fehlbilder, die harmlos sind und keine Aktion brauchen) — sie ersparen nächtliche Fehleingriffe.
12. Runbook-Einsätze protokollieren lassen (was wurde wann ausgeführt) — Gold für das Post-Mortem und die nächste Verbesserung.

## Arbeitsablauf

1. **Fehlerbilder sammeln:** aus Alarmen, Vorfällen, Support-Historie — die realen, nicht die theoretischen.
2. **Pro Symptom den Eintrag schreiben:** feste Struktur (Regel 1), exakte Befehle mit Erwartungswerten, Gefahren markieren.
3. **Eskalationswege klären:** Rollen, Kontaktwege, Übergabe-Informationen.
4. **Durchspielen lassen:** von einem Nicht-Kenner, auf produktionsnaher Umgebung; Stolperstellen einarbeiten.
5. **Verankern:** aus Alarmen verlinken, außerhalb des Systems hosten, „geprüft am" setzen.
6. **Leben lassen:** nach jedem Einsatz und jeder Systemänderung nachziehen.

## Checkliste

- [ ] Ist jeder Eintrag vom Symptom her erreichbar (Alarmname, wörtliche Fehlermeldung)?
- [ ] Sind alle Befehle kopierbar und mit erwarteter Ausgabe versehen?
- [ ] Folgt auf jede Maßnahme eine Verifikation (+ „wenn nicht"-Pfad)?
- [ ] Steht die Eskalationsgrenze mit Rolle und Kontaktweg drin?
- [ ] Sind destruktive Schritte markiert und freigabepflichtig?
- [ ] Wurde jeder Eintrag von einem Nicht-Kenner real durchgespielt?
- [ ] Ist das Runbook erreichbar, wenn das System selbst down ist?
- [ ] Wird es nach Einsätzen und Änderungen nachgepflegt?

## Typische Fehler

- **Erklärtext statt Anleitung:** Drei Absätze Systemarchitektur, dann „danach sollte der Import neu gestartet werden" — wie, womit, woran erkennt man Erfolg? Nachts um 3 unbrauchbar.
- **Interpretations-Anweisungen:** „Prüfen, ob die Queue auffällig voll ist" — was ist auffällig? Zahl nennen („> 10.000 = auffällig").
- **Ungetestete Fiktion:** Der Restore-Abschnitt, den noch nie jemand ausgeführt hat. Beim ersten Ernstfall stellt sich heraus: Schritt 2 braucht ein Recht, das die Bereitschaft nicht hat.
- **Happy-Path-Runbook:** Maßnahme beschrieben, aber nicht, was bei Misserfolg — der Leser steht nach Schritt 5 schlechter da als vorher: Zeit weg, Zustand verändert, keine Führung mehr.
- **Veraltete Befehle:** Der Dienst heißt seit dem Umbau anders; das Runbook startet ins Leere. Vertrauen weg — ab da improvisieren alle wieder.
- **Doku im brennenden Haus:** Das Runbook liegt im Wiki, das hinter dem SSO hängt, das gerade down ist.
- **Helden-Annahme:** „Dann Klaus fragen" als Schritt 6. Klaus ist im Urlaub; genau dafür gibt es das Runbook.

## Beispiele

**Guter Eintrag (verkürzt):**
> ### Alarm: `IMPORT-STALLED` (Nachtimport hängt > 30 min)
> **Symptom:** Alarm um ~03:15; Dashboard „Import" zeigt letzten Fortschritt vor > 30 min.
> **Diagnose:**
> 1. `svc-status data-import` → erwartet `RUNNING`. Bei `STOPPED` → weiter bei **A**.
> 2. `db-locks --table=staging_orders` → erwartet `0 locks`. Bei ≥ 1 → weiter bei **B**.
> **A (Dienst gestoppt):** `svc-start data-import` → Verifikation: Dashboard-Fortschritt steigt binnen 5 min. Wenn nicht → Eskalation.
> **B (Lock-Konkurrenz, bekannt: Kollision mit Backup Di/Do):** ⚠️ Kein Kill von DB-Sessions ohne Freigabe! `job-pause nightly-backup` → Verifikation wie A. Backup danach wieder aktivieren: `job-resume nightly-backup`.
> **Eskalation:** Kein Fortschritt nach 20 min oder anderes Fehlbild → Bereitschaft Daten-Team (Rufplan im Bereitschafts-Board), mitgeben: Ausgaben von Schritt 1+2, Log `import-YYYYMMDD.log` (vorher sichern).
> *Geprüft am 2026-06-12 (Durchspiel: M., ohne Systemvorwissen).*

## Eskalation

- Beim Schreiben zeigt sich: Für ein Fehlerbild gibt es keine sichere Standardreaktion (jede Maßnahme braucht Systemwissen) → nicht in Pseudo-Anweisungen pressen; ehrlich „sofort eskalieren an X" dokumentieren und das als Betriebsrisiko melden (Bus-Faktor, `skill-risk-analysis.md`).
- Durchspielen scheitert an fehlenden Rechten/Zugängen der Bereitschaft → Zugangs-Lücke ist der Befund; vor dem nächsten Ernstfall schließen (`skill-handover.md`, Zugänge).
- Restore/Recovery-Pfade sind nicht testbar (keine Umgebung) → als kritisches Risiko eskalieren — ein ungetesteter Restore ist Schrödingers Backup.
- Runbook-Einsatz zeigt neues, unbekanntes Fehlerbild → nach der Stabilisierung Post-Mortem (`skill-root-cause-analysis.md`) und neuen Eintrag; das Runbook wächst aus echten Nächten.

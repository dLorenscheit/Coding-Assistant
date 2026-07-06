# skill-security-review

**Version:** 1.0 · **Stand:** 2026-07-02 · **Gültigkeitsbereich:** Sicherheitsprüfung von Code und Änderungen (defensiv) · **Empfohlene Einsatzkontexte:** Auth, Nutzereingaben, DB-Zugriffe, Datei-Operationen, externe Aufrufe, Zahlungen

**Kurzfassung:** Systematisch prüfen statt hoffen: Eingaben (Injection), Berechtigungen (pro Ressource, serverseitig), Secrets (nie im Code/Log), Datenabfluss (Fehlermeldungen, Logs) — Denkweise „was würde ein Angreifer mit diesem Endpunkt tun?", CRITICAL-Funde blockieren sofort.

## Skill-Name

Security-Review (defensiv)

## Zweck

Sicherheitslücken entstehen selten durch exotische Angriffe, sondern durch Alltagsfehler: die vergessene Berechtigungsprüfung, der zusammengesetzte SQL-String, das Secret im Repo. Dieser Skill macht die Prüfung dieser Alltagsfehler systematisch — als festen Bestandteil von Entwicklung und Review, nicht als jährliches Audit.

## Einsatzbereich

- Pflicht bei Änderungen an: Authentifizierung/Autorisierung, Nutzereingaben, DB-Queries, Dateisystem-Operationen, externen API-Aufrufen, Kryptographie, Zahlungs-/Personendaten
- Sicherheitsblick im normalen Code-Review (`skill-code-review.md`, Regel 6)
- Bewertung von Alt-Systemen auf Grundrisiken

## Denkweise

Wechsle die Perspektive: Der Entwickler fragt „funktioniert es für den Nutzer?", der Security-Blick fragt: **„Was kann jemand damit tun, der nicht der vorgesehene Nutzer ist — oder der vorgesehene Nutzer mit bösen Absichten?"** Jeder Endpunkt, jeder Parameter, jede Datei ist aus dieser Perspektive ein Angebot: Was passiert, wenn ich fremde IDs einsetze, Sonderzeichen schicke, den Schritt davor überspringe, es 10.000-mal aufrufe?

Grundhaltung: **Misstrauen ist an der Grenze billig, hinter der Grenze teuer.** Deshalb dieselbe Grenzlogik wie in `skill-defensive-programming.md` — plus die Frage, die dort fehlt: Nicht nur „sind die Daten gültig?", sondern „darf *dieser* Aufrufer *diese* Ressource *so* benutzen?"

## Kernregeln

**MUSS:**
1. **Autorisierung pro Ressource, serverseitig:** Bei jedem Zugriff prüfen, ob der authentifizierte Aufrufer genau dieses Objekt sehen/ändern darf — nicht nur, ob er eingeloggt ist. (Die häufigste echte Lücke: `GET /invoices/4711` liefert fremde Rechnungen, weil nur Login geprüft wird.) UI-seitiges Verstecken ist keine Prüfung.
2. **Injection ausschließen:** SQL/Query nur parametrisiert — nie mit Stringverkettung aus Eingaben. Gleiche Regel für OS-Kommandos, LDAP, XPath. Ausgaben in HTML/JS kontextgerecht escapen (XSS); `innerHTML`/`dangerouslySetInnerHTML` nur mit Sanitizer.
3. **Secrets nie im Code, Repo, Log oder Fehlermeldung.** Bezug aus Umgebung/Secret-Manager; beim Fund eines exponierten Secrets: sofort melden und rotieren — Löschen aus der Historie genügt nicht.
4. **Pfade aus Eingaben kanonisieren und gegen ein Wurzelverzeichnis prüfen** (Path Traversal: `../../etc/passwd`). Dateinamen vom Nutzer nie direkt verwenden.
5. **Kein Krypto-Eigenbau:** Passwörter nur mit etablierten, langsamen Hashes (bcrypt/argon2-Klasse), Vergleiche zeitkonstant, TLS für Transport, etablierte Bibliotheken statt selbstgebauter Verschlüsselung.
6. **Fehler- und Logausgaben abdichten:** keine Stacktraces/SQL/Pfade nach außen; keine Passwörter, Tokens, vollständigen Personendaten in Logs; Login-Fehler ohne Unterscheidung „Nutzer existiert nicht" vs. „Passwort falsch" (Account-Enumeration).
7. **CRITICAL-Funde blockieren:** ausnutzbare Lücke oder exponiertes Secret → Merge/Release stoppen, sofort melden (`skill-code-review.md`, Eskalation).

**SOLL:**
8. Least Privilege: DB-Nutzer, API-Tokens, Service-Accounts nur mit den Rechten, die der Anwendungsfall braucht — kein `db_owner` für die Reporting-App.
9. Ratenbegrenzung/Brute-Force-Schutz auf Login, Passwort-Reset, teuren Endpunkten.
10. Eingabevalidierung als Whitelist (was ist erlaubt) statt Blacklist (was ist verboten) — Blacklists verlieren immer.
11. Abhängigkeiten mit bekannten Lücken im Blick behalten (Dependency-Audit im Build); veraltete Krypto/Frameworks als Befund melden.
12. Massenzuweisung kontrollieren: Eingabe-DTOs explizit auf erlaubte Felder mappen — nie Request-Body direkt in Entitäten binden (sonst setzt jemand `isAdmin:true`).

**KANN:**
13. Für kritische Flüsse einen Missbrauchsfall pro Feature notieren („Wie würde ich das ausnutzen?") und als Test verankern.
14. Security-Header/CSP und Framework-Schutzmechanismen (CSRF-Token) prüfen, wo Web-UI im Spiel ist.

## Arbeitsablauf

1. **Angriffsfläche bestimmen:** Welche Eingänge/Assets berührt die Änderung (Endpunkte, Parameter, Dateien, Queries, Secrets, personenbezogene Daten)?
2. **Pro Eingang die Kernfragen:** Wer darf das (AuthZ pro Ressource)? Was passiert mit den Eingaben (Injection, Pfade, Größe)? Was fließt zurück (Fehler, Daten anderer)?
3. **Checkliste Regel 1–6 abarbeiten** — mit Codebeleg pro Punkt, nicht per Augenschein.
4. **Funde einstufen:** ausnutzbar (CRITICAL, blockiert) / schwächend (HIGH) / Härtung (MEDIUM). Mit konkretem Missbrauchsszenario, wie überall: Beleg statt Bauchgefühl.
5. **Beheben und verankern:** Fix + Test des Missbrauchsfalls; bei Secrets: Rotation.

## Checkliste

- [ ] Wird bei jedem Objektzugriff serverseitig geprüft, ob genau dieser Aufrufer genau dieses Objekt darf?
- [ ] Sind alle Queries parametrisiert, alle Ausgaben kontextgerecht escaped?
- [ ] Keine Secrets in Code, Config im Repo, Logs, Fehlermeldungen?
- [ ] Nutzerkontrollierte Pfade/Dateinamen kanonisiert und eingesperrt?
- [ ] Kein selbstgebautes Krypto; Passwörter korrekt gehasht?
- [ ] Fehlerausgaben und Logs frei von Interna und sensiblen Daten?
- [ ] Eingabe-DTOs explizit gemappt (keine Massenzuweisung)?
- [ ] Rechte der technischen Konten minimal?

## Typische Fehler

- **AuthN mit AuthZ verwechseln:** „Ist eingeloggt" prüfen und „darf dieses Objekt" vergessen — die IDOR-Lücke (Insecure Direct Object Reference), Dauerbrenner Nummer eins.
- **Validierung nur im Frontend:** Der Angreifer benutzt kein Frontend, er benutzt curl.
- **Secrets „nur kurz" committen:** Einmal in der Git-Historie = kompromittiert. Rotieren, nicht nur löschen.
- **Blacklist-Filter:** `<script>` filtern und `<img onerror=…>` vergessen. Whitelist oder kontextgerechtes Escaping.
- **Interne Fehler nach außen:** Stacktrace verrät Framework-Version, Pfade, Queries — die Einkaufsliste des Angreifers.
- **„Internes Tool, braucht keine Security":** Interne Tools haben Produktionszugriff und die schwächsten Prüfungen — beliebtestes Sprungbrett.
- **Sicherheitsgefühl durch Obskurität:** „Die URL kennt ja niemand." URLs stehen in Logs, Proxies, Browserverläufen.

## Beispiele

**Fund (CRITICAL), korrekt berichtet:**
> `InvoiceController.cs:57` — `GET /api/invoices/{id}` lädt die Rechnung nur per ID, ohne Abgleich mit `CurrentUser.CustomerId`. Szenario: eingeloggter Kunde iteriert IDs und liest fremde Rechnungen (personenbezogene Daten + Beträge). CRITICAL → blockiert. Fix: Ownership-Check in der Query (`WHERE customer_id = @current`), Test mit fremder ID → 404.

**Fund (HIGH):**
> `ReportRepo.cs:120` — `"SELECT … WHERE name LIKE '%" + search + "%'"`. Injection über das Suchfeld möglich. Fix: Parameter + Escaping der LIKE-Wildcards.

## Eskalation

- Ausnutzbare Lücke in Produktion oder exponiertes Secret → sofort an Verantwortliche, Rotation/Abschaltung vor Ursachenanalyse; Beweise sichern.
- Unsicherheit bei Krypto-, Protokoll- oder Compliance-Fragen (DSGVO-Auslegung, Aufbewahrung) → Fachperson einbeziehen; „wird schon passen" gibt es hier nicht.
- Lücke im Fremdsystem/Framework entdeckt → verantwortungsvoll an den Hersteller melden, nicht öffentlich dokumentieren; eigene Kompensation prüfen.
- Fix erfordert Breaking Change (z. B. alle Tokens invalidieren) → Entscheidung mit Risiko-Gegenüberstellung an die Verantwortlichen — Sicherheit vor Bequemlichkeit, aber Menschen entscheiden über Nutzer-Impact.

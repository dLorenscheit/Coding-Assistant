# install-fable.ps1 — installiert das Fable-Skill-System PROJEKTLOKAL in ein Zielprojekt.
#
# Seit Layout 4.0 liegt alles unter .github\ (natives GitHub-Copilot-Layout) - manuell genuegt daher:
#   .github\ aus dem Fable-Repo ins Zielprojekt kopieren.
# Dieses Skript macht dasselbe, aber sicher und idempotent:
#   - ueberschreibt keine fremden Dateien in .github\ (nur agents\ + fable-skills\)
#   - haengt bei vorhandener Projekt-copilot-instructions.md nur den Fable-Block an (nie doppelt)
#   - warnt bei Altlasten aus dem Vorgaenger-Layout (<Projekt>\.copilot\, <Projekt>\fable-skills\)
#
# Nutzung (aus dem Fable-Skills-Ordner heraus):
#   powershell -File .\install-fable.ps1 -Target "<Pfad zum Zielprojekt>"
#
# Erneut ausfuehren, um ein Projekt nach Aenderungen im Fable-Repo zu aktualisieren
# (Kopien werden ersetzt; die Projekt-copilot-instructions.md bleibt unangetastet).

param(
    [Parameter(Mandatory = $true)]
    [string]$Target
)

$ErrorActionPreference = 'Stop'

$sourceRoot   = $PSScriptRoot
$agentsSource = Join-Path $sourceRoot '.github\agents'
$skillsSource = Join-Path $sourceRoot '.github\fable-skills'

# --- Quelle und Zielprojekt pruefen ------------------------------------------

foreach ($src in @($agentsSource, $skillsSource)) {
    if (-not (Test-Path $src)) {
        Write-Error "Quellordner fehlt im Fable-Repo: $src"
        exit 1
    }
}

if (-not (Test-Path $Target)) {
    Write-Error "Zielprojekt nicht gefunden: $Target"
    exit 1
}
$targetRoot = (Resolve-Path $Target).Path

$srcNorm = $sourceRoot.TrimEnd('\').ToLower()
$tgtNorm = $targetRoot.TrimEnd('\').ToLower()
if ($tgtNorm -eq $srcNorm -or $tgtNorm.StartsWith($srcNorm + '\')) {
    Write-Error "Zielprojekt liegt im Fable-Skills-Ordner selbst - hier ist nichts zu installieren."
    exit 1
}

# --- 1. Skills -> <Projekt>\.github\fable-skills\ (komplett ersetzen) --------

$skillsTarget = Join-Path $targetRoot '.github\fable-skills'
if (Test-Path $skillsTarget) {
    Remove-Item -Path $skillsTarget -Recurse -Force
}
New-Item -ItemType Directory -Force -Path (Join-Path $targetRoot '.github') | Out-Null
Copy-Item -Path $skillsSource -Destination (Join-Path $targetRoot '.github') -Recurse -Force
Write-Host "Skills + INDEX.md + Betriebsanleitung -> $skillsTarget"

# --- 2. Custom Agents -> <Projekt>\.github\agents\ (nur eigene Dateien) ------

$agentsTarget = Join-Path $targetRoot '.github\agents'
$agents = Get-ChildItem -Path $agentsSource -Filter '*.agent.md'
if ($agents.Count -eq 0) {
    Write-Error "Keine Agenten-Dateien in $agentsSource gefunden."
    exit 1
}

New-Item -ItemType Directory -Force -Path $agentsTarget | Out-Null
foreach ($agent in $agents) {
    Copy-Item -Path $agent.FullName -Destination (Join-Path $agentsTarget $agent.Name) -Force
}
Write-Host "$($agents.Count) Custom Agents -> $agentsTarget"

# --- 3. Projekt-copilot-instructions.md (anlegen bzw. Fable-Block anhaengen) -

$projectInstructions = Join-Path $targetRoot '.github\copilot-instructions.md'
$marker = '## Fable-Agent (aktiv'
$block = @'

## Fable-Agent (aktiv — GitHub Copilot)

Dieses Projekt betreibt das **Fable-Skill-System** als tokeneffizienten Coding-Agenten. Diese Datei wird von GitHub Copilot bei **jedem** Prompt automatisch geladen und ist der verbindliche Einstieg.

### Pflicht zu Sitzungsbeginn

Lies **einmalig** die vollständige Betriebsanleitung `.github/fable-skills/FABLE-AGENT.md` und befolge sie für die gesamte Sitzung. Findest du den Ordner nicht auf Anhieb, suche per Glob nach `**/fable-skills/FABLE-AGENT.md` bzw. `**/INDEX.md`.

**FABLE_SKILLS_ROOT:** `.github/fable-skills/` — alle Skill-Pfade sind relativ dazu. Die 8 Fachrollen sind echte VS-Code-Custom-Agents unter `.github/agents/*.agent.md` — aufrufbar per `#agent`-Erwähnung im Chat oder über den Agenten-Picker.
'@

if (Test-Path $projectInstructions) {
    $existing = Get-Content -Path $projectInstructions -Raw
    if ($existing -like "*$marker*") {
        Write-Host "Projekt-copilot-instructions.md enthaelt den Fable-Block bereits - unveraendert."
    } else {
        Add-Content -Path $projectInstructions -Value $block -Encoding UTF8
        Write-Host "Fable-Block an bestehende Projekt-copilot-instructions.md angehaengt."
    }
} else {
    Copy-Item -Path (Join-Path $sourceRoot '.github\copilot-instructions.md') -Destination $projectInstructions -Force
    Write-Host "Projekt-copilot-instructions.md aus Vorlage angelegt."
}

# --- 4. Altlasten aus Vorgaenger-Layouts melden ------------------------------

$oldCopilotDir = Join-Path $targetRoot '.copilot'
if (Test-Path $oldCopilotDir) {
    Write-Host "HINWEIS: Altes Layout gefunden: $oldCopilotDir - wird nicht mehr benutzt und kann nach Pruefung geloescht werden."
}
$oldCopilotMd = Join-Path $targetRoot 'COPILOT.md'
if (Test-Path $oldCopilotMd) {
    Write-Host "HINWEIS: Alte COPILOT.md gefunden: $oldCopilotMd - Inhalte pruefen und danach loeschen (ersetzt durch .github\copilot-instructions.md)."
}
$oldSkills = Join-Path $targetRoot 'fable-skills'
if (Test-Path $oldSkills) {
    Write-Host "HINWEIS: Sehr altes Layout gefunden: $oldSkills - wird nicht mehr benutzt und kann nach Pruefung geloescht werden."
}

Write-Host ""
Write-Host "Fable-Agent projektlokal installiert in: $targetRoot"
Write-Host "Verfuegbar nach dem naechsten Start von GitHub Copilot im Zielprojekt."

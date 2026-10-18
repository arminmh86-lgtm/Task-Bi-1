# Agentic Development Context

## Goal
Build a polished, portfolio-ready Microsoft Power BI report for retrospective analysis of the 2026 FIFA World Cup dataset supplied by the user. Prefer maintainable Power Query transformations, explicit semantic-model relationships, reusable DAX measures, and documented report design.

## Baseline
The repository was empty when inspected. No agent instructions, prompts, coding standards, pipelines, data model, or reports were available to inherit. This file establishes the first-party development context.

## Constraints and principles
- Deliver this repo as a **Power BI Desktop implementation kit**, not a generated `.pbix` binary. Power BI Desktop is required to finish the native report.
- The user requested the Kaggle dataset. Queries use the dataset publisher's public CSV mirror to avoid Kaggle credentials.
- Attribute the dataset and do not call it an official FIFA feed. Its data has not been independently audited by this project.
- Preserve names and accents using UTF-8.
- Convert missing optional numbers to null rather than inventing values.
- Distinguish scoreline goals from penalty shootout decisions. Goal KPIs use scoreline goals; outcome calculations use penalty scores when the match is tagged as a penalty-shootout result.
- Do not invent attendance, ticket sales, revenue, or other unprovided fields.
- Keep calculations transparent and reusable.

## Data sources
- Kaggle: https://www.kaggle.com/datasets/mominullptr/fifa-world-cup-2026-dataset
- Dataset repository: https://github.com/mominullptr/FIFA-World-Cup-2026-Dataset
- CSV mirror base: https://mominullptr.github.io/FIFA-World-Cup-2026-Dataset/

## Model intent
- `Matches`: one row per match.
- `TeamMatchFacts`: two rows per match, one for each participating team.
- `Teams` filters `TeamMatchFacts`, `Players`, and `MatchTeamStats`.
- `Matches` filters `TeamMatchFacts` and `MatchEvents`.
- `Players` filters `PlayerStats` and `MatchEvents`.
- `Venues` and `TournamentStages` filter `Matches`.
- Prefer single-direction filtering from dimensions to facts to avoid ambiguous filter paths.

## Design intent
Use a dark navy canvas, lime primary accent, muted cyan and restrained coral. Prioritize readability, meaningful hierarchy, units, concise titles, tooltips, and cross-filtering. See `powerbi/Report-Blueprint.md`.

## Definition of done
- Queries load without errors and preserve missing values as null.
- Relationships match `powerbi/Relationships.md`.
- Core DAX measures evaluate correctly.
- Team/date/stage filter behavior is tested.
- Source attribution and dataset verification caveat remain visible.
- Refresh is tested in Power BI Desktop before publishing.

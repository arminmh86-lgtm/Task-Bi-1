# FIFA World Cup 2026 — Power BI Analytics Dashboard

A Power BI Desktop starter project for a retrospective analysis of the 2026 FIFA World Cup dataset published by [mominullptr on Kaggle](https://www.kaggle.com/datasets/mominullptr/fifa-world-cup-2026-dataset).

> **Data note:** This project consumes a community-maintained dataset and its public CSV mirror. The publisher describes it as a completed 104-match tournament dataset; this project does not independently certify the match results as official FIFA data. Verify key facts against official sources before publication.

## Project contents

- Power Query M templates for matches, teams, stages, venues, players, player stats, events, match-team stats, and derived team-match facts.
- DAX measures for tournament, team, player, and match-stat analysis.
- A dark stadium-inspired report theme.
- Report blueprint, relationship map, source instructions, and agentic development context.

## Build the report

The repository initially contained no files; this commit establishes the baseline project. This is a **Power BI implementation kit**, not a native `.pbix` binary. Use Power BI Desktop to create and save the report:

1. Create a blank report.
2. For each `.pq` file under `powerbi/PowerQuery/`, create a Blank Query, paste the file contents into Advanced Editor, and rename it to the filename without `.pq`.
3. Apply `powerbi/WorldCup2026Theme.json` through **View → Themes → Browse for themes**.
4. Create the relationships documented in `powerbi/Relationships.md`.
5. Add the measures from `powerbi/Measures.dax`.
6. Build the three pages described in `powerbi/Report-Blueprint.md`.
7. Refresh and QA the model before publishing.

## Dataset

- Kaggle: https://www.kaggle.com/datasets/mominullptr/fifa-world-cup-2026-dataset
- Dataset repository: https://github.com/mominullptr/FIFA-World-Cup-2026-Dataset
- Public CSV mirror used by Power Query: https://mominullptr.github.io/FIFA-World-Cup-2026-Dataset/

The mirror avoids a Kaggle API token and remains attributable to the dataset publisher. See `data/README.md` for local CSV loading options and refresh caveats.

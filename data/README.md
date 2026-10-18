# Data and refresh

## Default source: direct public CSV files
Power Query templates use the publisher's CSV files directly from the upstream GitHub repository:

`https://raw.githubusercontent.com/mominullptr/FIFA-World-Cup-2026-Dataset/main/`

This avoids a Kaggle API token. Select **Refresh** in Power BI Desktop to reload the latest available version.

## Alternative: download from Kaggle
1. Download the ZIP from https://www.kaggle.com/datasets/mominullptr/fifa-world-cup-2026-dataset
2. Extract the CSV files locally.
3. Replace the `Web.Contents(...)` source step in each `.pq` query with:
   `Csv.Document(File.Contents("C:\\path\\to\\file.csv"), [Delimiter=",", Encoding=65001, QuoteStyle=QuoteStyle.Csv])`
4. Keep the transformations after the source step.

## Tables used
| Power BI query | Source file | Purpose |
| --- | --- | --- |
| Matches | matches_detailed.csv | Match scores, teams, date, stage, venue and xG |
| Teams | teams.csv | Groups, confederations, pre-tournament rank, ELO |
| TournamentStages | tournament_stages.csv | Stage names and knockout flag |
| Venues | venues.csv | Stadiums, location, capacity, elevation and coordinates |
| Players | squads_and_players.csv | Squad details and market value |
| PlayerStats | player_stats.csv | Tournament-level player statistics |
| MatchTeamStats | match_team_stats.csv | Possession, shots, corners, fouls and saves |
| MatchEvents | match_events.csv | Goal/card/VAR and other events |
| TeamMatchFacts | derived from Matches | One row per team per match |

## Source integrity
This is a community-maintained dataset. Treat its content as dataset records, not automatically verified official data. Check key match results and player statistics against official sources before publishing factual claims.

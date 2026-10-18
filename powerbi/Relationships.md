# Semantic model relationships

Create these relationships in Model view. Use single-direction filtering from the dimension/one side to the fact/many side.

| One side | Many side | Cardinality | Purpose |
| --- | --- | --- | --- |
| `Matches[match_id]` | `TeamMatchFacts[match_id]` | One-to-many | Match/date/stage filters affect both team rows |
| `Teams[team_name]` | `TeamMatchFacts[team_name]` | One-to-many | Team slicers filter team match results |
| `TournamentStages[stage_name]` | `Matches[stage_name]` | One-to-many | Stage filters matches and team facts |
| `Venues[stadium_name]` | `Matches[stadium_name]` | One-to-many | Venue filters matches and team facts |
| `Teams[team_id]` | `Players[team_id]` | One-to-many | Team filters player roster |
| `Players[player_id]` | `PlayerStats[player_id]` | One-to-one (verify uniqueness) | Player dimension filters player stats |
| `Players[player_id]` | `MatchEvents[player_id]` | One-to-many | Player filters events |
| `Teams[team_id]` | `MatchTeamStats[team_id]` | One-to-many | Team filters available team stats |
| `Matches[match_id]` | `MatchEvents[match_id]` | One-to-many | Match filters event timeline |

## Important notes
- `TeamMatchFacts` contains two rows per match. Use `DISTINCTCOUNT(TeamMatchFacts[match_id])` for match KPIs.
- Team goal totals use scoreline goals; shootout kicks do not increase tournament goals. The derived result uses shootout scores when `result_type = "Penalties"` and penalty scores are present.
- `MatchTeamStats` is related to Teams only in this starter model to avoid an alternate filter path through Matches. It will respond to team selections but not date/stage filters. If you need date-specific team metrics, merge it into `TeamMatchFacts` first.
- Confirm `PlayerStats[player_id]` uniqueness after refresh. If the source has duplicates, clean it or deliberately use one-to-many.

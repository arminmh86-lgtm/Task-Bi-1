# Report blueprint — FIFA World Cup 2026

## Design system
- Canvas: `#08111F`; visual surfaces: `#101D30`
- Primary accent: lime `#D7F75B`; secondary accent: cyan `#56D6D1`; highlight: coral `#FF8A5B`
- 16:9 layout, generous spacing, concise titles and clear units. Avoid dense borders and unnecessary legends.
- Apply `WorldCup2026Theme.json`.

## Page 1 — Tournament Overview
**Header:** FIFA WORLD CUP 2026 · Tournament review · Dataset snapshot.

**Filters:** `Matches[date]` (Between), `TournamentStages[stage_name]` (Dropdown), `Teams[team_name]` (Dropdown). Team filters affect team-grain facts; they do not change home/away fields on Matches directly.

**KPI cards:** Matches Analyzed, Total Goals, Goals per Match, Total Expected Goals, Match Events.

**Visuals**
1. Column chart — Total Goals by TournamentStages[stage_name]. Sort by tournament stage order.
2. Line chart — Match Count (Match Table) by Matches[date], visual-filtered to Completed.
3. Bar chart — teams by Total Goals, Top N 10.
4. Match table — date, stage, home team, score, away team, stadium, result type.

## Page 2 — Team Performance
**Filters:** team, confederation, group, stage, date.

**KPI cards:** Team Matches Played, Matches Won, Matches Drawn, Matches Lost, Goal Difference, Win Rate, Clean Sheets.

**Visuals**
1. Horizontal bar — Total Goals by team.
2. Scatter — Total Expected Goals vs. Total Goals, team name as detail.
3. Matrix — team rows and stage columns; Total Goals, Goal Difference, Win Rate.
4. Fixture table — date, opponent, goals for/against, xG, outcome.
5. Team metrics — possession %, total shots, shots on target, corners and fouls from MatchTeamStats. These are filtered by team, not by date/stage, in the starter model.

## Page 3 — Player Spotlight
**Filters:** team, position, player name.

**KPI cards:** Player Goals, Player Assists, Player Goal Contributions, Player Minutes, Yellow Cards, Red Cards.

**Visuals**
1. Top scorers bar chart — Player Goals by player; Top N 10.
2. Player table — name, team, position, goals, assists, minutes, matches played, rating, yellow/red cards.
3. Squad value chart — team by Squad Market Value (€M).
4. Goalkeeper table — saves, goals conceded, clean sheets; filter position to GK.
5. Event timeline — MatchEvents[minute] by event_type, with match/player context.

## Formatting and QA
- Hide technical IDs from report view.
- Format goals/matches/minutes/cards as whole numbers, xG to 2 decimals, win rate/shot accuracy as percentages, squad value in € millions.
- Conditional formatting sparingly: lime positive, coral negative, cyan comparisons.
- Add descriptive alt text and meaningful tooltip pages where useful.
- Test team, date and stage filters. In particular, Teams filters TeamMatchFacts but does not filter the home/away fields in Matches.
- Footer: `Source: mominullptr World Cup 2026 dataset on Kaggle; community-maintained, not independently validated by this report.`

let
    SourceMatches = Matches,
    Keep = Table.SelectColumns(SourceMatches, {
        "match_id", "date", "stage_name", "stadium_name", "city", "country",
        "home_team_name", "away_team_name", "home_score", "away_score",
        "home_penalty_score", "away_penalty_score", "home_xg", "away_xg", "status", "result_type"
    }),
    HomeRenamed = Table.RenameColumns(Keep, {
        {"home_team_name", "team_name"}, {"away_team_name", "opponent_name"},
        {"home_score", "team_goals"}, {"away_score", "opponent_goals"},
        {"home_xg", "team_xg"}, {"away_xg", "opponent_xg"}
    }),
    HomeWithSide = Table.AddColumn(HomeRenamed, "team_side", each "Home", type text),
    HomeDecisionTeam = Table.AddColumn(HomeWithSide, "decision_team_goals", each if [result_type] = "Penalties" and [home_penalty_score] <> null then [home_penalty_score] else [team_goals], Int64.Type),
    HomeDecisionOpp = Table.AddColumn(HomeDecisionTeam, "decision_opponent_goals", each if [result_type] = "Penalties" and [away_penalty_score] <> null then [away_penalty_score] else [opponent_goals], Int64.Type),

    AwayRenamed = Table.RenameColumns(Keep, {
        {"away_team_name", "team_name"}, {"home_team_name", "opponent_name"},
        {"away_score", "team_goals"}, {"home_score", "opponent_goals"},
        {"away_xg", "team_xg"}, {"home_xg", "opponent_xg"}
    }),
    AwayWithSide = Table.AddColumn(AwayRenamed, "team_side", each "Away", type text),
    AwayDecisionTeam = Table.AddColumn(AwayWithSide, "decision_team_goals", each if [result_type] = "Penalties" and [away_penalty_score] <> null then [away_penalty_score] else [team_goals], Int64.Type),
    AwayDecisionOpp = Table.AddColumn(AwayDecisionTeam, "decision_opponent_goals", each if [result_type] = "Penalties" and [home_penalty_score] <> null then [home_penalty_score] else [opponent_goals], Int64.Type),

    Combined = Table.Combine({HomeDecisionOpp, AwayDecisionOpp}),
    AddOutcome = Table.AddColumn(Combined, "result", each
        if [status] <> "Completed" or [decision_team_goals] = null or [decision_opponent_goals] = null then "Not played"
        else if [decision_team_goals] > [decision_opponent_goals] then "Win"
        else if [decision_team_goals] < [decision_opponent_goals] then "Loss"
        else "Draw", type text),
    Final = Table.SelectColumns(AddOutcome, {
        "match_id", "date", "stage_name", "stadium_name", "city", "country",
        "team_name", "opponent_name", "team_goals", "opponent_goals", "team_xg", "opponent_xg",
        "status", "result_type", "team_side", "result"
    })
in
    Final

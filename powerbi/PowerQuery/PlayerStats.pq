let
    Source = Csv.Document(
        Web.Contents("https://raw.githubusercontent.com/mominullptr/FIFA-World-Cup-2026-Dataset/main/", [RelativePath = "player_stats.csv"]),
        [Delimiter = ",", Encoding = 65001, QuoteStyle = QuoteStyle.Csv]
    ),
    Headers = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
    Typed = Table.TransformColumns(Headers, {
        {"player_id", each try Int64.From(_) otherwise null, Int64.Type},
        {"team_id", each try Int64.From(_) otherwise null, Int64.Type},
        {"matches_played", each try Int64.From(_) otherwise null, Int64.Type},
        {"matches_started", each try Int64.From(_) otherwise null, Int64.Type},
        {"minutes_played", each try Int64.From(_) otherwise null, Int64.Type},
        {"goals", each try Int64.From(_) otherwise null, Int64.Type},
        {"assists", each try Int64.From(_) otherwise null, Int64.Type},
        {"shots", each try Int64.From(_) otherwise null, Int64.Type},
        {"shots_on_target", each try Int64.From(_) otherwise null, Int64.Type},
        {"yellow_cards", each try Int64.From(_) otherwise null, Int64.Type},
        {"red_cards", each try Int64.From(_) otherwise null, Int64.Type},
        {"penalty_goals", each try Int64.From(_) otherwise null, Int64.Type},
        {"own_goals", each try Int64.From(_) otherwise null, Int64.Type},
        {"clean_sheets", each try Int64.From(_) otherwise null, Int64.Type},
        {"saves", each try Int64.From(_) otherwise null, Int64.Type},
        {"goals_conceded", each try Int64.From(_) otherwise null, Int64.Type},
        {"average_rating", each try Number.From(_) otherwise null, type number},
        {"last_verified", each try Date.From(_) otherwise null, type date}
    })
in
    Typed

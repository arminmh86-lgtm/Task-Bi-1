let
    Source = Csv.Document(
        Web.Contents(
            "https://raw.githubusercontent.com/mominullptr/FIFA-World-Cup-2026-Dataset/main/match_team_stats.csv"
        ),
        [
            Delimiter = ",",
            Encoding = 65001,
            QuoteStyle = QuoteStyle.Csv
        ]
    ),

    Headers = Table.PromoteHeaders(
        Source,
        [PromoteAllScalars = true]
    ),

    Typed = Table.TransformColumns(
        Headers,
        {
            {"match_id", each try Int64.From(_) otherwise null, Int64.Type},
            {"team_id", each try Int64.From(_) otherwise null, Int64.Type},
            {"possession_pct", each try Number.From(_) otherwise null, type number},
            {"total_shots", each try Int64.From(_) otherwise null, Int64.Type},
            {"shots_on_target", each try Int64.From(_) otherwise null, Int64.Type},
            {"corners", each try Int64.From(_) otherwise null, Int64.Type},
            {"fouls", each try Int64.From(_) otherwise null, Int64.Type},
            {"offsides", each try Int64.From(_) otherwise null, Int64.Type},
            {"saves", each try Int64.From(_) otherwise null, Int64.Type},
            {"last_updated", each try Date.From(_) otherwise null, type date}
        }
    ),

    Trimmed = Table.TransformColumns(
        Typed,
        {
            {"player_of_the_match", each if _ is text then Text.Trim(_) else _, type text},
            {"data_source", each if _ is text then Text.Trim(_) else _, type text}
        }
    )
in
    Trimmed

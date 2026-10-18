let
    Source = Csv.Document(
        Web.Contents(
            "https://raw.githubusercontent.com/mominullptr/FIFA-World-Cup-2026-Dataset/main/matches_detailed.csv"
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
            {"date", each try Date.From(_) otherwise null, type date},
            {"kickoff_time_utc", each try Time.From(_) otherwise null, type time},
            {"home_score", each try Int64.From(_) otherwise null, Int64.Type},
            {"away_score", each try Int64.From(_) otherwise null, Int64.Type},
            {"home_penalty_score", each try Int64.From(_) otherwise null, Int64.Type},
            {"away_penalty_score", each try Int64.From(_) otherwise null, Int64.Type},
            {"home_xg", each try Number.From(_) otherwise null, type number},
            {"away_xg", each try Number.From(_) otherwise null, type number}
        }
    ),

    Trimmed = Table.TransformColumns(
        Typed,
        {
            {"stage_name", each if _ is text then Text.Trim(_) else _, type text},
            {"stadium_name", each if _ is text then Text.Trim(_) else _, type text},
            {"home_team_name", each if _ is text then Text.Trim(_) else _, type text},
            {"away_team_name", each if _ is text then Text.Trim(_) else _, type text},
            {"status", each if _ is text then Text.Trim(_) else _, type text}
        }
    )
in
    Trimmed

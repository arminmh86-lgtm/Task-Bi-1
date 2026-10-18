let
    Source = Csv.Document(
        Web.Contents("https://mominullptr.github.io/FIFA-World-Cup-2026-Dataset/", [RelativePath = "match_team_stats.csv"]),
        [Delimiter = ",", Encoding = 65001, QuoteStyle = QuoteStyle.Csv]
    ),
    Headers = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
    Typed = Table.TransformColumns(Headers, {
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
    })
in
    Typed

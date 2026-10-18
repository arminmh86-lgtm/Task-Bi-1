let
    Source = Csv.Document(
        Web.Contents("https://raw.githubusercontent.com/mominullptr/FIFA-World-Cup-2026-Dataset/main/", [RelativePath = "squads_and_players.csv"]),
        [Delimiter = ",", Encoding = 65001, QuoteStyle = QuoteStyle.Csv]
    ),
    Headers = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
    Typed = Table.TransformColumns(Headers, {
        {"player_id", each try Int64.From(_) otherwise null, Int64.Type},
        {"team_id", each try Int64.From(_) otherwise null, Int64.Type},
        {"market_value_eur", each try Number.From(_) otherwise null, type number},
        {"caps", each try Int64.From(_) otherwise null, Int64.Type},
        {"date_of_birth", each try Date.From(_) otherwise null, type date},
        {"height_cm", each try Int64.From(_) otherwise null, Int64.Type},
        {"goals", each try Int64.From(_) otherwise null, Int64.Type}
    })
in
    Typed

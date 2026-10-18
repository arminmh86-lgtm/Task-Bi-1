let
    Source = Csv.Document(
        Web.Contents("https://raw.githubusercontent.com/mominullptr/FIFA-World-Cup-2026-Dataset/main/", [RelativePath = "match_events.csv"]),
        [Delimiter = ",", Encoding = 65001, QuoteStyle = QuoteStyle.Csv]
    ),
    Headers = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
    Typed = Table.TransformColumns(Headers, {
        {"event_id", each try Int64.From(_) otherwise null, Int64.Type},
        {"match_id", each try Int64.From(_) otherwise null, Int64.Type},
        {"minute", each try Int64.From(_) otherwise null, Int64.Type},
        {"team_id", each try Int64.From(_) otherwise null, Int64.Type},
        {"player_id", each try Int64.From(_) otherwise null, Int64.Type}
    }),
    CleanType = Table.TransformColumns(Typed, {{"event_type", each if _ is text then Text.Trim(_) else _, type text}})
in
    CleanType

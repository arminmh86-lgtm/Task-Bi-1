let
    Source = Csv.Document(
        Web.Contents("https://mominullptr.github.io/FIFA-World-Cup-2026-Dataset/", [RelativePath = "tournament_stages.csv"]),
        [Delimiter = ",", Encoding = 65001, QuoteStyle = QuoteStyle.Csv]
    ),
    Headers = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
    Typed = Table.TransformColumns(Headers, {
        {"stage_id", each try Int64.From(_) otherwise null, Int64.Type},
        {"is_knockout", each try Logical.From(_) otherwise null, type logical}
    })
in
    Typed

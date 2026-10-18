let
    Source = Csv.Document(
        Web.Contents("https://mominullptr.github.io/FIFA-World-Cup-2026-Dataset/", [RelativePath = "venues.csv"]),
        [Delimiter = ",", Encoding = 65001, QuoteStyle = QuoteStyle.Csv]
    ),
    Headers = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
    Typed = Table.TransformColumns(Headers, {
        {"venue_id", each try Int64.From(_) otherwise null, Int64.Type},
        {"capacity", each try Int64.From(_) otherwise null, Int64.Type},
        {"latitude", each try Number.From(_) otherwise null, type number},
        {"longitude", each try Number.From(_) otherwise null, type number},
        {"elevation_meters", each try Int64.From(_) otherwise null, Int64.Type}
    })
in
    Typed

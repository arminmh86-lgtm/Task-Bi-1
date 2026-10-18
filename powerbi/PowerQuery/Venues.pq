let
    Source = Csv.Document(
        Web.Contents("https://raw.githubusercontent.com/mominullptr/FIFA-World-Cup-2026-Dataset/main/", [RelativePath = "venues.csv"]),
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

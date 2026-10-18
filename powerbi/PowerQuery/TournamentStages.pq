let
    Source = Csv.Document(
        Web.Contents(
            "https://raw.githubusercontent.com/mominullptr/FIFA-World-Cup-2026-Dataset/main/tournament_stages.csv"
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
            {"stage_id", each try Int64.From(_) otherwise null, Int64.Type},
            {"is_knockout", each try Logical.From(_) otherwise null, type logical}
        }
    ),

    Trimmed = Table.TransformColumns(
        Typed,
        {
            {"stage_name", each if _ is text then Text.Trim(_) else _, type text}
        }
    )
in
    Trimmed

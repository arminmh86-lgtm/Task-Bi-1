let
    Source = Csv.Document(
        Web.Contents("https://mominullptr.github.io/FIFA-World-Cup-2026-Dataset/", [RelativePath = "teams.csv"]),
        [Delimiter = ",", Encoding = 65001, QuoteStyle = QuoteStyle.Csv]
    ),
    Headers = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
    Typed = Table.TransformColumns(Headers, {
        {"team_id", each try Int64.From(_) otherwise null, Int64.Type},
        {"fifa_ranking_pre_tournament", each try Int64.From(_) otherwise null, Int64.Type},
        {"elo_rating", each try Int64.From(_) otherwise null, Int64.Type}
    }),
    Trimmed = Table.TransformColumns(Typed, {
        {"team_name", each if _ is text then Text.Trim(_) else _, type text},
        {"fifa_code", each if _ is text then Text.Trim(_) else _, type text},
        {"group_letter", each if _ is text then Text.Trim(_) else _, type text},
        {"confederation", each if _ is text then Text.Trim(_) else _, type text}
    })
in
    Trimmed

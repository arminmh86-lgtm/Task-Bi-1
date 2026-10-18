let
    // Load the public CSV directly. This avoids base-URL/RelativePath issues in some Power Query setups.
    Source = Csv.Document(
        Web.Contents("https://raw.githubusercontent.com/mominullptr/FIFA-World-Cup-2026-Dataset/main/teams.csv"),
        [Delimiter = ",", Encoding = 65001, QuoteStyle = QuoteStyle.Csv]
    ),
    Headers = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),

    // Keep the key/ranking fields numeric; return null instead of throwing on a blank or nonnumeric cell.
    Typed = Table.TransformColumns(Headers, {
        {"team_id", each try Int64.From(_) otherwise null, Int64.Type},
        {"fifa_ranking_pre_tournament", each try Int64.From(_) otherwise null, Int64.Type},
        {"elo_rating", each try Int64.From(_) otherwise null, Int64.Type}
    }),

    // Trim text columns while preserving nulls.
    Trimmed = Table.TransformColumns(Typed, {
        {"team_name", each if _ is text then Text.Trim(_) else _, type text},
        {"fifa_code", each if _ is text then Text.Trim(_) else _, type text},
        {"group_letter", each if _ is text then Text.Trim(_) else _, type text},
        {"confederation", each if _ is text then Text.Trim(_) else _, type text}
    })
in
    Trimmed
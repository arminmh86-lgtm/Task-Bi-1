"""Lightweight structural checks for locally downloaded source CSV files.

Usage:
    python scripts/validate_dataset.py data/raw

This does not certify official accuracy.
"""
from __future__ import annotations
import csv
import sys
from pathlib import Path

EXPECTED = {
    "matches_detailed.csv": ["match_id", "date", "stage_name", "home_team_name", "away_team_name", "home_score", "away_score", "status"],
    "teams.csv": ["team_id", "team_name", "fifa_code", "group_letter"],
    "squads_and_players.csv": ["player_id", "team_id", "player_name", "position"],
    "player_stats.csv": ["player_id", "team_id", "player_name", "goals", "assists"],
    "match_events.csv": ["event_id", "match_id", "minute", "event_type"],
}

def read_csv(path: Path):
    with path.open("r", encoding="utf-8-sig", newline="") as f:
        reader = csv.DictReader(f)
        return reader.fieldnames or [], list(reader)

def main() -> int:
    folder = Path(sys.argv[1]) if len(sys.argv) > 1 else Path("data/raw")
    if not folder.is_dir():
        print(f"ERROR: folder does not exist: {folder}")
        print("Download the Kaggle ZIP and extract the CSV files, then pass their folder here.")
        return 2
    failed = False
    for filename, required in EXPECTED.items():
        path = folder / filename
        if not path.exists():
            print(f"WARN: missing {filename} (optional for this structural check)")
            continue
        headers, rows = read_csv(path)
        missing = [name for name in required if name not in headers]
        key = "match_id" if filename == "matches_detailed.csv" else ("team_id" if filename == "teams.csv" else "player_id" if filename in {"squads_and_players.csv", "player_stats.csv"} else "event_id")
        values = [row.get(key, "").strip() for row in rows]
        duplicates = len(values) - len({value for value in values if value})
        print(f"{filename}: {len(rows):,} rows; {len(headers)} columns")
        if missing:
            failed = True
            print(f"  ERROR: missing columns: {', '.join(missing)}")
        if duplicates:
            failed = True
            print(f"  ERROR: {duplicates:,} duplicate nonblank values in {key}")
        if not rows:
            print("  WARN: file is empty")
    print("\nStructural validation only; compare key tournament facts with official sources before publication.")
    return 1 if failed else 0

if __name__ == "__main__":
    raise SystemExit(main())

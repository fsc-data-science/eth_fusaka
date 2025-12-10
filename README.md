# Ethereum Transaction Fees: Historical Analysis

> **An application of the [TRACE Content Template](https://github.com/fsc-data-science/trace_content_template)** for analyzing Ethereum transaction fees over time against major network milestones.

## Overview

This analysis tracks **median weekly Ethereum transaction fees** (in ETH and USD) from January 2020 through present day, overlaid with key protocol upgrades and ecosystem events:

| Milestone | Date | Impact on Fees |
|-----------|------|----------------|
| Beacon Chain | Dec 2020 | Proof-of-stake launch |
| Arbitrum | May 2021 | First major L2 rollup |
| EIP-1559 | Aug 2021 | Fee burn mechanism |
| Optimism | Dec 2021 | Optimistic rollup launch |
| The Merge | Sep 2022 | PoW → PoS transition |
| Dencun (Blobs) | Mar 2024 | EIP-4844 blob transactions |
| Pectra | May 2025 | Account abstraction |
| Fusaka | Dec 2025 | (Upcoming) |

## Key Findings

- **Peak fees**: ~$26 median during Nov 2021 bull market
- **Post-Dencun collapse**: Fees dropped 90%+ as L2s adopted blob transactions
- **Current state**: Sub-$0.10 median fees, lowest in Ethereum's history

## Repository Structure

```
eth_fusaka/
├── REPORT.html                              # Final standalone HTML report
├── trace-metadata.json                      # TRACE website metadata
├── queries/
│   └── 01_median_weekly_tx_fees.sql         # Snowflake SQL query
├── data/
│   └── 01_median_weekly_tx_fees.json        # Query results (311 weeks)
├── visuals/
│   └── MULTI-LINE_median_weekly_tx_fees.html # Highcharts visualization
└── utils/
    └── swap_placeholder.py                  # Build utility for report assembly
```

## Data Source

All data queried from [Flipside Crypto](https://flipsidecrypto.xyz/) via the Flipside MCP tools:
- `ethereum.core.fact_transactions` — transaction fees
- `ethereum.price.ez_prices_hourly` — ETH/USD prices

## Usage

### View the Report

Open `REPORT.html` in any browser, or view via GitHub raw:

```
https://raw.githubusercontent.com/fsc-data-science/eth_fusaka/main/REPORT.html
```

### Rebuild with Fresh Data

1. Install [UV](https://github.com/astral-sh/uv):
   ```bash
   curl -LsSf https://astral.sh/uv/install.sh | sh
   ```

2. Re-run the query via Flipside MCP and save to `data/01_median_weekly_tx_fees.json`

3. Inject data into visual:
   ```bash
   uv run python utils/swap_placeholder.py visuals/MULTI-LINE_median_weekly_tx_fees.html "{{DATA_01}}" data/01_median_weekly_tx_fees.json
   ```

4. Rebuild the final report using placeholders as documented in `INSTRUCTIONS.md`

## About TRACE

This repository follows the [TRACE Content Template](https://github.com/fsc-data-science/trace-content-template) pattern:
- **1 QUERY = 1 DATA** (1:1 relationship)
- **1 DATA = 1+ VISUAL** (1:many relationship)
- **Self-contained HTML reports** with embedded data and visualizations

## License

MIT

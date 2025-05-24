![Version](https://img.shields.io/static/v1?label=export-select-bibtex-entries&message=0.1&color=brightcolor)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

# Export selected BibTeX entries from a master BibTeX to a second BibTeX file from inside Emacs

## Problem addressed

If you maintain a master or global BibTeX file of all your BibTeX entries, it may be too large to load into an LLM if it has 600-800 or more entries.
It will exceed the LLM's context limits.
This Emacs package enables the exporting of subsets of BibTeX entries that are selected by keywords.

## Usage
If there are multiple keywords, they are separated by semicolons.
A keyword can be a multi-word phrase.
With more than one keyword, the keywords can be joined by simple Boolean AND/OR logic.
You will be prompted to select which logic term you want to use.

You will be prompted for the name and path of the exported BibTeX file.
The number of exported entries will be reported in the mini buffer as a message.

## Installation

You can test out this file by opening it up in an Emacs new buffer and then evaluating the buffer: `M-x eval-buffer`.

You can install this file using the straight package or any other approach to installing locally installed packages.


## Update history
|Version      | Changes                                                                                                                                                                         | Date                 |
|:-----------|:------------------------------------------------------------------------------------------------------------------------------------------|:--------------------|
| Version 0.1 |   Added badges, funding, and update table.  Initial commit.                                                                                                                | 05/23/2025  |
| Version 0.1.1 | Corrected a minor minor bug. Updated README.md.                                                                                                                            |05/24/2025 |

## Sources of funding
- NIH: R01 CA242845
- NIH: R01 AI088011
- NIH: P30 CA225520 (PI: R. Mannel)
- NIH: P20 GM103640 and P30 GM145423 (PI: A. West)

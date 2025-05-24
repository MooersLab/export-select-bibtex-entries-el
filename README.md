![Version](https://img.shields.io/static/v1?label=export-select-bibtex-entries&message=0.1&color=brightcolor)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

# Export Select BibTeX Entries From Inside Emacs

## Problem addressed

If you maintain a master or global BibTeX file of all your BibTeX entries, it may be too large to load into an LLM if it has 600-800 or more entries.
It will exceed the LLM's context limits.
This Emacs package enables the exporting of subsets of BibTeX entries that are selected by keywords.
I find this faster to do from inside Emacs than with a GUI-driven interface to your master BibTeX file.


## Overview

This Emacs package streamlines the management of extensive BibTeX bibliographies by enabling selective extraction of references based on keyword criteria. 
These selected subsets can be easier to work with when building a BibTeX collection for a specific manuscript or annotated bibliography.
These selected subsets of BibTeX entries are also helpful when working with AI-powered writing assistants or large language models (LLMs).
The latter have limited context windows and cannot handle BibTeX files with thousands of entries.
Using these subsets of entries is easier than training an LLM on your corpus of files.
This tool addresses that challenge by creating focused subsets of BibTeX entries tailored to meet specific research needs or when working with AI chatbots.

This package is a sophisticated filter for your reference library, similar to how a librarian might pull relevant books from different sections based on your research topic.
This package intelligently selects BibTeX entries that match your specified criteria.

## Key Capabilities

### Intelligent Reference Filtering
- Extract entries using keyword searches across configurable field sets
- Support for complex multi-word search phrases
- Boolean logic operations (AND/OR) for combining multiple search terms
- Flexible field targeting for precision filtering

### Enhanced Export Features
- Customizable export destinations of the selected BibTeX entries with user-defined paths
- Real-time feedback displaying the count of extracted entries
- Seamless integration with existing Emacs workflows

### AI-Enhanced Reference Management
- Optimized for integration with modern AI writing assistants
- Context-aware subset creation for improved LLM interactions


## Installation Methods

### Test run
1. Clone this repository.
2. Load the file `exportbib.el` into a new buffer.
3. Before using, set the path to your master BibTeX library file and reevaluate the updated buffer:

```emacs-lisp
defvar bibexport-bibtex-master-file "~/Documents/global.bib"
```

4. Evaluate this buffer:

```emacs-lisp
M-x eval-buffer
```

5. Get list of interactive functions in the minibuffer by entering exportbib-  (Presumably, you are using the vertico and orderless packages).
You should see one interactive function. Select it and answer the series of prompts for information.

```emacs-lisp
exportbib-export-bibtex-entries-by-multikeywords
```

## Install with the `use-package` and `straight` packages

Add this to your `init.el` file and reload Emacs or evaluate in the scratch buffer.
Straight will `git clone` this repo and store it in the `repos` subfolder of your `.emacs.d` folder.
You have to run `straight-pull-all` to pull any updates.

```elisp
(use-package bibexport
  :straight  
  '(:type git  
    :repo "https://github.com/MooersLab/export-select-bibtex-entries-el.git"  
    :files ("bibexport.el")))
```
The functions will always be available.


## Install of manually downloaded package

Edit the paths of this function to suit.
Add to your `init.el` file or evaluate the function in your scratch buffer for a quick start.
Inspired https://sachachua.com/dotemacs/index.html#org4dd39d0.

```elisp
(defun exportbib-functions-load ()  
  "Load exportbib.el file."  
  (interactive)  
  (let ((file-path "~/6112MooersLabGitHubLabRepos/export-select-bibtex-entries-el/exportbib.el"))  
    (if (file-exists-p (expand-file-name file-path))  
        (load-file file-path)  
      (message "Cannot find exportbib.el file"))))
```

## Usage Workflow

### Basic Operation Steps
1. Launch the selection interface: =M-x export-select-bibtex-entries=
2. Specify your search keywords (separate multiple terms with semicolons)
3. Configure field targeting options (title, author, year, keywords, etc.)
4. Select Boolean logic for multi-keyword searches (AND/OR operations)
5. Choose your preferred export format
6. Define the output file path and name
7. Review the extraction summary in the minibuffer

### Practical Example
```
Keywords: machine learning; neural networks
Fields: title, abstract, keywords
Logic: OR
Output: ~/research/ml-references.bib
Result: 247 entries exported
```

## Advanced Features

### Complex searches
- A keyword can be a multi-word phrase.
- If there are multiple keywords, they are separated by semicolons.
- With more than one keyword, the keywords can be joined by simple Boolean AND/OR logic.
  
### Flexible Field Selection
Target specific bibliographic fields to refine your searches:
- Author names and affiliations
- Publication titles and abstracts
- Journal names and conference proceedings
- Publication years and date ranges
- Keywords and subject classifications
- DOI identifiers and URLs

## Development and Contributions

### Contributing Guidelines
We encourage community contributions to enhance this tool's functionality:
1. Fork the repository to your GitHub account.
2. Create a dedicated feature branch for your modifications.
3. Implement your improvements with clear, documented code.
4. Commit changes with descriptive messages.
5. Submit a pull request detailing your enhancements.

### Feature Requests and Issues
- Open an issue under the Issues tab for technical problems or feature suggestions



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

;;; bibexport.el --- A collection of functions to export a subset of bibtex entries.

;; Copyright (C) 2025 Blaine Mooers and the University of Oklahoma Health Sciences Center Board of Regents

;; Author: blaine-mooers@ouhsc.edu
;; Maintainer: blaine-mooers@ouhsc.edu
;; URL: https://github.com/MooersLab/export-select-bibtex-entries-el
;; Version: 0.1
;; Keywords: 
;; License: MIT
;; Updated 2025 May 24

;;; This package is known to work (insofar as it's tested) with Emacs 30.1.



(defvar bibexport-bibtex-master-file "~/Documents/global.bib"
  "Path to the master BibTeX file used for exporting entries.")

(defvar bibexport-bibtex-search-fields '("author" "title" "abstract" "keywords" "date" "annote")
  "List of BibTeX fields to search, in addition to the full entry.")

(defun bibexport-bibtex-count-entries-in-buffer ()
  "Return the number of BibTeX entries in the current buffer.
Entries are counted by occurrences of ^@."
  (save-excursion
    (goto-char (point-min))
    (let ((count 0))
      (while (re-search-forward "^@" nil t)
        (setq count (1+ count)))
      count)))

(defun bibexport-export-bibtex-entries-by-multikeywords (keywords search-type search-fields export-file)
  "Export BibTeX entries from master file matching multi-word KEYWORDS.
KEYWORDS: Phrases separated by semicolons, e.g., \"deep learning; plant gene\"
SEARCH-TYPE: 'and or 'or.
SEARCH-FIELDS: List of BibTeX fields to search, or 'all for full entry.
EXPORT-FILE: Destination file."
  (interactive
   (list
    (read-string "Keyword phrase(s) to search (separate by semicolon ';'): ")
    (intern (completing-read "Search type (AND/OR): " '("and" "or") nil t "or"))
    (completing-read "Search fields (comma-separated) or 'all': "
                     (cons "all" my/bibtex-search-fields) nil t "all")
    (read-file-name "Export to bib file: ")))
  (unless (file-exists-p my/bibtex-master-file)
    (error "Master bib file '%s' does not exist" my/bibtex-master-file))
  (let* ((phrase-list (mapcar #'string-trim
                              (split-string keywords ";" t "[ \t\n\r]+")))
         (case-fold-search t)
         (search-fields (if (string= search-fields "all")
                           '("") ; Search full entry
                         (split-string search-fields "," t "[ \t]+"))))
    (with-temp-buffer
      (insert-file-contents my/bibtex-master-file)
      (goto-char (point-min))
      (let ((entries '()))
        (while (re-search-forward "^@" nil t)
          (let ((entry-start (match-beginning 0))
                entry-end)
            (if (re-search-forward "^@" nil t)
                (setq entry-end (match-beginning 0))
              (setq entry-end (point-max)))
            (let ((entry (buffer-substring-no-properties entry-start entry-end)))
              (when (cl-some (lambda (phrase)
                              (cl-some (lambda (field)
                                        (if (string= field "")
                                            (string-match-p (regexp-quote phrase) entry)
                                          (string-match-p (regexp-quote phrase)
                                                          (bibtex-extract-field field entry))))
                                      search-fields))
                            phrase-list)
                (push (string-trim-right entry) entries)))))
        (if entries
            (with-temp-buffer
              (insert (mapconcat #'identity (nreverse entries) "\n\n"))
              (insert "\n")
              (write-region (point-min) (point-max) export-file)
              ;; Now count entries in newly written file
              (let ((count (my/bibtex-count-entries-in-buffer)))
                (message "Exported %d entries to %s" count export-file)))
          (message "No entries found matching %S" phrase-list))))))

;; Usage:
;; - Set `bibexport-bibtex-master-file`
;; - Run via M-x bibexport-export-bibtex-entries-by-multikeywords
;; - Supply multi-word phrases (semicolon-separated), select AND/OR, choose search fields, and export file

(provide 'bibexport)

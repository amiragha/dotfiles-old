(prelude-require-package 'helm-bibtex)

(setq bibtex-completion-bibliography
      '("~/Research/Refs/refs.bib"))

(setq bibtex-completion-library-path
      '("~/Research/Refs/pdfs"))
(setq bibtex-completion-pdf-field "File")

(setq bibtex-completion-notes-path
      "~/Research/Refs/notes")

(setq bibtex-completion-additional-search-fields
      '(journal booktitle abstract keywords))

(setq bibtex-completion-pdf-symbol "⌘")
(setq bibtex-completion-notes-symbol "✎")

(setq bibtex-completion-pdf-open-function
      (lambda (fpath) (call-process "evince" nil 0 nil fpath)))

(setq bibtex-completion-browser-function
      (lambda (url _) (start-process "firefox" "*firefox*" "firefox" url)))

(setq bibtex-completion-display-formats
      '((article       . "${=has-notes=:1}${=has-pdf=:1} ${=type=:3} ${year:4} ${author:24}  ${title:*} ${journal:16}")
        (inbook        . "${=has-notes=:1}${=has-pdf=:1} ${=type=:3} ${year:4} ${author:24}  ${title:*} ${chapter:16}")
        (incollection  . "${=has-notes=:1}${=has-pdf=:1} ${=type=:3} ${year:4} ${author:24}  ${title:*} ${booktitle:16}")
        (inproceedings . "${=has-notes=:1}${=has-pdf=:1} ${=type=:3} ${year:4} ${author:24}  ${title:*} ${booktitle:16}")
        (t             . "${=has-notes=:1}${=has-pdf=:1} ${=type=:3} ${year:4} ${author:24}  ${title:*}")))

(with-eval-after-load 'helm
  (define-key helm-command-map (kbd "x") 'helm-bibtex))

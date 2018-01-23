;;; personal.el --- personal stuff to add to emacs prelude

;;; Commentary:
;;

;;; Code:

;; Add a custom class for latex export org mode
(with-eval-after-load 'ox-latex
  (add-to-list 'org-latex-classes
               '("amirnotes"
                 "\\documentclass{../amirnotes}"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))

;; Enabling CDLatex for org mode-line

(add-hook 'org-mode-hook 'turn-on-org-cdlatex)
;; (add-to-list 'cdlatex-math-modify-alist '(?o "\\operatorname" nil t t nil))

;;(defvar cdlatex-math-modify-alist)
;;add-tocdlatex-math-modify-alist
       ;;'('(111 "\\operatorname" nil t t nil)))
;; (defvar cdlatex-math-modify-alist-comb)
;; (with-eval-after-load 'cd-latex
;;   (add-to-list 'cdlatex-math-modify-alist-comb

;;                '(111 "\\operatorname" nil t t nil)))
;; Add custom commands to cd-latex
;; (eval-after-load "cdlatex.el"
;;   (add-to-list 'cdlatex-math-modify-alist-comb
;;                                       '(111 "\\operatorname" nil t t nil))
;;   )

;; (add-hook ')

;; (cdlatex-reset-mode)
;; (add-to-list 'cdlatex-math-mod
;;              (116 "\\text" nil t t nil))


;; Adding packages
(prelude-require-packages '(julia-mode yasnippet elpy))

;; Enabling yasnippet global mode
(yas-global-mode +1)

;; multiple cursor package, there are some more useful features
(prelude-require-package 'multiple-cursors)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; transparency!!
;; (set-frame-parameter (selected-frame) 'alpha '(90 . 50))
;; (add-to-list 'default-frame-alist '(alpha . (90 . 50)))

;; keychain package -- doesn't work here !!!
(prelude-require-package 'keychain-environment)
(keychain-refresh-environment)

;; Add outline-minor-mode emacs
(add-hook 'LaTeX-mode-hook 'outline-minor-mode)

(provide 'personal)

;;; personal.el ends here

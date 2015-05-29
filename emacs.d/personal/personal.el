;;; personal.el --- personal stuff to add to emacs prelude

;;; Commentary:
;;

;;; Code:

;; Enabling CDLatex for org mode-line
(add-hook 'org-mode-hook 'turn-on-org-cdlatex)

;; Adding packages
(prelude-require-package 'yasnippet)

;; Enabling yasnippet global mode
(yas-global-mode +1)

(provide 'personal)

;;; personal.el ends here

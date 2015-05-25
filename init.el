;;; init.el --- Where all the magic begins

;; Author: Darlan Cavalcante Moreira <darcamo@gmail.com>

;;; Commentary:

;; This file loads Org-mode and then loads the rest of our Emacs
;; initialization from Emacs lisp embedded in literate Org-mode files.

;;; Code:

;; xxxxxxxxxx Tell you how long .emacs takes to load xxxxxxxxxxxxxxxxxxxxxx
;; A funtion for that is already implemented in emacs.
;; Just call the emacs-init-time function
;; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

;; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;; xxxxxxxxxxxxxxx Emacs Packages xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
(setq package-enable-at-startup nil)
(with-eval-after-load "package"
  (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
  (add-to-list 'package-archives '("ELPA" . "http://tromey.com/elpa/"))
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (add-to-list 'package-archives '("elpy" . "http://jorgenschaefer.github.io/packages/"))
  ;;(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
  )
(package-initialize)

;; xxxxxxxxxx Load CEDET xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;; you must place this *before* any CEDET component (including EIEIO) gets
;; activated by another package (Gnus, auth-source, ...).
;; (load-file "~/.emacs.d/lisp/cedet/cedet-devel-load.el")
;; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

;; xxxxx Add Some directories to the load-path xxxxxxxxxxxxxxxxxxxxxxxxxxxx
;; Local Version of Org-mode. We add it to the beginning of the load path
;; so that it takes precedence over the org-mode installed with emacs.
(add-to-list 'load-path "~/Org-mode-dev/org-mode/lisp")
(add-to-list 'load-path "~/Org-mode-dev/org-mode/contrib/lisp")
(let ((default-directory  "~/Org-mode-dev/org-mode"))
      (setq load-path
            (append
             (let ((load-path (copy-sequence load-path))) ;; Shadow
               (normal-top-level-add-subdirs-to-load-path))
             load-path)))

;; Since various packages store information in ~/.emacs.d/, it is unwise to
;; add all of its sub-directories to ‘load-path’. Above we only added the
;; sub-directory lisp to avoid loading files that aren’t libraries.
;;
;; The Code below add the ~/.emacs.d/lisp and its subfolders to the END of
;; the load-path
(let ((default-directory "~/.emacs.d/lisp"))
  (normal-top-level-add-to-load-path '("."))
  (normal-top-level-add-subdirs-to-load-path)
)

;; The Code below add the ~/.emacs.d/lisp and its subfolders to the
;; BEGINNING of the load-path
;; (let ((default-directory "~/.emacs.d/lisp/"))
;;   (setq load-path
;;         (append
;;          (let ((load-path (copy-sequence load-path))) ;; Shadow
;;            (append
;;             (copy-sequence (normal-top-level-add-to-load-path '(".")))
;;             (normal-top-level-add-subdirs-to-load-path)))
;;          load-path)))


;; This need to be set BEFORE org-mode is loaded. That's why it is here and
;; not in a section related to org-mode in the initemacs.org file.
;; (setq org-modules
;;       '(org-bbdb
;;         ;; org-gnus
;;         org-info
;;         ;; org-jsinfo
;;         ;; org-irc
;;         ;; org-w3m
;;         org-id
;;         org-habit
;;         ;; org-bibtex
;;         ;; org-exp-bibtex
;;         ;; org-mew
;;         ;; org-mhe
;;         ;; org-rmail
;;         ;; org-vm
;;         org-wl
;;         org-mouse
;;         org-latex
;;         ; Recognize any special blocks in Latex and HTML. For instance "#+begin_lala ..."
;;         org-special-blocks
;;         ))

;; This is always required
(require 'org)


;; ;; For some reason I have to reload-org mode to get the correct version in
;; ;; Emacs 23
;; (if (or (string-match emacs-version "23.3.1") (string-match emacs-version "23.1.50.1"))
;;     ;; If this is emacs 23 or emacs-snapshot we reload org-mode so
;;     ;; that it uses my compiled versiob instead or the built-in
;;     ;; version
;;     (org-reload)
;;     )
;; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx


;; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;; xxxxxxxxxxxxxxx Code added automatically by emacs xxxxxxxxxxxxxxxxxxxxxxx
;; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bmkp-last-as-first-bookmark-file "~/.emacs.d/bookmarks")
 '(custom-safe-themes
   (quote
    ("3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "d725097d2547e9205ab6c8b034d6971c2f0fc64ae5f357b61b7de411ca3e7ab2" "2a86b339554590eb681ecf866b64ce4814d58e6d093966b1bf5a184acf78874d" "8022cea21aa4daca569aee5c1b875fbb3f3248a5debc6fc8cf5833f2936fbb22" "e3c90203acbde2cf8016c6ba3f9c5300c97ddc63fcb78d84ca0a144d402eedc6" "a0fdc9976885513b03b000b57ddde04621d94c3a08f3042d1f6e2dbc336d25c7" "c63bee436bd8a67f6d9cd96acd5720c4a949c169f09c6850c439751f14fd923e" default)))
 '(ecb-options-version "2.40")
 '(package-selected-packages
   (quote
    (helm-gtags ggtags company-c-headers smart-mode-line package-build shut-up epl git commander f dash s gscholar-bibtex base16-theme irony-eldoc flycheck-irony indent-guide hydra ace-jump-mode anaconda-mode auctex company dired-details flycheck git-commit-mode git-rebase-mode irony magit yasnippet company-irony image-dired+ helm helm-swoop yaml-mode w3m virtualenvwrapper vc-check-status unfill undo-tree ucs-utils thesaurus tabulated-list string-utils ssh-config-mode regex-tool rebox2 realgud rainbow-mode pos-tip pdf-tools paradox oauth2 nose nlinum naquadah-theme multiple-cursors multi move-text math-symbol-lists markdown-mode makefile-runner magit-popup magit-filenotify jinja2-mode jedi imenu+ iedit highlight-symbol hideshowvis goto-last-change gnuplot gitignore-mode gitconfig-mode git-timemachine git-gutter fringe-helper emacs-eclim elpy ein ecb ebib discover-my-major dired-details+ diminish cython-mode cppcheck company-inf-python company-auctex company-anaconda comment-dwim-2 coffee-mode cmake-mode cask button-lock buffer-move bookmark+ bbyac badger-theme anzu anaphora ace-window ace-isearch ac-dabbrev)))
 '(paradox-automatically-star t)
 '(safe-local-variable-values
   (quote
    ((reftex-default-bibliography "../../Bib_files/UFC42_References.bib" "../../Bib_files/FullNames.bib")
     (reftex-default-bibliography "../../UFC42_References.bib" "../../FullNames.bib")
     (user-mail-address function stringp)
     (reftex-default-bibliography quote
                                  ("./references.bib"))
     (org-attach-directory function stringp)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx



;; xxxxx Emacs Initialization using Org-mode and babel xxxxxxxxxxxxxxxxxxxx
;; Load up Org Mode and (now included) Org Babel for elisp embedded in Org
;; Mode files
(setq dotfiles-dir (file-name-directory (or (buffer-file-name) load-file-name)))

;; load up all literate org-mode files in this directory
(mapc #'org-babel-load-file (directory-files dotfiles-dir t "\\.org$"))
;; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

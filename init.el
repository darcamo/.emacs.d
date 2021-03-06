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



;; Wrap all my Emacs initialization in this let to set
;; file-name-handler-alist to nil during initialization.
(let (
      ;; file-name-handler-alist Contains a list of regexes that Emacs run
      ;; on EACH file load. During initialization Emacs load a lot of files
      ;; and running those regexes on each of them takes time. Here we set
      ;; file-name-handler-alist to nil to avoid that cost.
      (file-name-handler-alist
       ;;'(("\\.gpg\\(~\\|\\.~[0-9]+~\\)?\\'" . epa-file-handler))
       nil
       )) 

;; Set the number of bytes of consing between garbage collections. The
;; default value is 800000. Here we set a larger value mainly to reduce gc
;; during Emacs initialization.
(setq gc-cons-threshold 10000000)

;; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;; xxxxxxxxxxxxxxx Emacs Packages xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
(setq package-enable-at-startup nil)
(with-eval-after-load "package"
  ;; (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
  ;; (add-to-list 'package-archives '("ELPA" . "http://tromey.com/elpa/"))
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
  ;; (add-to-list 'package-archives '("elpy" . "https://jorgenschaefer.github.io/packages/"))
  ;;(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
  )
(package-initialize)

;; xxxxxxxxxx Load CEDET xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;; you must place this *before* any CEDET component (including EIEIO) gets
;; activated by another package (Gnus, auth-source, ...).
;; (load-file "~/.emacs.d/lisp/cedet/cedet-devel-load.el")
;(load-file "/home/darlan/cvs_files/cedet/cedet-devel-load.el")

;; Use the more accurate parser for java-bsh-read-java-expression-history
;; See http://emacs.stackexchange.com/questions/600/how-to-diagnose-why-semantic-imenu-does-not-correctly-parse-a-file
(autoload 'wisent-java-default-setup "semantic/wisent/java")
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



;; xxxxx Emacs Initialization using Org-mode and babel xxxxxxxxxxxxxxxxxxxx
;; Load up Org Mode and (now included) Org Babel for elisp embedded in Org
;; Mode files
(setq dotfiles-dir (file-name-directory (or (buffer-file-name) load-file-name)))

;; load up all literate org-mode files in this directory
(mapc #'org-babel-load-file (directory-files dotfiles-dir t "\\.org$"))
;; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

)  ;; End of the let statement that contains everything



;; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;; xxxxxxxxxxxxxxx Code added automatically by emacs xxxxxxxxxxxxxxxxxxxxxxx
;; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-command-style
   (quote
    (("" "%(PDF)%(latex) -shell-escape %(file-line-error) %(extraopts) %S%(PDFout)"))))
 '(bmkp-last-as-first-bookmark-file "~/.emacs.d/bookmarks")
 '(custom-safe-themes
   (quote
    ("3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default)))
 '(ecb-options-version "2.40")
 '(ede-project-directories t)
 '(elpy-modules
   (quote
    (elpy-module-company elpy-module-eldoc elpy-module-pyvenv elpy-module-yasnippet elpy-module-sane-defaults)))
 '(elpy-test-runner (quote elpy-test-nose-runner))
 '(helm-external-programs-associations (quote (("pdf" . "evince"))))
 '(org-trello-current-prefix-keybinding "C-c o" nil (org-trello))
 '(package-selected-packages
   (quote
    (fontawesome modern-cpp-font-lock pytest magithub esqlite edit-server conda go-mode helm-mu fm-bookmarks fmbookmarks all-the-icons neotree volatile-highlights ag helm-ag helm-gtags stickyfunc-enhance flycheck-cython-autoloads flycheck-cython live-py-mode string-utils matlab-mode company-web org-trello hindent flycheck-haskell haskell-mode swiper emmet-mode pip-requirements company-irony-c-headers pdf-tools ace-mc csv-mode which-key highlight-numbers jdee helm-unicode firestarter java-snippets helm-pages page-break-lines ob-ipython use-package web-beautify json-reformat company-edbi edbi edbi-sqlite rainbow-delimiters lorem-ipsum sqlup-mode sql-indent company-tern skewer-mode web-mode expand-region helm-projectile projectile emacs-eclim indent-guide avy helm highlight-indentation magit markdown-mode multiple-cursors pyvenv helm-bibtex ggtags smart-mode-line epl f dash s base16-theme irony-eldoc flycheck-irony hydra ace-jump-mode auctex company dired-details flycheck irony image-dired+ helm-swoop yaml-mode vc-check-status unfill undo-tree thesaurus tabulated-list ssh-config-mode rainbow-mode nose move-text makefile-runner magit-popup iedit highlight-symbol goto-last-change gnuplot gitignore-mode gitconfig-mode git-timemachine git-gutter elpy ebib discover-my-major dired-details+ diminish cython-mode cppcheck company-inf-python company-auctex comment-dwim-2 cmake-mode buffer-move bookmark+ anzu ace-window)))
 '(safe-local-variable-values
   (quote
    ((eval rainbow-mode t)
     (abbrev-file-name . "customabbrev_defs")
     (pyvenv-workon . pyphysim)
     (eval read-abbrev-file
           (fullpath-relative-to-current-file "customabbrev_defs"))
     (engine . jinja)
     (user-mail-address . "darlan@gtel.ufc.br")
     (org-attach-directory . "data/Doutorado")
     (reftex-default-bibliography "../../Bib_files/UFC42_References.bib" "../../Bib_files/FullNames.bib")
     (reftex-default-bibliography "../../UFC42_References.bib" "../../FullNames.bib")
     (user-mail-address function stringp)
     (reftex-default-bibliography quote
                                  ("./references.bib"))
     (org-attach-directory function stringp)
     (firestarter . tex-all))))
 '(send-mail-function (quote mailclient-send-it)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

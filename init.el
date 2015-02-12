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




;; xxxxx Emacs Initialization using Org-mode and babel xxxxxxxxxxxxxxxxxxxx
;; Load up Org Mode and (now included) Org Babel for elisp embedded in Org
;; Mode files
(setq dotfiles-dir (file-name-directory (or (buffer-file-name) load-file-name)))

;; load up all literate org-mode files in this directory
(mapc #'org-babel-load-file (directory-files dotfiles-dir t "\\.org$"))
;; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx



;; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-source-correlate-mode t)
 '(ansi-color-names-vector
   ["black" "#E2434C" "#86B187" "#E0D063" "#84C452" "#E18CBB" "#8AC6F2" "white"])
 '(bmkp-last-as-first-bookmark-file "~/.emacs.d/bookmarks")
 '(custom-safe-themes
   (quote
    ("ad9fc392386f4859d28fe4ef3803585b51557838dbc072762117adad37e83585" "1c6c7d5e4beaec0a54d814454106d180de7b90f8961d3edd2f6567f7c08da97e" "6449a21695482b9d06c72f021fedc962a43cf4946d099fb0e8336ba80ff5c481" "b70add6fd9fa2079b059a5c7a034384f2014b3c4f447765c522483d095d24433" "e8ff60c7811d4532ee9f756b654d2f13d455e04851ee60c5e033e1b6a17e968f" default)))
 '(ecb-options-version "2.40")
 '(elpy-test-runner (quote elpy-test-nose-runner))
 '(load-home-init-file t t)
 '(org-modules
   (quote
    (org-bbdb org-bibtex org-crypt org-docview org-habit org-id org-info org-mouse org-w3m)))
 '(package-selected-packages
   (quote
    (ace-isearch anzu ace-window ace-jump-mode bbyac yaml-mode w3m virtualenvwrapper vc-check-status unfill undo-tree ucs-utils thesaurus tabulated-list string-utils ssh-config-mode regex-tool rebox2 realgud rainbow-mode pos-tip pdf-tools paradox oauth2 nose nlinum naquadah-theme multiple-cursors multi move-text math-symbol-lists markdown-mode makefile-runner magit-popup magit-filenotify jinja2-mode jedi imenu+ image-dired+ iedit highlight-symbol hideshowvis helm goto-last-change gnuplot gitignore-mode gitconfig-mode git-timemachine git-gutter fringe-helper flycheck-pos-tip emacs-eclim elpy ein ecb ebib discover-my-major dired-details+ diminish cython-mode cppcheck company-inf-python company-auctex company-anaconda comment-dwim-2 coffee-mode cmake-mode cask button-lock buffer-move bookmark+ badger-theme anaphora ac-dabbrev)))
 '(safe-local-variable-values
   (quote
    ((ispell-local-dictionary . brasileiro)
     (flycheck-checker . python-pylint)
     (user-mail-address . "darlan@gtel.ufc.br")
     (org-attach-directory . "data/Doutorado")
     (TeX-master . t)
     (TeX-PDF-mode . t)
     (boxquote-side . "! "))))
 '(send-mail-function (quote smtpmail-send-it)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

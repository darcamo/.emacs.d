;;; init.el --- Where all the magic begins
;;
;; This file loads Org-mode and then loads the rest of our Emacs
;; initialization from Emacs lisp embedded in literate Org-mode files.




;; xxxxxxxxxx Tell you how long .emacs takes to load xxxxxxxxxxxxxxxxxxxxxx
;; A funtion for that is already implemented in emacs.
;; Just call the emacs-init-time function 
;; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

(require 'cl)

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
(setq org-modules
      '(org-bbdb
        org-gnus
        org-info
        org-jsinfo
        org-irc
        org-w3m
        org-id
        org-habit
        org-bibtex
        org-exp-bibtex
        org-mew
        org-mhe
        org-rmail
        org-vm
        org-wl
        org-mouse
        org-latex
        ; Recognize any special blocks in Latex and HTML. For instance "#+begin_lalala ... "
        org-special-blocks
        ))

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
 '(blink-cursor-mode nil)
 '(bmkp-last-as-first-bookmark-file "~/.emacs.d/bookmarks")
 '(column-number-mode t)
 '(custom-safe-themes
   (quote
    ("6449a21695482b9d06c72f021fedc962a43cf4946d099fb0e8336ba80ff5c481" "b70add6fd9fa2079b059a5c7a034384f2014b3c4f447765c522483d095d24433" "e8ff60c7811d4532ee9f756b654d2f13d455e04851ee60c5e033e1b6a17e968f" default)))
 '(ecb-options-version "2.40")
 '(ede-project-directories
   (quote
    ("/home/darlan/cvs_files/pyphysim2" "/home/darlan/cvs_files/factors")))
 '(load-home-init-file t t)
 '(paradox-automatically-star t)
 '(safe-local-variable-values
   (quote
    ((TeX-PDF-mode . "editor.tex")
     (reftex-default-bibliography quote
                                  ("./referenc.bib"))
     (reftex-default-bibliography quote
                                  ("../UFC35_TR01_References.bib"))
     (eval read-abbrev-file
           (fullpath-relative-to-current-file "customabbrev_defs"))
     (reftex-default-bibliography quote
                                  ("./UFC35_TR01_References.bib"))
     (user-mail-address . "darlan@gtel.ufc.br")
     (reftex-default-bibliography quote
                                  ("./references.bib"))
     (reftex-default-bibliography . "references.bib")
     (org-attach-directory . "data/Doutorado")
     (org-attach-directory . data/Doutorado)
     (TeX-master . "UFC32_TR02_WP2_Main.tex")
     (TeX-master . "UFC32_TR01_WP2_Main.tex")
     (TeX-master . t)
     (TeX-PDF-mode . t)
     (py-master-file . "dof_pyqt4.py")
     (ispell-dictionary . brasileiro)
     (comment-start . %)
     (boxquote-side . "! ")
     (ispell-local-dictionary . brasileiro))))
 '(send-mail-function (quote smtpmail-send-it))
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

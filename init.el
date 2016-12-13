(require 'package)
(add-to-list 'package-archives
         '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)

(when (not package-archive-contents)
    (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(add-to-list 'load-path "~/.emacs.d/custom")

(require 'setup-general)
(if (version< emacs-version "24.4")
    (require 'setup-ivy-counsel)
  (require 'setup-helm)
  (require 'setup-helm-gtags))
;; (require 'setup-ggtags)
(require 'setup-cedet)
(require 'setup-editing)



;; function-args
;; (require 'function-args)
;; (fa-config-default)
;; (define-key c-mode-map  [(tab)] 'company-complete)
;; (define-key c++-mode-map  [(tab)] 'company-complete)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (elpy org sr-speedbar function-args zygospore helm-gtags helm yasnippet ws-butler volatile-highlights use-package undo-tree iedit dtrt-indent counsel-projectile company clean-aindent-mode anzu))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; zygospore - reversible C-x 1 (delete-other-windows)
;; helm-gtags - 
;; helm - 
;; yasnippet - expands abbreviations into templates
;; ws-butler - an unobtrusive way to trim spaces from end of line
;; volatile-highlights - highlights changes to the buffer caused by commands
;; use-package - a macro for setting up packages in .emacs
;; undo-tree - visualizer for an undo in undo-tree-mode
;; iedit - interactive, multi-occurence editing in the buffer
;; dtrt-indent - guesses indentation and adjusts corresponding settings
;; counsel-projectile - navigate projects
;; company - modular in-buffer completion mechanism (drop down completion menu)
;; clean-aindent-mode - auto-indent (RET), unindent (M-backspace), and more.
;; anzu - search and replace functionality

;Change how backups are saved
(defvar --backup-directory (concat user-emacs-directory "backups"))
(if (not (file-exists-p --backup-directory))
        (make-directory --backup-directory t))
(setq backup-directory-alist `(("." . ,--backup-directory)))
(setq make-backup-files t               ; backup of a file the first time it is saved.
      backup-by-copying t               ; don't clobber symlinks
      version-control t                 ; version numbers for backup files
      delete-old-versions t             ; delete excess backup files silently
      delete-by-moving-to-trash t
      kept-old-versions 6               ; oldest versions to keep when a new numbered backup is made (default: 2)
      kept-new-versions 9               ; newest versions to keep when a new numbered backup is made (default: 2)
      auto-save-default t               ; auto-save every buffer that visits a file
      auto-save-timeout 20              ; number of seconds idle time before auto-save (default: 30)
      auto-save-interval 200            ; number of keystrokes between auto-saves (default: 300)
      )

;Make sure syntax highlighting works for yaml, and launch files
(add-to-list 'load-path "~/.emacs.d/lisp/")
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("makefile$" . makefile-mode))
(add-to-list 'auto-mode-alist '("Makefile$" . makefile-mode))
(add-to-list 'auto-mode-alist '("\\.launch" . xml-mode))

(autoload 'markdown-mode "markdown-mode" "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;Syntax highlighting (and more!) for matlab files
(add-to-list 'load-path "~/.emacs.d/lisp/matlab-emacs/")
(load-library "matlab-load")
;; Enable CEDET feature support for MATLAB code. (Optional)
(matlab-cedet-setup)

;Use ibuffer!
(global-set-key (kbd "C-x C-b") 'ibuffer)

; Enable neotree (f8 to toggle)
(add-to-list 'load-path "~/.emacs.d/lisp/neotree/")
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

; Use the zenburn theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'zenburn t)

; Setup org-mode
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

; Change the default font-size for the gui
(set-face-attribute 'default nil :height 110)
(put 'narrow-to-region 'disabled nil)

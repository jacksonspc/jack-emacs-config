(menu-bar-mode -1)
(tool-bar-mode -1)
(toggle-scroll-bar -1)
;; Use-Package (require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))

(package-refresh-contents)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
  (eval-when-compile
    (require 'use-package))



(setq use-package-always-ensure t)
(use-package evil
  :init
  (evil-mode 1))


;; Theme
(use-package atom-one-dark-theme)
(load-theme 'atom-one-dark t)

;; Fonts
(set-face-attribute 'default nil :font "Fira Code" :weight 'medium)
;; Mode Line
(use-package doom-modeline
  :hook (after-init . doom-modeline-mode))

(use-package all-the-icons)

;; Dashboard
(use-package dashboard)
(dashboard-setup-startup-hook)


;; keys
(global-set-key (kbd "M-v") 'clipboard-yank)

;;Helm
(use-package ivy)
(ivy-mode)

;; important functions
(load-file "~/.emacs.d/proj.el")
(defun proj ()
  (load-file "~/.emacs.d/proj.el")
  (interactive)
  (setq projsel (completing-read "Choose a project: " projlist))
  (find-file projsel))
(defun proj-add ()
  (interactive)
  (setq newproj (read-file-name ""))
  (append-to-file (concat "\(add-to-list \'projlist \"" (concat newproj "\"\)")) nil "~/.emacs.d/proj.el"))
  


;; org


(setq org-src-preserve-indentation nil
      org-src-tab-acts-natively t 
      org-edit-src-content-indentation 0)

(setq org-startup-indented t)
(use-package org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(magit which-key helm-lsp lsp-ui lsp-mode company powershell use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;; Langs
(use-package powershell)
;;; Completions
(use-package company
  :init
  (add-hook 'after-init-hook 'global-company-mode))
(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (python-mode . lsp)
         (powershell-mode . lsp)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

;; optionally
(use-package lsp-ui :commands lsp-ui-mode)
;; if you are helm user
(use-package helm-lsp :commands helm-lsp-workspace-symbol)

;; optional if you want which-key integration
(use-package which-key
    :config
    (which-key-mode))
;; git
(use-package magit)


;; jt-abbrev
(clear-abbrev-table powershell-mode-abbrev-table)
(define-abbrev-table 'powershell-mode-abbrev-table
  '(
    ("fn" "function ")
    ("m" "match")
    ("i" "if \(")
    ("gp" "Get-Process")
    ("cfsd" "ConvertFrom-StringData")
    ("im" "Import-Module")
    ("p" "param")))




(set-default 'abbrev-mode t)

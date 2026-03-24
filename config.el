(setq user-full-name "Omar Mohamed"
      user-mail-address "omarcoptan9@gmail.com")

(add-to-list 'auto-mode-alist '("\\.ya?ml\\'" . yaml-mode))

(map! :leader
      :desc "Yank to clipboard"           "y" "\"+y"
      :desc "Delete to clipboard"         "d" "\"+d"
      :desc "Paste from clipboard"        "p" #'clipboard-yank)

(evil-define-key 'insert global-map (kbd "C-v") 'clipboard-yank)

(map! :leader
      (:prefix ("t" . "Toggle")
       :desc "Toggle vterm split"         "v" #'+vterm/toggle
       :desc "Toggle treemacs"            "t" #'+treemacs/toggle
       :desc "Toggle eshell"              "e" #'+eshell/toggle))

(map! :leader
      (:prefix ("o" . "Open")
       :desc "Open vterm here"            "v" #'+vterm/here
       :desc "Open eshell here"           "e" #'+eshell/here))

;; (setq doom-theme 'tron-legacy) ;; doom theme
(setq doom-theme 'doom-nord) ;; doom theme
(setq doom-font (font-spec :family "IBM Plex Mono" :size 16)) ;; doom font
(setq display-line-numbers-type 'relative) ;; relative numbers
(setq confirm-kill-emacs nil) ;; don't confirm on emacs exit

(when (eq system-type 'android)
  (setq explicit-shell-file-name "/data/data/com.termux/files/usr/bin/fish")
  (setq vterm-shell "/data/data/com.termux/files/usr/bin/fish"))

(setq org-directory "~/docs/notes/org/")
(setq org-modern-table-vertical 1)
(setq org-modern-table t)
(add-hook 'org-mode-hook #'hl-todo-mode)
(add-hook 'org-mode-hook (lambda() (org-bullets-mode 1)))

(when (getenv "WAYLAND_DISPLAY")
  ;; Fix "The kill is not a (set of) trees" and clipboard hangs on PGTK/Wayland
  (setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))
  ;; Ensure the coding system is strictly UTF-8 for clipboard operations
  (set-selection-coding-system 'utf-8))

(setq tramp-use-ssh-controlmaster-options nil)
(customize-set-variable 'tramp-ssh-controlmaster-options
                        "-o ControlMaster=auto -o ControlPath='tramp.%%r@%%h:%%p' -o ControlPersist=yes")

(after! corfu
  (setq corfu-auto t
        corfu-auto-delay 0.0
        corfu-auto-prefix 1)

  ;; Merge snippets into the completion list
  (add-hook 'lsp-mode-hook
            (lambda ()
              (setq-local completion-at-point-functions
                          (list (cape-capf-super
                                 #'lsp-completion-at-point
                                 #'yasnippet-capf
                                 #'cape-file))))))

(use-package! dashboard
  :init
   (setq initial-buffer-choice 'dashboard-open)
   (setq doom-fallback-buffer-name "*dashboard*")
   (add-hook 'doom-enter-frame-hook #'dashboard-open)
   (setq dashboard-startup-banner 'logo)
   (setq dashboard-banner-logo-title "Greetings, hack!")
   (setq dashboard-set-heading-icons t)
   (setq dashboard-footer-icon "☠")
   (setq dashboard-footer-messages '("Eat, Sleep, Hack, Repeat..."))
   (setq initial-scratch-message nil)
  :config
   (dashboard-setup-startup-hook))

(setq evil-default-cursor 'box
      evil-normal-state-cursor 'box
      evil-insert-state-cursor 'box
      evil-visual-state-cursor 'box
      evil-vsplit-window-right t
      evil-split-window-below t
      select-enable-clipboard nil
      select-enable-primary nil
      evil-undo-system 'undo-redo)

(after! flycheck
  (setq flycheck-idle-change-delay 0.1))

(after! lsp-mode
  (setq lsp-idle-delay 0.1
        lsp-completion-enable-additional-text-edit t
        lsp-modeline-code-actions-enable t
        lsp-auto-guess-root t))

(after! solaire-mode
  (custom-set-faces!
    `(solaire-default-face :background ,(doom-color 'bg))))

(add-to-list 'default-frame-alist '(undecorated . t))
(setq scroll-margin 8)

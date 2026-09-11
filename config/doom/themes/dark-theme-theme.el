;;; dark-theme-theme.el --- One Dark Dark for Emacs
(deftheme dark-theme "One Dark Dark theme ported from Neovim")

(let ((bg "#000000")
      (fg "#abb2bf")
      (red "#ef596f")
      (orange "#d19a66")
      (yellow "#e5c07b")
      (green "#89ca78")
      (cyan "#2bbac5")
      (blue "#61afef")
      (purple "#d55fde")
      (gray "#434852")
      (comment "#7f848e")
      (cursorline "#0a0a0a")
      (selection "#1a1a2e")
      (line-number "#495162"))

  (custom-theme-set-faces
   'dark-theme
   
   ;; Core faces
   `(default ((t (:background ,bg :foreground ,fg))))
   `(cursor ((t (:background ,blue))))
   `(region ((t (:background ,selection))))
   `(hl-line ((t (:background ,cursorline))))
   `(line-number ((t (:foreground ,line-number))))
   `(line-number-current-line ((t (:foreground ,blue :weight bold))))
   
   ;; Syntax highlighting
   `(font-lock-comment-face ((t (:foreground ,comment))))
   `(font-lock-string-face ((t (:foreground ,green))))
   `(font-lock-keyword-face ((t (:foreground ,purple))))
   `(font-lock-function-name-face ((t (:foreground ,blue))))
   `(font-lock-variable-name-face ((t (:foreground ,red))))
   `(font-lock-type-face ((t (:foreground ,yellow))))
   `(font-lock-builtin-face ((t (:foreground ,cyan))))
   `(font-lock-constant-face ((t (:foreground ,orange))))
   
   ;; UI elements
   `(mode-line ((t (:background ,gray :foreground ,fg :box nil))))
   `(mode-line-inactive ((t (:background "#1a1a1a" :foreground ,gray :box nil))))
   `(minibuffer-prompt ((t (:foreground ,blue :weight bold))))
   `(vertical-border ((t (:foreground ,gray))))
   `(fringe ((t (:background ,bg :foreground ,gray))))
   
   ;; Search/highlighting
   `(isearch ((t (:background ,yellow :foreground ,bg :weight bold))))
   `(lazy-highlight ((t (:background ,selection :foreground ,fg))))
   
   ;; Diffs
   `(diff-added ((t (:foreground ,green :background "#0a2f0a"))))
   `(diff-removed ((t (:foreground ,red :background "#2f0a0a"))))
   `(diff-changed ((t (:foreground ,yellow :background "#2f2a0a"))))
   
   ;; Org mode
   `(org-code ((t (:foreground ,cyan :background "#1a1a2e"))))
   `(org-block ((t (:background "#1a1a2e"))))
   `(org-block-begin-line ((t (:foreground ,comment :background "#1a1a2e"))))
   `(org-block-end-line ((t (:foreground ,comment :background "#1a1a2e"))))
   ))

(provide-theme 'dark-theme)
;;; dark-theme-theme.el ends here


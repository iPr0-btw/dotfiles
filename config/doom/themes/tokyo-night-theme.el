;;; tokyo-night-oled-theme.el --- Tokyo Night OLED for Emacs
(deftheme tokyo-night-oled "a boring OLED tokyonight theme")

(let ((bg "#000000")
      (fg "#c0caf5")
      (pink "#D07E9A")
      (red "#f7768e")
      (orange "#ff9e64")
      (yellow "#e0af68")
      (green "#9ece6a")
      (cyan "#7aa2f7")
      (blue "#7aa2f7")
      (purple "#bb9af7")
      (gray "#545c7e")
      (gray-dark "#414868")
      (comment "#D07E9A")
      (cursorline "#0a0a0a")
      (selection "#1a1a2e")
      (line-number "#3b4261"))

  (custom-theme-set-faces
   'tokyo-night-oled
   
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
   `(font-lock-function-name-face ((t (:foreground ,cyan))))
   `(font-lock-variable-name-face ((t (:foreground ,pink))))
   `(font-lock-type-face ((t (:foreground ,yellow))))
   `(font-lock-builtin-face ((t (:foreground ,orange))))
   `(font-lock-constant-face ((t (:foreground ,orange))))
   
   ;; UI elements
   `(mode-line ((t (:background ,bg :foreground ,fg :box nil))))
   `(mode-line-inactive ((t (:background "#0a0a0a" :foreground ,gray :box nil))))
   `(minibuffer-prompt ((t (:foreground ,cyan :weight bold))))
   `(vertical-border ((t (:foreground ,gray-dark))))
   `(fringe ((t (:background ,bg :foreground ,gray))))
   
   ;; Search/highlighting
   `(isearch ((t (:background ,yellow :foreground ,bg :weight bold))))
   `(lazy-highlight ((t (:background ,selection :foreground ,fg))))
   
   ;; Diffs
   `(diff-added ((t (:foreground ,green :background "#0a2f0a"))))
   `(diff-removed ((t (:foreground ,red :background "#2f0a0a"))))
   `(diff-changed ((t (:foreground ,yellow :background "#2f2a0a"))))
   
   ;; Org mode
   `(org-code ((t (:foreground ,cyan :background "#0a0a0a"))))
   `(org-block ((t (:background "#0a0a0a"))))
   `(org-block-begin-line ((t (:foreground ,comment :background "#0a0a0a"))))
   `(org-block-end-line ((t (:foreground ,comment :background "#0a0a0a"))))
   ))

(provide-theme 'tokyo-night-oled)
;;; tokyo-night-oled-theme.el ends here


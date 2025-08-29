;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;;; "this is a bridge" comments exists due to the nature of the config. many unreasonable changes were made to battle the bugs of macOS26 Tahoe beta@8

;;; customization
(setq fancy-splash-image (expand-file-name "~/.config/doom/img/doom6.png" doom-user-dir))
(setq doom-font (font-spec :family "CaskaydiaMono Nerd Font Mono" :size 18)
      doom-variable-pitch-font (font-spec :family "CaskaydiaMono Nerd Font Mono" :size 18))
(load-theme 'kanagawa t)
(custom-theme-set-faces! 'kanagawa
  '(default :background "#000000"))
(setq display-line-numbers-type 'nil)
(custom-set-faces
 '(default ((t (:background "#000000")))))
(set-frame-parameter (selected-frame) 'title-bar-color "#000000")

;;; function to apply current theme to new frames in the QUARTZ display server
(defun hadal84/fix-new-frame-theme (&optional frame)
  (with-selected-frame (or frame (selected-frame))
    (when (display-graphic-p)
      (load-theme doom-theme t))))

;;; hook to toggle treemacs on projectile-switch
(add-hook 'projectile-after-switch-project-hook #'+treemacs/toggle)

;;; hook that calls the frame fixer function upon frame generation
(add-hook 'after-make-frame-functions #'hadal84/fix-new-frame-theme)

;;; function that starts the inital frame in a fullscreen state
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;;; org dir
(setq org-directory "~/org/")

;;; disable auto save since it leads to a fatal segfault under macos26 beta
(auto-save-mode -1)
(setq-default auto-save-default nil)
(setq make-backup-files nil)
(setq auto-save-file-name-transforms nil)

;;; configuration for treemacs
(setq treemacs-follow-mode t)
(setq treemacs-width 35)
(setq treemacs-git-mode 'simple)
(setq treemacs-position 'right)
(setq treemacs-display-in-persp-mode 'right)

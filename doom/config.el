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

;;; do not prompt when exiting emacs
(setq confirm-kill-emacs nil)

;;; platformio support for the burnt-out phoenix
(use-package! platformio-mode
  ;; This part correctly activates the mode in PlatformIO projects
  :hook ((c-mode . platformio-conditionally-enable)
         (c++-mode . platformio-conditionally-enable))
  :config
  ;; This part defines the helper function that runs on file-open
  (defun platformio-conditionally-enable ()
    "Enable `platformio-mode' if `platformio.ini' exists in the project root."
    (when-let ((project-root (doom-project-root)))
      (when (file-exists-p (expand-file-name "platformio.ini" project-root))
        (platformio-mode 1))))

  (defun my-corrected-platformio-boards ()
    "Fetch the list of boards from PlatformIO and select one."
    (interactive)
    (let ((process-buffer (generate-new-buffer "*platformio-boards*")))
      (message "Fetching boards list from PlatformIO...")
      (async-start
       `(lambda () (shell-command-to-string "platformio boards --json-output"))
       `(lambda (json-output)
          (let* ((data (json-read-from-string json-output))
                 (board-names (mapcar (lambda (board) (cdr (assoc 'name board))) data))
                 (selected-board (completing-read "Select board: " board-names)))
            (when (and selected-board (> (length selected-board) 0))
              (insert selected-board)
              (message "Inserted board: %s" selected-board)))))))

  (advice-add 'platformio-boards :override #'my-corrected-platformio-boards))

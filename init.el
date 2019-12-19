; Fix for 26.2
(if (version< emacs-version "26.2")
    (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3"))

(package-initialize)

(load "~/.emacs.d/packages")

; Make Emacs Happy
(custom-set-faces)
(setq custom-file "~/.emacs.d/package-selected-packages.el")
(load custom-file)
(put 'upcase-region 'disabled nil)

(add-hook 'org-mode-hook (lambda () (flyspell-mode) (visual-line-mode t)))
(add-hook 'markdown-mode-hook (lambda () (flyspell-mode) (visual-line-mode t)))
(add-hook 'c-mode-common-hook (lambda () (imenu-list-minor-mode)))
(add-hook 'python-mode-hook (lambda () (jedi:setup) (imenu-list-minor-mode)))

; Make Emacs look nicer
(menu-bar-mode 1)
(toggle-scroll-bar -1) 
(tool-bar-mode -1)
(setq inhibit-startup-screen t)
(setq-default left-fringe-width  3)
(setq-default right-fringe-width  3)
(setq visible-bell 1)
(set-frame-parameter (selected-frame) 'alpha '(80 . 80))
 (add-to-list 'default-frame-alist '(alpha . (80 . 80)))

; Custom theme
(let ((class '((class color) (min-colors 89)))
    (aqua-blue "#0288d1")
    (aqua-white "#ffffff")
    (aqua-light-blue "#b3e5fc"))
  (set-face-background 'mode-line aqua-blue)
  (set-face-foreground 'mode-line aqua-white)
  (set-face-attribute 'fringe nil :background aqua-blue :foreground aqua-blue)
  (eval-after-load "linum"
    '(set-face-attribute 'linum nil :height 140 :foreground "#0288d1"))
  (set-face-attribute 'mode-line nil
                    :background aqua-blue
                    :foreground aqua-white
                    :box '(:line-width 4 :color "#0288d1")
                    :overline nil
                    :underline nil)
  (set-face-attribute 'mode-line-inactive nil
                    :background aqua-white
                    :foreground aqua-blue
                    :box '(:line-width 4 :color "#ffffff")
                    :overline nil
                    :underline nil))

(define-globalized-minor-mode aqua-mode rainbow-mode
  (lambda () (rainbow-mode 1)))

(aqua-mode 1)

; Fonts
(add-to-list 'default-frame-alist '(font . "inconsolata-13"))
(defun screenplayfont ()
  (add-to-list 'default-frame-alist '(font . "courierprime-12"))
)

; Enable Line Numbers
(global-linum-mode t)
(defun nolinum ()
  (global-linum-mode 0)
)

; Startup Window size
(add-to-list 'default-frame-alist '(width  . 120))
(add-to-list 'default-frame-alist '(height . 40))

; Spellcheck
(add-to-list 'exec-path "C:/Program Files/Hunspell/bin")
(if (string-equal system-type "windows-nt") (setq ispell-program-name "hunspell") '(setq ispell-program-name "aspell"))
(setq ispell-personal-dictionary "~/.emacs.d/.ispell")
(require 'ispell)

; Auto Complete
(ac-config-default)

; Right click for spelling corrections
(eval-after-load "flyspell"
  '(progn
     (define-key flyspell-mouse-map [down-mouse-3] #'flyspell-correct-word)
     (define-key flyspell-mouse-map [mouse-3] #'undefined)))

(global-set-key (kbd "M-s s") 'ispell-word)

; File backups
(setq backup-directory-alist `(("." . "~/.emacs.d/saves")))
(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)

; Line Number Formatting
;(setq linum-format "%4d")
(setq-default left-fringe-width  2)
(setq-default right-fringe-width  0)

; Windows navigation
(setq windmove-wrap-around t)
(global-set-key [?\C-\S-l] 'windmove-up)
(global-set-key [?\C-\S-k] 'windmove-down)
(global-set-key [?\C-\S-j] 'windmove-left)
(global-set-key [?\C-:] 'windmove-right)

; Automatically follow symbolic links
(setq vc-follow-symlinks t)

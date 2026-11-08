; This configuration targets Emacs 30.1 and newer.
(when (version< emacs-version "30.1")
  (error "This configuration requires Emacs 30.1 or newer"))

(load "~/.emacs.d/packages")

; Make Emacs Happy
(custom-set-faces)
(setq custom-file "~/.emacs.d/package-selected-packages.el")
(load custom-file)
(put 'upcase-region 'disabled nil)

(defun aqua-enable-flyspell ()
  "Enable Flyspell when a configured spellchecker is available."
  (when (and ispell-program-name
             (executable-find ispell-program-name))
    (flyspell-mode 1)))

(add-hook 'org-mode-hook (lambda () (aqua-enable-flyspell) (visual-line-mode t)))
(add-hook 'markdown-mode-hook (lambda () (aqua-enable-flyspell) (visual-line-mode t) (turn-on-olivetti-mode)))
(add-hook 'c-mode-common-hook (lambda() (imenu-add-to-menubar "Imenu")))
(add-hook 'python-mode-hook (lambda () (jedi:setup) (imenu-list-minor-mode)))

; Go lang
(add-hook 'go-mode-hook (lambda () (auto-complete-mode 1)))
(with-eval-after-load 'go-mode
   (require 'go-autocomplete))

; Make Emacs look nicer
(menu-bar-mode 1)
(toggle-scroll-bar -1) 
(tool-bar-mode -1)
(setq inhibit-startup-screen t)
(setq-default left-fringe-width  3)
(setq-default right-fringe-width  3)
(setq visible-bell 1)
(set-frame-parameter (selected-frame) 'alpha '(100 . 90))
 (add-to-list 'default-frame-alist '(alpha . (100 . 90)))

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
  "Use Courier Prime at 12 points in the current buffer only."
  (require 'face-remap)
  (face-remap-set-base 'default :family "Courier Prime" :height 120))

; Enable Line Numbers
(global-display-line-numbers-mode 1)
(defun nolinum ()
  "Disable line numbers in the current buffer only."
  (display-line-numbers-mode -1))

; Startup Window size
(add-to-list 'default-frame-alist '(width  . 120))
(add-to-list 'default-frame-alist '(height . 40))

; Spellcheck
(when (eq system-type 'windows-nt)
  (add-to-list 'exec-path "C:/Program Files/Hunspell/bin"))
(require 'ispell)
(setq ispell-program-name
      (or (executable-find "aspell")
          (executable-find "hunspell")))
(setq ispell-personal-dictionary "~/.emacs.d/.ispell")

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


(menu-bar-mode -1)
(menu-bar-mode 1)

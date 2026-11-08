; This configuration targets Emacs 30.1 and newer.
(when (version< emacs-version "30.1")
  (error "This configuration requires Emacs 30.1 or newer"))

(load (expand-file-name "packages.el" user-emacs-directory))

; Make Emacs Happy
(custom-set-faces)
(setq custom-file
      (expand-file-name "package-selected-packages.el" user-emacs-directory))
(load custom-file 'noerror 'nomessage)
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

; Screenplay writing
(dolist (function '(turn-on-olivetti-mode imenu-list-minor-mode
                    aqua-enable-flyspell nolinum screenplayfont))
  (add-hook 'fountain-mode-hook function t))

; Go lang
(add-hook 'go-mode-hook (lambda () (auto-complete-mode 1)))
(with-eval-after-load 'go-mode
   (require 'go-autocomplete))

; Make Emacs look nicer
(menu-bar-mode 1)
(toggle-scroll-bar -1) 
(tool-bar-mode -1)
(setq inhibit-startup-screen t)
(setq-default left-fringe-width 2
              right-fringe-width 0)
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
  (set-face-attribute 'line-number nil :height 140 :foreground aqua-blue)
  (set-face-attribute 'line-number-current-line nil
                      :height 140 :foreground aqua-blue)
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
(setq ispell-personal-dictionary
      (expand-file-name ".ispell" user-emacs-directory))

; Auto Complete
(ac-config-default)

; Right click for spelling corrections
(eval-after-load "flyspell"
  '(progn
     (define-key flyspell-mouse-map [down-mouse-3] #'flyspell-correct-word)
     (define-key flyspell-mouse-map [mouse-3] #'undefined)))

(global-set-key (kbd "M-s s") 'ispell-word)

; File backups
(setq backup-directory-alist
      `(("." . ,(expand-file-name "saves" user-emacs-directory))))
(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)

; Windows navigation
(setq windmove-wrap-around t)
(global-set-key [?\C-\S-l] 'windmove-up)
(global-set-key [?\C-\S-k] 'windmove-down)
(global-set-key [?\C-\S-j] 'windmove-left)
(global-set-key [?\C-:] 'windmove-right)

; Automatically follow symbolic links
(setq vc-follow-symlinks t)

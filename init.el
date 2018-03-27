(package-initialize)

(load "~/.emacs.d/packages")
 
(add-hook 'org-mode-hook (lambda () (flyspell-mode) (visual-line-mode t)))
(add-hook 'c-mode-common-hook (lambda () (imenu-list-minor-mode)))
(add-hook 'python-mode-hook 'jedi:setup)

; Make Emacs look nicer
(menu-bar-mode 1)
(toggle-scroll-bar -1) 
(tool-bar-mode -1)
(setq inhibit-startup-screen t)
(setq-default left-fringe-width  3)
(setq-default right-fringe-width  3)
(setq visible-bell 1)

(define-globalized-minor-mode aqua-mode rainbow-mode
  (lambda () (rainbow-mode 1)))

(aqua-mode 1)

; Fonts
(add-to-list 'default-frame-alist '(font . "inconsolata-11"))
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
(add-to-list 'exec-path "C:/Program Files (x86)/Aspell/bin/")
(setq ispell-program-name "aspell")
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

; Make Emacs Happy
(custom-set-faces)
(setq custom-file "~/.emacs.d/package-selected-packages.el")
(load custom-file)

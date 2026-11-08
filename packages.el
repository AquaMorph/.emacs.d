(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://stable.melpa.org/packages/") t)

; list the packages you want
(setq package-list
	'(fountain-mode imenu-list olivetti cyberpunk-theme flyspell ispell focus rainbow-mode auto-complete jedi markdown-mode vlf go-mode go-autocomplete))

; activate all the packages
(package-initialize)

; Run explicitly with M-x aqua-install-packages when setting up Emacs.
(defun aqua-install-packages ()
  "Refresh package archives and install missing configured packages."
  (interactive)
  (let ((missing-packages
         (delq nil (mapcar (lambda (package)
                            (unless (package-installed-p package)
                              package))
                          package-list))))
    (if missing-packages
        (progn
          (package-refresh-contents)
          (dolist (package missing-packages)
            (package-install package)))
      (message "All configured packages are already installed"))))

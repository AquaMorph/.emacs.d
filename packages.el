(when (>= emacs-major-version 24)
	(require 'package)
	(add-to-list 'package-archives
		     '("melpa" . "https://stable.melpa.org/packages/") t))

; list the packages you want
(setq package-list
	'(fountain-mode imenu-list olivetti cyberpunk-theme flyspell ispell focus rainbow-mode auto-complete jedi markdown-mode vlf))

; activate all the packages
(package-initialize)

; fetch the list of packages available 
(unless package-archive-contents
	(package-refresh-contents))

; install the missing packages
(dolist (package package-list)
	(unless (package-installed-p package)
		(package-install package)))

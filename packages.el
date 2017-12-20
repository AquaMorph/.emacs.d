(when (>= emacs-major-version 24)
	(require 'package)
	(add-to-list 'package-archives
		'("melpa" . "http://melpa.milkbox.net/packages/") t))

; list the packages you want
(setq package-list
	'(fountain-mode cyberpunk-theme))

; activate all the packages
(package-initialize)

; fetch the list of packages available 
(unless package-archive-contents
	(package-refresh-contents))

; install the missing packages
(dolist (package package-list)
	(unless (package-installed-p package)
		(package-install package)))

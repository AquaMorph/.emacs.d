(package-initialize)

(load "~/.emacs.d/packages")

(custom-set-variables
	'(ansi-color-faces-vector
		[default default default italic underline success warning error])
	'(ansi-color-names-vector
		["black" "red3" "ForestGreen" "yellow3" "blue" "magenta3" "DeepSkyBlue" "gray50"])
	'(custom-enabled-themes (quote (manoj-dark)))
	'(package-selected-packages (quote (olivetti fountain-mode cyberpunk-theme)))
	'(fountain-mode-hook (quote (turn-on-olivetti-mode imenu-list-minor-mode)))
)

(menu-bar-mode 1)
(toggle-scroll-bar -1) 
(tool-bar-mode -1)
(setq inhibit-startup-screen t) 

(custom-set-faces
 )



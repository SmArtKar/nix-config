# anyrun.nix

{ pkgs, inputs, lib, ... }:

# Anyrun runner and application launcher

{
  programs.anyrun = {
    enable = true;
    config = {
      x.fraction = 0.5;
      y.fraction = 0.3;
      width.fraction = 0.3;
      hidePluginInfo = true;
    
      plugins = with inputs.anyrun.packages.${pkgs.system}; [
        applications
        shell
        kidex
        stdin
        websearch
      ];
    };

    extraCss = ''
      /* Global settings */
      *{
	transition: 200ms ease;
	font-family: Consolas;
	font-size: 1.3rem;
      }
      
      /* Make it not occupy the entire window */
      #window {
        background: transparent;
      }
      
      #plugin,
      #main {
        border: 3px solid;
      };
      
      /* Text input window */
      #entry {
        border-radius: 16px;
      }

      /* Output entries */
      #match {
        padding: 3px;
	border-radius: 16px;
      }

      /* Selected/highlighted entry */
      #match:selected {

      }

      #plugin:hover {
        border-radius: 16px;
      }

      box#main {
        background: rgba(30, 30, 46, 0.7);
	border: 1px solid;
	border-radius 16px;
	padding: 5px;
      }

    '';
  };
}

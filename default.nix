let
    pkgs = import <nixpkgs> { };
in
    pkgs.stdenv.mkDerivation {
        name = "lpass-notifier";

        phases = [ "installPhase" "fixupPhase" ];

        inherit (pkgs) bash dbus;
        lastpass_cli = pkgs.lastpass-cli;
        dunst = pkgs.dunst.override { dunstify = true; };

        installPhase = ''
            mkdir -p "$out/bin"
            substituteAll "${./lpass-ui-auth}" "$out/bin/lpass-ui-auth"

            chmod +x "$out/bin/"*
        '';
    }

# Stock Ubuntu workhorse — standalone home-manager only (no NixOS).
# Built via `homeConfigurations` and `lib/mkhome.nix`.
# Apply with: home-manager switch --flake .#vermillion
{
  system = "x86_64-linux";
  user = "scott";
  homie = import ../homies/scott;

  # Host-specific home-manager config (on top of homie defaults).
  home =
    { pkgs, ... }:
    { };
}

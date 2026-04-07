{
  system = "x86_64-linux";
  user = "scott";
  homie = import ../homies/scott;

  home = { pkgs, ... }: { };
}

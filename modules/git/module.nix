{...}: {
  programs.git = {
    enable = true;
    userName = "Julien Lavocat";
    userEmail = "julien.lavocat@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };

    lfs = {
      enable = true;
    };
  };
}

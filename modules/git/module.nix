{...}: {
  programs.git = {
    enable = true;
    userName = "Julien Lavocat";
    userEmail = "julien.lavocat@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
    };

    lfs = {
      enable = true;
    };
  };
}

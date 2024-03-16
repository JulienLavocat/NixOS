{...}: {
  programs.git = {
    enable = true;
    userName = "Julien Lavocat";
    userEmail = "julien.lavocat@gmail.com";

    lfs = {
      enable = true;
    };
  };
}

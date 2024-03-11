{pkgs, ...}: {
  home.packages = with pkgs; [firefox];

  programs.firefox = {
    enable = true;

    profiles = {
      default = {
        id = 0;
        name = "default";
        isDefault = true;
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          bitwarden
          betterttv
          sponsorblock
          istilldontcareaboutcookies
        ];
      };
    };
  };
}

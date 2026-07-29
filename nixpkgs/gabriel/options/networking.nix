{
  networking = {
    firewall = {
      allowedTCPPortRanges = [
        {
          # For KDE Connect.
          from = 1714;
          to = 1764;
        }
      ];
      allowedUDPPortRanges = [
        {
          # For KDE Connect.
          from = 1714;
          to = 1764;
        }
      ];
    };
    networkmanager.enable = true;
  };
}

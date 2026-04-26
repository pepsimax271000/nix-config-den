{ pkgs, host, ... }:
{
  programs.foot = {
   enable = true;
   settings = {
     main = {
      pad = "0x0";
     };
   };
  };
}
